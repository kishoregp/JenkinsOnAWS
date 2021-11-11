#!/bin/bash

echo "Install dependencies"
sudo yum -y upgrade

echo "Install Java"
sudo yum -y install epel-release java-11-openjdk-devel
sudo yum -y install wget
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat/jenkins.io.key

echo "Install Jenkins"
sudo yum -y install jenkins
sudo systemctl daemon-reload

echo "Install Git"
sudo yum install -y git

echo "change time zone"
sudo ln -sf /usr/share/zoneinfo/Asia/Dubai /etc/localtime