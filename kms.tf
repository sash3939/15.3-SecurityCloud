// симметричный ключ шифрования с алгоритмом шифрования AES_128 и временем жизни 24 часа:
resource "yandex_kms_symmetric_key" "secret-key" {
  name              = "encrypt-key"
  description       = "ключ для шифрования бакета"
  default_algorithm = "AES_256"
  rotation_period   = "8760h"
}
