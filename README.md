# apprentice DEV1 チーム3開発用リポジトリ

## 開発環境について
[環境構築方法](./DEVELOPMENT.md)

## ディレクトリ、ファイルの命名について
### moduleディレクトリ
JavaScriptファイルを格納

### ファイル名
〇〇.erbとし、server.rbに、以下のように記述しルーティングを行う。
例）sample.erbと命名した場合
```ruby
server.mount_proc("/sample") { |req, res| 
    template = ERB.new( File.read('sample.erb') )
    res.body << template.result( binding )
}
```
この場合、aタグでのリンクも、`<a href="/sample>サンプルページ</a>"`となる。


## ログイン機能について
webrickサーバー（server.rb）に以下のエンドポイントを設置
- /api/login
- /api/logout
- /api/get_current_user

### ログイン処理
JavaScriptから、`/api/login`へPOST送信すると、usersテーブルから`email`と`password`が一致するユーザーを取得。
一致するユーザーが存在したら、サーバーのセッションへランダムに生成した`session_id`と`user_id`を紐づけて保存。
ブラウザには`session_id`のみクッキーにセットして返却。

### ユーザー情報取得
JavaScriptから、`/api/get_current_user`へGETリクエストを送信すると、ブラウザのクッキーに保存された`session_id`と、サーバー側の`session_id`が一致していた場合、サーバー側の`session_id`に紐づいている`user_id`を使って、データベースのusersテーブルから、idが一致するユーザーを取得し、JSON形式でフロントへ返す。

### ログアウト処理
JavaScriptから、`/api/logout`へリクエストを送ると、ブラウザのクッキーに保存された`session_id`と、サーバー側の`session_id`を照合。一致するsession_idがあった場合は削除。
