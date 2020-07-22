#!/usr/bin/env bash
#下载docker 镜像
echo 'password'|docker login --username=hegaoye@qq.com -p hegaoye6258371 registry.cn-hangzhou.aliyuncs.com
docker pull registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888
docker pull registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:zookeeper-3.4.10
docker pull registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:redis-4.0.1
docker pull registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:mariadb-1.0
docker pull nginx
docker pull jenkins
docker pull adminer
docker pull portainer/portainer
docker pull rancher/server

#rancher
docker run -p 18080:8080 --name rancher --restart=always  -d rancher/server

#portainer
docker run --name portainer --restart always -d -p 18080:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/home/data portainer/portainer
docker run -p 9000:9000  -v /var/run/docker.sock:/var/run/docker.sock --name portainer --restart=always -d portainer/portainer


#mariadb
docker run -p 4123:3306 -e MYSQL_ROOT_PASSWORD=rootmind --name mariadb --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:mariadb-1.0

#zookeeper
docker run -p 2181:2181 -p 3888:3888 -p 2888:2888 --name zookeeper --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:zookeeper-3.4.10

#nginx
docker run -p 80:80 -v /home/www:/home/www -v /etc/nginx/conf.d:/etc/nginx/conf.d --name nginx --restart always --privileged -d nginx
docker run -p 80:80 -v /home/tomcat-support:/home/tomcat-support -v /home/tomcat-support-api:/home/tomcat-support-api -v /home/tomcat-tutors:/home/tomcat-tutors -v /home/tomcat-tutors-api:/home/tomcat-tutors-api -v /home/tomcat-task:/home/tomcat-task  -v /home/ftpimg:/home/ftpimg -v /home/www:/home/www -v /etc/nginx/conf.d:/etc/nginx/conf.d --name nginx --restart always -d nginx

#adminer
docker run -p 18000:8080  --name adminer --restart always -d adminer

#jenkins
docker run -p 18888:8080 --name jenkins --restart always -d jenkins

#redis
docker run -p 2017:6379 -v /home/redis:/data --name redis --restart always -d  --privileged registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:redis-4.0.1   redis-server /data/redis.conf
#简单使用模式
docker run -p 6379:6379 --name redis --restart always  -d redis redis-server  --appendonly yes

#tomcat
docker run  -v /home/tomcat-support/webapps:/usr/local/tomcat/webapps --name  tomcat-support  --restart always --privileged -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat-8.5
docker run -p 8082:8080  -v /home/tomcat-support-api/webapps:/usr/local/tomcat/webapps --name tomcat-support-api --restart always --privileged -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat-8.5
docker run -v /home/tomcat-tutors/webapps:/usr/local/tomcat/webapps --name tomcat-tutors --restart always --privileged -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat-8.5
docker run -p 8084:8080  -v /home/tomcat-tutors-api/webapps:/usr/local/tomcat/webapps --name tomcat-tutors-api --restart always --privileged -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat-8.5
docker run -p 8085:8080  -v /home/tomcat-task/webapps:/usr/local/tomcat/webapps --name tomcat-task --restart always --privileged -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat-8.5

docker run -p 2222:22  -v /home/tomcat-support/webapps:/usr/local/tomcat/webapps --name tomcat-support --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888
docker run -p 2223:22 -p 8082:8080  -v /home/tomcat-support-api/webapps:/usr/local/tomcat/webapps --name tomcat-support-api --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888
docker run -p 2224:22  -v /home/tomcat-tutors/webapps:/usr/local/tomcat/webapps --name tomcat-tutors --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888
docker run -p 2225:22 -p 8084:8080  -v /home/tomcat-tutors-api/webapps:/usr/local/tomcat/webapps --name tomcat-tutors-api --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888
docker run -p 2226:22 -p 8085:8080  -v /home/tomcat-task/webapps:/usr/local/tomcat/webapps --name tomcat-task --restart always -d registry.cn-hangzhou.aliyuncs.com/rzhkj/dev:tomcat8.5.20-ssh-888888


docker run --name pptp -d --privileged -p 1723:1723 -v /home/pptp/chap-secrets:/etc/ppp/chap-secrets --restart always  mobtitude/vpn-pptp




#ssr 部署 成功 只需要修改 -p 1989:8989
docker run -d --name ssr -p 8989:8989 malaohu/ssr-with-net-speeder -s 0.0.0.0 -p 8989 -k pi-top.com -m rc4-md5 -o http_simple -O auth_sha1_v4

#ss 部署
docker run -dt --name ss -p 80:6443 --restart always mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k hegaoye"
docker run -dt --name ss -p 80:6443 --restart always mritd/shadowsocks -s "-s 0.0.0.0 -p 6443 -m aes-256-cfb -k h@gaoy@gS2[kK}jkN(kA}bP"

#openvpn 部署 参考
docker run -v /root/openvpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://192.168.1.220
#docker run -v /root/openvpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u tcp://47.75.82.133
docker run -v /root/openvpn-data:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki
docker run --name openvpn -v /root/openvpn-data:/etc/openvpn -d -p 1194:1194 --privileged kylemanna/openvpn
docker run -v /root/openvpn-data:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full hegaoye nopass
docker run -v /root/openvpn-data:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient hegaoye > /root/openvpn-data/hegaoye.ovpn
