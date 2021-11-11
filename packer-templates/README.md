# Build AMIs for Jenkins Master, Slave, Grafana and Prometheus

## Packer
Packer is used to bake AMIs

# Execution

* Jenkins Master AMI
>  cd jenkins-master && packer build package.json
* Jenkins Slave AMI
>  cd jenkins-slave && packer build package.json
* Grafana and Prometheus AMI
>  cd grafana-prometheus && packer build package.json
