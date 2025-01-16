# Домашнее задание к занятию «Безопасность в облачных провайдерах»  

Используя конфигурации, выполненные в рамках предыдущих домашних заданий, нужно добавить возможность шифрования бакета.

---
## Задание 1. Yandex Cloud   

1. С помощью ключа в KMS необходимо зашифровать содержимое бакета:

 - создать ключ в KMS;

<img width="1031" alt="kms" src="https://github.com/user-attachments/assets/16a6b6b8-02a2-4589-8490-cca5807a9f44" />

<img width="727" alt="bucket-kms" src="https://github.com/user-attachments/assets/19551b45-4f16-4700-9867-bd327dbe1dae" />
   
 - с помощью ключа зашифровать содержимое бакета, созданного ранее.

<img width="646" alt="encrypt" src="https://github.com/user-attachments/assets/334558ea-7f52-4cba-bd00-1220fa15e025" />

<img width="870" alt="common" src="https://github.com/user-attachments/assets/efb6a8db-aae7-43eb-a2d1-14608c9f0289" />

<img width="756" alt="encrypt-key" src="https://github.com/user-attachments/assets/0c294d41-22bc-479b-8aed-9c8a37d5b167" />
   
2. (Выполняется не в Terraform)* Создать статический сайт в Object Storage c собственным публичным адресом и сделать доступным по HTTPS:

 - создать сертификат;

 <img width="1022" alt="dns" src="https://github.com/user-attachments/assets/d946866c-d552-4fba-8c3b-28592938c06c" />

 <img width="692" alt="cert validation" src="https://github.com/user-attachments/assets/ce36b4bc-a19e-4506-a769-07ab2e802ffd" />

 <img width="496" alt="validated" src="https://github.com/user-attachments/assets/e6bc7a9b-f0c2-45e8-af98-afdf95e37772" />

 <img width="705" alt="cert apply" src="https://github.com/user-attachments/assets/84d870c3-b727-4733-aeef-8e1371a84bba" />

 <img width="732" alt="cert apply1" src="https://github.com/user-attachments/assets/77223704-53e3-4cad-9e74-a8986cfe6c46" />

 - создать статическую страницу в Object Storage и применить сертификат HTTPS;

 <img width="661" alt="static page" src="https://github.com/user-attachments/assets/4031dcaf-06ae-45f5-8883-1072004b4ff6" />

 - в качестве результата предоставить скриншот на страницу с сертификатом в заголовке (замочек).

 <img width="478" alt="https_page" src="https://github.com/user-attachments/assets/34d0a6ab-7d0c-4b64-956b-d857bc0b082c" />

 <img width="948" alt="https_page1" src="https://github.com/user-attachments/assets/ad60b2e9-9c59-42b1-83bf-46a19a6f2a94" />

Полезные документы:

- [Настройка HTTPS статичного сайта](https://cloud.yandex.ru/docs/storage/operations/hosting/certificate).
- [Object Storage bucket](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/storage_bucket).
- [KMS key](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/kms_symmetric_key).

--- 
## Задание 2*. AWS (задание со звёздочкой)

Это необязательное задание. Его выполнение не влияет на получение зачёта по домашней работе.

**Что нужно сделать**

1. С помощью роли IAM записать файлы ЕС2 в S3-бакет:
 - создать роль в IAM для возможности записи в S3 бакет;
 - применить роль к ЕС2-инстансу;
 - с помощью bootstrap-скрипта записать в бакет файл веб-страницы.
2. Организация шифрования содержимого S3-бакета:

 - используя конфигурации, выполненные в домашнем задании из предыдущего занятия, добавить к созданному ранее бакету S3 возможность шифрования Server-Side, используя общий ключ;
 - включить шифрование SSE-S3 бакету S3 для шифрования всех вновь добавляемых объектов в этот бакет.

3. *Создание сертификата SSL и применение его к ALB:

 - создать сертификат с подтверждением по email;
 - сделать запись в Route53 на собственный поддомен, указав адрес LB;
 - применить к HTTPS-запросам на LB созданный ранее сертификат.

Resource Terraform:

- [IAM Role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role).
- [AWS KMS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/kms_key).
- [S3 encrypt with KMS key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object#encrypting-with-kms-key).

Пример bootstrap-скрипта:

```
#!/bin/bash
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
aws s3 mb s3://mysuperbacketname2021
aws s3 cp index.html s3://mysuperbacketname2021
```

### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.
