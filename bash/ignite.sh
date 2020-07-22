#!/usr/bin/env bash
docker pull apacheignite/ignite
docker run --name ignite --restart always --net=host -d apacheignite/ignite

