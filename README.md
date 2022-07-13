**/.terraform/*  -игнорирование содержимого каталога .terraform в любой поддиректории

*.tfstate  -игнорирование файлов с расширением .tfstate
*.tfstate.*  - игнорирование файлов, содержащих своем имени .tfstate

crash.log  -игнорирование файлов с именем crash.log
crash.*.log  --игнорирование файлов с именем crash.log, где между crash. и .log могут содержаться любое количество любых символов
*.tfvars  -игнорирование файлов с расширением . tfvars
*.tfvars.json  -игнорирование файлов с расширением . tfvars.json

override.tf  -игнорирование файлов с именем override.tf
override.tf.json  -игнорирование файлов с именем override.tf.json
*_override.tf  -игнорирование файлов с именем заканчивающимся на _override.tf
*_override.tf.json  -игнорирование файлов с именем заканчивающимся на _override.tf.json

.terraformrc  -игнорирование файлов с именем .terraformrc 
terraform.rc  -игнорирование файлов с именем terraform.rc
