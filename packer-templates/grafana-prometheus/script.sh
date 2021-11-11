#!/bin/bash

echo "Install Grafana"
sudo yum install -y initscripts urw-fonts wget
wget https://dl.grafana.com/oss/release/grafana-8.2.3-1.x86_64.rpm
sudo yum install -y grafana-8.2.3-1.x86_64.rpm

sudo systemctl daemon-reload
sudo systemctl start grafana-server
sudo systemctl status grafana-server
sudo systemctl enable grafana-server

echo "Install Prometheus"
yum update -y
wget https://github.com/prometheus/prometheus/releases/download/v2.31.1/prometheus-2.31.1.linux-amd64.tar.gz

useradd --no-create-home --shell /bin/false prometheus
mkdir /etc/prometheus
mkdir /var/lib/prometheus
chown prometheus:prometheus /etc/prometheus
chown prometheus:prometheus /var/lib/prometheus

tar -xvzf prometheus-2.8.1.linux-amd64.tar.gz
mv prometheus-2.8.1.linux-amd64 prometheuspackage

cp prometheuspackage/prometheus /usr/local/bin/
cp prometheuspackage/promtool /usr/local/bin/

chown prometheus:prometheus /usr/local/bin/prometheus
chown prometheus:prometheus /usr/local/bin/promtool

cp -r prometheuspackage/consoles /etc/prometheus
cp -r prometheuspackage/console_libraries /etc/prometheus

chown -R prometheus:prometheus /etc/prometheus/consoles
chown -R prometheus:prometheus /etc/prometheus/console_libraries

vim /etc/prometheus/prometheus.yml
global:
  scrape_interval: 10s

scrape_configs:
  - job_name: 'prometheus_master'
    scrape_interval: 5s
    static_configs:
      - targets: ['localhost:9090']
 
chown prometheus:prometheus /etc/prometheus/prometheus.yml
vim /etc/systemd/system/prometheus.service

[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
Type=simple
ExecStart=/usr/local/bin/prometheus \
--config.file /etc/prometheus/prometheus.yml \
--storage.tsdb.path /var/lib/prometheus/ \
--web.console.templates=/etc/prometheus/consoles \
--web.console.libraries=/etc/prometheus/console_libraries

[Install]
WantedBy=multi-user.target

systemctl daemon-reload
systemctl start prometheus
systemctl status prometheus

yum install -y firewalld
firewall-cmd --zone=public --add-port=9090/tcp --permanent
systemctl reload firewalld