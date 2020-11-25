import redis

REDIS_PORT = 6379
REDIS_HOST = 'localhost'

r = redis.Redis(host=REDIS_HOST, port=REDIS_PORT, db=0)

r.set('mensaje', 'redis')
print(r.get('mensaje'))
print(r.getset('mensaje', 'prueba de strings'))
print(r.get('mensaje'))

r.lpush('prueba1', 'list1')
r.lpush('prueba1', 'list2')
r.lpush('prueba1', 'list3')
print(r.lrange('prueba',0,-2))

r.ZADD('pruebas2', '1', 'redis')
r.ZADD('pruebas2', '1', 'mysql')
r.ZADD('pruebas2', '1', 'ypf')
r.Zrange('pruebas2',0,-4, 'withscores')