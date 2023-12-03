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

server.mount_proc("/recipes") { |req, res| 
    template = ERB.new( File.read('./public/recipes.html.erb') )
    res.body << template.result( binding )
}

server.mount_proc("/detail") { |req, res| 
    template = ERB.new( File.read('./public/recipe_detail.html.erb') )
    res.body << template.result( binding )
}


# ログイン機能

# ログイン処理
server.mount_proc("/api/login") { |req, res| 
    email = req.query['email']
    password = req.query['password']
    user = db_client.query("SELECT LiqRecipe.users.id, LiqRecipe.users.name, LiqRecipe.users.image FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
    
    if user
        # ログイン成功
        session_id = SecureRandom.uuid
        sessions[session_id] = {
            "user" => {
                "id" => user['id'],
                "name" => user['name'],
                "image" => user['image']
            }
        }
        
        # セッションIDとユーザーIDをデータベースに保存
        # db_client.query("INSERT INTO user_sessions (session_id, user_id) VALUES ('#{session_id}', #{user['id']})")
        
        # クッキーにセッションIDをセット
        res.cookies << WEBrick::Cookie.new('session_id', session_id)
        
        # リダイレクト
        res.body = JSON.generate({"message": "ユーザー登録完了"})
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/recipes')
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
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/recipes')

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
    
    user = db_client.query("SELECT LiqRecipe.users.id, LiqRecipe.users.name, LiqRecipe.users.image FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
    
    if user
        # すでに登録済
        res.status = 409
        res.body = JSON.generate({"message": "すでに登録済みです"})
    else
        # ユーザー登録
        db_client.query("INSERT INTO LiqRecipe.users (name, email, password, image) VALUES ('#{name}', '#{email}', '#{password}', '#{image}')")

        # ログイン
        user = db_client.query("SELECT LiqRecipe.users.id, LiqRecipe.users.name, LiqRecipe.users.image FROM LiqRecipe.users WHERE email = '#{email}' AND password = '#{password}'").first
        
        session_id = SecureRandom.uuid
        sessions[session_id] = {
            "user" => {
                "id" => user['id'],
                "name" => user['name'],
                "image" => user['image']
            }
        }
        
        # セッションIDとユーザーIDをデータベースに保存
        # db_client.query("INSERT INTO user_sessions (session_id, user_id) VALUES ('#{session_id}', #{user['id']})")
        
        # クッキーにセッションIDをセット
        res.cookies << WEBrick::Cookie.new('session_id', session_id)
        
        # リダイレクト
        res.set_redirect(WEBrick::HTTPStatus::SeeOther, '/recipes')
    end
}

server.mount_proc("/api/posts") { |req, res|

    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value
    if sessions[session_id]
        user = sessions[session_id]["user"]
    end
    # フォームからデータを受け取る
    # id = req.query['id']
    # name = req.query['name']
    # summary = req.query['summary']
    # point = req.query['point']
    # recipe_image = req.query['image']
    # random_recipe_image_name = req.query['randomRecipeImageName']
    # random_procedure_image_names = req.query['randomProcedureImageNames']
    # liquor_id = req.query['liquor_id']
    # taste_id = req.query['taste_id']
    user_id = user["id"]
    # ingredients = req.query['ingredients']
    # procedures = req.query['procedures']
    form_data = JSON.parse(req.body)

    result = db_client.query("SELECT MAX(id) AS id FROM LiqRecipe.recipes;")
    recipe_id = JSON.parse(result.to_a.to_json)[0]['id'].to_i + 1
    


    client.query("INSERT INTO LiqRecipe.recipes (name, summary, point, image, user_id, liquor_id, taste_id) VALUES ('#{form_data['name']}', '#{form_data['summary']}', '#{form_data['point']}', '#{form_data['image']}', #{form_data['user_id']}, #{form_data['liquor_id']}, #{form_data['taste_id']})")

    # db_client.query("INSERT INTO LiqRecipe.recipes (name, summary, point, image, user_id, liquor_id, taste_id) VALUES ('aaa', 'aaa', 'aaa', 'vodka_berry.jpg', #{user_id}, 1, 1)")
    
    form_data['ingredients'].each do |ingredient|
    # db_client.query("INSERT INTO LiqRecipe.ingredients (order_num, name, amount, recipe_id) VALUES (1, 'ワイン', '10ml', 35)")

    db_client.query("INSERT INTO procedures (order_num, procedure_text, image, recipe_id) VALUES (#{procedure['order_num']}, '#{procedure['procedure_text']}', '#{procedure['image']}', #{recipe_id})")

    end

    # 手順テーブルにデータを挿入
    form_data['procedures'].each do |procedure|
    db_client.query("INSERT INTO LiqRecipe.procedures (order_num, procedure_text, image, recipe_id) VALUES (1, 'グラスに入れる', 'no_image.png', 35)")
    end

    res.set_redirect(WEBrick::HTTPStatus::SeeOther, "/detail?recipeId=")


}

# ログインしているユーザー情報を取得
server.mount_proc '/api/get_current_user' do |req, res|
    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value
    
    if sessions[session_id]

        user = sessions[session_id]
        puts sessions[session_id]["user"]["id"]
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


server.mount_proc("/api/recipes") do |req, res|
    # CORSヘッダを設定 (クロスオリジンリクエストを許可する場合)
    res['Access-Control-Allow-Origin'] = '*'
    res['Access-Control-Request-Method'] = '*'

    offset = req.query['offset']
    liquorId = req.query['liquorId']
    tasteId = req.query['tasteId']
    searchWord = req.query['searchWord']
    limit = 20

    case req.request_method
    when 'GET'
        if !liquorId && !tasteId && !searchWord
            # レシピ一覧を取得するときの処理
            # results = db_client.query("SELECT LiqRecipe.recipes.id, LiqRecipe.recipes.name AS recipe_name, LiqRecipe.recipes.image AS recipe_image, LiqRecipe.genres.name AS recipe_category FROM LiqRecipe.recipes JOIN LiqRecipe.genres ON LiqRecipe.recipes.genre_id = LiqRecipe.genres.id ORDER BY id DESC LIMIT #{offset}, #{limit}")

            results = db_client.query("SELECT LiqRecipe.recipes.id, LiqRecipe.recipes.name AS recipe_name, LiqRecipe.recipes.image AS recipe_image, LiqRecipe.liquors.id AS liquor_id, LiqRecipe.liquors.name AS liquor_name, LiqRecipe.tastes.id AS taste_id, LiqRecipe.tastes.name AS taste_name FROM LiqRecipe.recipes JOIN LiqRecipe.liquors ON LiqRecipe.recipes.liquor_id = LiqRecipe.liquors.id JOIN LiqRecipe.tastes ON LiqRecipe.recipes.taste_id = LiqRecipe.tastes.id ORDER BY id DESC LIMIT #{offset}, #{limit}")
            
        elsif liquorId
            # お酒を指定したときの処理
            results = db_client.query("SELECT LiqRecipe.recipes.id, LiqRecipe.recipes.name AS recipe_name, LiqRecipe.recipes.image AS recipe_image, LiqRecipe.liquors.id AS liquor_id, LiqRecipe.liquors.name AS liquor_name, LiqRecipe.tastes.id AS taste_id, LiqRecipe.tastes.name AS taste_name FROM LiqRecipe.recipes JOIN LiqRecipe.liquors ON LiqRecipe.recipes.liquor_id = LiqRecipe.liquors.id JOIN LiqRecipe.tastes ON LiqRecipe.recipes.taste_id = LiqRecipe.tastes.id WHERE liquor_id = #{liquorId} ORDER BY id DESC LIMIT #{offset}, #{limit}")

        elsif tasteId
            # 種類を指定したときの処理
            results = db_client.query("SELECT LiqRecipe.recipes.id, LiqRecipe.recipes.name AS recipe_name, LiqRecipe.recipes.image AS recipe_image, LiqRecipe.liquors.id AS liquor_id, LiqRecipe.liquors.name AS liquor_name, LiqRecipe.tastes.id AS taste_id, LiqRecipe.tastes.name AS taste_name FROM LiqRecipe.recipes JOIN LiqRecipe.liquors ON LiqRecipe.recipes.liquor_id = LiqRecipe.liquors.id JOIN LiqRecipe.tastes ON LiqRecipe.recipes.taste_id = LiqRecipe.tastes.id WHERE taste_id = #{tasteId} ORDER BY id DESC LIMIT #{offset}, #{limit}")
            
        elsif searchWord
            # ワード検索したときの処理
            results = db_client.query("SELECT LiqRecipe.recipes.id, LiqRecipe.recipes.name AS recipe_name, LiqRecipe.recipes.image AS recipe_image, LiqRecipe.liquors.id AS liquor_id, LiqRecipe.liquors.name AS liquor_name, LiqRecipe.tastes.id AS taste_id, LiqRecipe.tastes.name AS taste_name FROM LiqRecipe.recipes JOIN LiqRecipe.liquors ON LiqRecipe.recipes.liquor_id = LiqRecipe.liquors.id JOIN LiqRecipe.tastes ON LiqRecipe.recipes.taste_id = LiqRecipe.tastes.id WHERE LiqRecipe.recipes.name LIKE '%#{searchWord}%' ORDER BY id DESC LIMIT #{offset}, #{limit}")
        else
            # それ以外のクエリが送られてきたとき
            res.status = 401  # メソッドが許可されていない場合
            res.body = 'Not Found'
            
        end

        # データの取得

        data = results.to_a
        res.body = data.to_json
        res["Content-type"] = "application/json"

    when 'POST'
        
    else
        res.status = 405  # メソッドが許可されていない場合
        res.body = 'Method Not Allowed'
    end
end

server.mount_proc("/api/recipe-detail") do |req, res|
    # CORSヘッダを設定 (クロスオリジンリクエストを許可する場合)
    res['Access-Control-Allow-Origin'] = '*'
    res['Access-Control-Request-Method'] = '*'

    recipeId = req.query['recipeId']
    ingredientId = req.query['ingredientId']
    procedureId = req.query['procedureId']
    reviewId = req.query['reviewId']

    case req.request_method
    when 'GET'
        if recipeId 
            # results = db_client.query("SELECT LiqRecipe.recipes.id as recipe_id, LiqRecipe.recipes.name as recipe_name, LiqRecipe.recipes.image as recipe_image, LiqRecipe.ing.id as ingredients_id, LiqRecipe.ing.order_num as ingredients_order, LiqRecipe.ing.name as ingredients_name, LiqRecipe.ing.amount as ingredients_amount, LiqRecipe.pro.id as procedure_id, LiqRecipe.pro.order_num as procedure_order, LiqRecipe.pro.procedure_text as procedure_name, LiqRecipe.pro.image as procedure_image, LiqRecipe.tas.name as taste_name, LiqRecipe.liq.name as liquor_name, LiqRecipe.users.name as user_name FROM LiqRecipe.recipes join LiqRecipe.ingredients as ing on LiqRecipe.ing.recipe_id = LiqRecipe.recipes.id join LiqRecipe.procedures as pro on LiqRecipe.pro.recipe_id = LiqRecipe.recipes.id join LiqRecipe.liquors as liq on LiqRecipe.liq.id = LiqRecipe.recipes.liquor_id join LiqRecipe.tastes as tas on LiqRecipe.tas.id = LiqRecipe.recipes.taste_id join LiqRecipe.users on LiqRecipe.users.id = LiqRecipe.recipes.user_id WHERE LiqRecipe.recipes.id = #{recipeId}")
            results = db_client.query("SELECT LiqRecipe.recipes.id as recipe_id, LiqRecipe.recipes.name as recipe_name, LiqRecipe.recipes.point as recipe_point, LiqRecipe.recipes.summary as recipe_summary, LiqRecipe.recipes.image as recipe_image, LiqRecipe.tas.name as taste_name, LiqRecipe.liq.name as liquor_name, LiqRecipe.users.name as user_name, LiqRecipe.users.image as user_image FROM LiqRecipe.recipes join LiqRecipe.liquors as liq on LiqRecipe.liq.id = LiqRecipe.recipes.liquor_id join LiqRecipe.tastes as tas on LiqRecipe.tas.id = LiqRecipe.recipes.taste_id join LiqRecipe.users on LiqRecipe.users.id = LiqRecipe.recipes.user_id WHERE LiqRecipe.recipes.id = #{recipeId}")
        elsif ingredientId
            results = db_client.query("SELECT LiqRecipe.ing.id as ingredients_id, LiqRecipe.ing.order_num as ingredients_order, LiqRecipe.ing.name as ingredients_name, LiqRecipe.ing.amount as ingredients_amount FROM LiqRecipe.ingredients as ing WHERE LiqRecipe.ing.recipe_id = #{ingredientId}")
        elsif procedureId
            results = db_client.query("SELECT LiqRecipe.pro.id as procedure_id, LiqRecipe.pro.order_num as procedure_order, LiqRecipe.pro.procedure_text as procedure_name, LiqRecipe.pro.image as procedure_image FROM LiqRecipe.procedures as pro WHERE LiqRecipe.pro.recipe_id = #{procedureId}")
        elsif reviewId
            results = db_client.query("SELECT LiqRecipe.rev.content as review_content, LiqRecipe.rev.image as review_image, LiqRecipe.rev.created_at as review_created_at, LiqRecipe.users.image as user_image, LiqRecipe.users.name as user_name FROM LiqRecipe.reviews as rev join LiqRecipe.users on LiqRecipe.users.id = rev.user_id WHERE LiqRecipe.rev.recipe_id = #{reviewId}")
        end
        # それ以外のクエリが送られてきたとき
        # res.status = 401  # メソッドが許可されていない場合
        # res.body = 'Not Found'
        # データの取得
        data = results.to_a
        res.body = data.to_json
        res["Content-type"] = "application/json"

    when 'POST'
        
    else
        res.status = 405  # メソッドが許可されていない場合
        res.body = 'Method Not Allowed'
    end
end

server.mount_proc("/api/review") { |req, res| 
    image = req.query['image']
    text = req.query['text']
    recipeId = req.query['recipeId']

    image = "no_image.png" if image == ""
    
    # if image != "no_image.png"
    #     file = req.query['image']
    #     # filename = file[:filename]
    #     filepath = File.join("/public/image/reviews/", image)
    
    #     File.open(filepath, 'wb') { |f| f.write(file["tempfile"].read) }
    # end

    session_id = req.cookies.find { |c| c.name == 'session_id' }&.value
    
    if sessions[session_id]
        user_id = sessions[session_id]["user"]["id"]

        db_client.query("INSERT INTO LiqRecipe.reviews (content, image, user_id, recipe_id) VALUES ('#{text}', '#{image}', '#{user_id}', '#{recipeId}')")
    else
        res.status = 401
        res.body = 'Not logged in'
    end
    
    # リダイレクト
    res.set_redirect(WEBrick::HTTPStatus::SeeOther, "/detail?recipeId=#{recipeId}")
}

# シャットダウン
trap(:INT){
    server.shutdown
}

# サーバー起動
server.start