Netflix Dynomite Docker image
==================================

Setup
-------

To setup Dynomite single node with redis backend:
- `docker run -d --name redisserver redis redis-server`
- `docker run -d --name dynomite --link redisserver:redisserver -p 8101:8101 -p 8102:8102 -p 22222:22222 philipz/dynomite`

##Usage
### One Node

To access redis
- `redis-cli -p 8102`

To monitor stats
- `curl http://127.0.0.1:22222/ | python -mjson.tool`

### Two Node
First `docker exec -ti dynomite sh`, then modify Node1 configure file, /dynomite/conf/dynomite.yml, the below is node1 example.
```
dyn_o_mite:
  datacenter: dc
  rack: racK
  dyn_listen: 0.0.0.0:8101
  dyn_seeds:
  - NODE2_IP:8101:rack:dc:87654321
  listen: 0.0.0.0:8102
  servers:
  - redisserver:6379:1
  tokens: '12345678'
  secure_server_option: datacenter
  pem_key_file: conf/dynomite.pem
  data_store: 0
```
Node2
```
dyn_o_mite:
  datacenter: dc
  rack: racK
  dyn_listen: 0.0.0.0:8101
  dyn_seeds:
  - NODE1_IP:8101:rack:dc:12345678
  listen: 0.0.0.0:8102
  servers:
  - redisserver:6379:1
  tokens: '87654321'
  secure_server_option: datacenter
  pem_key_file: conf/dynomite.pem
  data_store: 0
```
