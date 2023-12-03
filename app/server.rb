# WEBサーバーを立ち上げるファイル

require 'webrick'
require 'mysql2'
require 'json'
require 'erb'
require 'securerandom'

# データベース接続情報
db_client = Mysql2::Client.new(:host => 'mysql-container', :user => 'root', :password => 'root')

config = {
    :Port => 8000,
    :DocumentRoot => '.',
}

# erbファイルをhtmlとして返す
WEBrick::HTTPServlet::FileHandler.add_handler("erb", WEBrick::HTTPServlet::ERBHandler)
server = WEBrick::HTTPServer.new(config)
server.config[:MimeTypes][".html.erb"] = "text/html"

# セッションを定義
sessions = {}

# ルーティング設定
server.mount_proc("/sample") { |req, res| 
    template = ERB.new( File.read('./public/sample.html.erb') )
    res.body << template.result( binding )
}

server.mount_proc("/login") { |req, res| 
    template = ERB.new( File.read('./public/login.html.erb') )
    res.body << template.result( binding )
}

server.mount_proc("/signup") { |req, res| 
    template = ERB.new( File.read('./public/signup.html.erb') )
    res.body << template.result( binding )
}

server.mount_proc("/posts") { |req, res| 
    template = ERB.new( File.read('./public/posts.html.erb') )
    res.body << template.result( binding )
}


# ログイン機能

# ログイン処理
server.mount_proc("/api/login") { |req, res| 
    email = req.query['email']
    password = req.query['password']
    user = db_client.query("SELECT * FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
    
    if user
        # ログイン成功
        session_id = SecureRandom.uuid
        sessions[session_id] = user['id']
        
        # セッションIDとユーザーIDをデータベースに保存
        # db_client.query("INSERT INTO user_sessions (session_id, user_id) VALUES ('#{session_id}', #{user['id']})")
        
        # クッキーにセッションIDをセット
        res.cookies << WEBrick::Cookie.new('session_id', session_id)
        
        # リダイレクト
        res.body = JSON.generate({"message": "ユーザー登録完了"})
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/login')
    else
        # ログイン失敗
        res.status = 401
        res.body = JSON.generate({"message": "メールアドレスまたはパスワードが間違っています"})
    end
}

#ログアウトの処理
server.mount_proc("/api/logout") { |req, res|
    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value

    if sessions[session_id]
        # セッション削除
        sessions.delete(session_id)

        # データベースからもセッション情報を削除
        # db_client.query("DELETE FROM user_sessions WHERE session_id = '#{session_id}'")

        res.body = 'Logout successful'
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/sample')

    else
        res.body = 'Not logged in'
    end
}

# ユーザー登録
server.mount_proc("/api/signup") { |req, res| 
    name = req.query['username']
    email = req.query['email']
    password = req.query['password']
    IMAGES = ["wolf_man.png", "dracula.png", "frankenstein.png", "man.png", "woman.png"]
    image = IMAGES[rand(IMAGES.length)]
    
    user = db_client.query("SELECT * FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
    
    if user
        # すでに登録済
        res.status = 409
        res.body = JSON.generate({"message": "すでに登録済みです"})
    else
        # ユーザー登録
        db_client.query("INSERT INTO LiqRecipe.users (name, email, password, image) VALUES ('#{name}', '#{email}', '#{password}', '#{image}')")

        # ログイン
        user = db_client.query("SELECT * FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
        
        session_id = SecureRandom.uuid
        sessions[session_id] = user['id']
        
        # セッションIDとユーザーIDをデータベースに保存
        # db_client.query("INSERT INTO user_sessions (session_id, user_id) VALUES ('#{session_id}', #{user['id']})")
        
        # クッキーにセッションIDをセット
        res.cookies << WEBrick::Cookie.new('session_id', session_id)
        
        # リダイレクト
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/')
    end
}

server.mount_proc("/api/posts") { |req, res|
    # フォームからデータを受け取る
    name = req.query['recipe_name']
    summary = req.query['recipe_explanation']
    point = req.query['tips']
    user_id = req.query['user']
    liquor_id = req.query['alcohol']
    taste_id = req.query['taste']
    image = req.query['photo'] 

    db_client.query("INSERT INTO LiqRecipe.recipes (name, summary, point, user_id, liquor_id, taste_id, image) VALUES ('#{name}', '#{summary}', '#{point}', '#{user_id}', '#{liquor_id}', '#{taste_id}', '#{image}')")

# ログインしているユーザー情報を取得
server.mount_proc '/api/get_current_user' do |req, res|
    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value
    
    if sessions[session_id]
        user_id = sessions[session_id]
        # データベースからユーザー情報を取得
        user = db_client.query("SELECT * FROM LiqRecipe.users WHERE id = #{user_id}").first
        if user
            res.body = JSON.generate(user)
        else
            res.status = 404
            res.body = 'User not found'
        end
    else
        res.status = 401
        res.body = 'Not logged in'
    end
end

server.mount_proc '/api/is_logged_in' do |req, res|
    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value
    if sessions[session_id]
        res.body = JSON.generate({"isLoggedIn": true})
        
    else
        res.status = 401
        res.body = JSON.generate({"isLoggedIn": false})
    end
end

# APIエンドポイントのルート
server.mount_proc("/api/genres") do |req, res|
    # CORSヘッダを設定 (クロスオリジンリクエストを許可する場合)
    res['Access-Control-Allow-Origin'] = '*'
    res['Access-Control-Request-Method'] = '*'

    # APIエンドポイントへのリクエストメソッドごとに処理を分ける
    case req.request_method
        when 'GET'
            # データの取得
            results = db_client.query("SELECT * FROM LiqRecipe.genres")
            data = results.to_a
            res.body = data.to_json
            res["Content-type"] = "application/json"
        when 'POST'
            # データの新規作成
            name = req.query['name']
            category = req.query['category']
            result = db_client.query("INSERT INTO LiqRecipe.genres (name, category) VALUES ('#{name}', '#{category}')")
            res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/sample')
        else
            res.status = 405  # メソッドが許可されていない場合
            res.body = 'Method Not Allowed'
        end
    end

# シャットダウン
trap(:INT){
    server.shutdown
}

# サーバー起動
server.start