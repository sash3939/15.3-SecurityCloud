// Создаем сервисный аккаунт для backet
resource "yandex_iam_service_account" "sa-bucket" {
  name      = "sa-bucket"
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-editor" {
  cloud_id   = var.yandex_cloud_id
  role       = "storage.editor"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

// Создание статического ключа доступа
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa-bucket.id
  description        = "static access key for object storage"
}


resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-encrypter" {
  cloud_id   = var.yandex_cloud_id
  role       = "kms.keys.encrypter"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}

resource "yandex_resourcemanager_cloud_iam_member" "bucket-kms-decrypter" {
  cloud_id   = var.yandex_cloud_id
  role       = "kms.keys.decrypter"
  member     = "serviceAccount:${yandex_iam_service_account.sa-bucket.id}"
  depends_on = [ yandex_iam_service_account.sa-bucket ]
}


// Создание бакета с использованием ключа
resource "yandex_storage_bucket" "whatshappen-kms" {
  access_key            = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key            = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket                = var.bucket_name
  acl                   = "public-read"

  anonymous_access_flags {
    read = true
    list = true
    config_read = true
  }
  //Применяю ключ шифрования
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.secret-key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }   
}

// Add picture to bucket
resource "yandex_storage_object" "picture" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = yandex_storage_bucket.whatshappen-kms.bucket
#  bucket = var.bucket_name
  key    = "sea.jpg"
  source = "sea.jpg"
  acl = "public-read"
  depends_on = [yandex_storage_bucket.whatshappen-kms]
}
