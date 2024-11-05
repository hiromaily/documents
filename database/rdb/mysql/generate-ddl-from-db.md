# 立ち上げたDatabaseからDDLを抽出する

```sh
docker exec my-db sh -c 'mysqldump -u root -ppassword --no-data my-db > /tmp/schema.sql'
docker cp my-db:/tmp/schema.sql ./tmp/schema.sql
```
