Идея в том, чтобы инициализировать namespace и вместе с ним все дефолтные объекты.\ 
Каждый namespace принадлежит к какой-то команде.\
И к одному из кластеров.\
Мы связываем эти абстракции, описывая все созданные для команды \
namespaces с указанием кластера, на котором они будут созданы.

Имя кластера затем мапится в соответствующий terrafrom kubernetes proovider через alias.

Team -> Cluster -> Namespace Set

# REFS
- https://www.puppeteers.net/blog/terraform-resources-with-dynamic-provider-values/#:~:text=Terraform%20allows%20you%20to%20define,have%20to%20learn%20provider%20aliases. 
