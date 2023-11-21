## 概要
バックエンドにRubyのwebrickを使ってHTTPサーバを立ち上げ、MysqlとCRUD操作ができる環境

## 開始時
docker-compose.ymlファイルがあるディレクトリで
```shell
$ docker-compose up --build -d
```

### 2回目以降はこっち
```shell
$ docker-compose up  -d
```

起動に30秒くらいかかります。
>MySQLのコンテナが起動してからでないと、Rubyのコンテナがエラーになります。MySQLコンテナの立ち上がりを待ってから、Rubyコンテナが起動するように設定してありますが、たまに失敗するので、そのときは、再度上記のコマンドを入れれば、Rubyコンテナが立ち上がります。

起動したら、[localhost:8000](localhost:8000)へアクセス


## Mysqlへログインするとき
```shell
$  docker exec -it ruby-container bash
```
```shell
コンテナ内$  mysql -h mysql-container -u root -D demo -p
```


## 終了時

コンテナ内にいる場合
```shell
コンテナ内$ exit
```

```shell
$ docker-compose down
```
