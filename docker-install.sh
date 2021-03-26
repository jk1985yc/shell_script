adduser -g100 docker

ln /home/docker /root/docker -s

# sudo yum -y remove docker docker-common container-selinux
# sudo yum install -y yum-utils device-mapper-persistent-data lvm2
# yum-config-manager \
#     --add-repo \
#     https://docs.docker.com/v1.13/engine/installation/linux/repo_files/centos/docker.repo
# yum makecache fast
# yum -y install docker-engine

# sudo systemctl daemon-reload
# sudo systemctl restart docker

curl -sSL https://get.docker.com/ | sh

curl -L https://github.com/docker/compose/releases/download/1.23.1/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose

sudo chmod +x /usr/bin/docker-compose

docker-compose --version

mkdir /etc/systemd/system/docker.service.d
echo '[Service]'>>/etc/systemd/system/docker.service.d/docker.conf
echo 'ExecStart='>>/etc/systemd/system/docker.service.d/docker.conf
echo 'ExecStart=/usr/bin/dockerd -H tcp://0.0.0.0:2375 -H unix://var/run/docker.sock'>>/etc/systemd/system/docker.service.d/docker.conf

echo '{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  }
}
'>/etc/docker/daemon.json

sudo systemctl enable docker.service
sudo systemctl restart docker.service