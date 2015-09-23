Netflix Dynomite Docker image
==================================

Setup
-------

To setup Dynomite single node with redis backend:
- `docker run -d --name redisserver redis redis-server`
- `docker run -d --name dynomite --link redisserver:redisserver -p 8101:8101 -p 8102:8102 -p 22222:22222 philipz/dynomite`

Usage
-------

To access redis
- `redis-cli -p 8102`

To monitor stats
- `curl http://127.0.0.1:22222/ | python -mjson.tool`

TODO
-------

- build Dynomite with multiple nodes

