#!/bin/bash

echo "Install wget unzip"
sudo yum update -y
sudo yum install -y sudo wget unzip

echo "Install Java JDK 8"
sudo yum remove -y java
sudo yum install -y java-1.8.0-openjdk

echo "Install maven"
sudo yum install -y maven

echo "Install Git"
sudo yum install -y git

echo "Install Ansible"
sudo yum-config-manager --enable epel
sudo yum install -y epel-release
sudo yum install -y ansible
