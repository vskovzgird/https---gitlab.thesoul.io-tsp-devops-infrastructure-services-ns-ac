# Description
Проект для создания и управления Kubernetes namespace для команд разработчиков через Terraform

Для каждой команды отдельные пайпы дял каждого кластера, описанные в отдельном файле \
Для каждой команды свой GitLab TF State\
Для каждой команды одна директория (модуль в терминологии Terraform), в котором будут описаны все её неймспейсы \

Модуль `team` используется для создания реальных namespace команд.

# Структура
`modules` - папка с модулями
`.gitlab` - папка с ci файлами для gitlab-ci.yaml
Остальные папки в корне это команды и их namesapces.
Например, `devops` - команда devops, внутри одноименной папки описана инициализация всех namespaces команды на всех кластерах компании.

# TODO
- Как будет работать с существующими namespace? 
  выдаст ошибку Error: namespaces "test-2" already exists, остальное создаст
  НУЖНО ИМПОРТИРОВАТЬ В СТЕЙТ СУЩЕСТВУЮЩИЕ НЕЙМСПЕЙСЫ
  https://www.terraform.io/cli/commands/import
  Создать namespace на пустом кластере и натравить терраформ со своим списком namespace, в котором нет тех, что есть на кластере.

- Список кластеров - провайдеров терраформ с алиасами должен быть отдельнйо либой с версионированием - не реализуемо в Terrafrom, гурсть, печаль, тоска
- Сам модуль team так же должен быть версионирован
- Сохранить модули в terrafrom GitLab registry
- Аплоад в GitLab Terraform registry
- Использование GitLab Terraform state

# Публиц=кация модулей
https://docs.gitlab.com/ee/user/packages/terraform_module_registry/

# Setup Hetzner K8s cluster on Ubuntu 20.04
```bash
apt-get update
apt-get install     ca-certificates     curl     gnupg     lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
apt install conntrack
minikube start --driver=none --kubernetes-version=v1.19.9
ss -tlnp
minikube kubectl -- get pods -A
cat /root/.kube/config
minikube kubectl edit clusterrolebinding cluster-admin
- kind: ServiceAccount
  name: default
  namespace: default

minikube kubectl get secrets -- -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"|base64 --decode
```

чтобы импортировать в state несуществующий там, но существующий на кластере namespace с именем test-2 нужно \

- terraform.exe import 'module.team.kubernetes_namespace.namespace[\"test_env-test-2\"]' test-2 # WINDOWS POWERSHELL \
  terraform.exe import 'module.team.kubernetes_namespace.namespace["test_env-test-2"]' test-2 # LINUX SHELL \
  ID это test-2, так как если посмотреть в terraform.tfstate, как там обозначен namesapce test-3, то "id": "test-3" \
  "test-test-2" - это индекс, так как у нас for_each \
дальше раскоментируем test-2 в списке namespace команд и вызываем plan и смотрим, что нет ошибок, вызываем apply \
Видим, что в test-2 создалась zero-trust networkpolicy \
При импорте у меня была ошибка - я не верно указывал индекс - вместо test-2, я указывал test, \
а это индекс namespace с именем test \
Terraform считал, что я меняю test, а не создаю test-2 и пытался пересоздать namespace test, \
но падал с ошибкой Instance cannot be destroyed, так как на нём lifecycle \
Пробуем добавить аннотаций в test-2 перешедший под контроль TF.

# REFS
- https://www.puppeteers.net/blog/terraform-resources-with-dynamic-provider-values/#:~:text=Terraform%20allows%20you%20to%20define,have%20to%20learn%20provider%20aliases. 
- https://yellowdesert.consulting/2021/05/31/terraform-map-and-object-patterns/#untyped-nested-map !
- https://www.reddit.com/r/Terraform/comments/mwyb4p/trouble_with_nested_maps_in_for_each/
- https://www.terraform.io/language/functions/flatten

# Как поднимал 'локальный' кластер 
apt-get update
apt-get install     ca-certificates     curl     gnupg     lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
apt install conntrack
minikube start --driver=none --kubernetes-version=v1.19.9
ss -tlnp
minikube kubectl -- get pods -A
ls -la /root/.kube/
cat /root/.kube/config
minikube kubectl get secrets -- -o jsonpath="{.items[?(@.metadata.annotations['kubernetes\.io/service-account\.name']=='default')].data.token}"|base64 --decode
