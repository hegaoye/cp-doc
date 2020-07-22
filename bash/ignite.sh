#!/usr/bin/env bash
docker pull apacheignite/ignite
docker run --name ignite --restart always --net=host -d apacheignite/ignite

#ignite
docker run --name ignite --restart always --net=host -d apacheignite/ignite

#nacos
docker pull nacos/nacos-server
# standalone代表着单机模式运行，非集群模式
docker run -p 8848:8848 --env MODE=standalone --name nacos   --restart always -d nacos/nacos-server

#mysql
docker run -p  3306:3306 -e MYSQL_ROOT_PASSWORD=888888  --name mysql  --restart always -d hegaoye/mysql:1.0-beta  --lower_case_table_names=1

#tidb 尝鲜版
git clone https://github.com/pingcap/tidb-docker-compose.git
docker-compose pull