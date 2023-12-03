-- ユーザーテーブル
CREATE TABLE users (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    image TEXT,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp
);

-- リキュールテーブル
CREATE TABLE liquors (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- テイストテーブル
CREATE TABLE tastes (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL
);

-- レシピテーブル
CREATE TABLE recipes (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL,
    summary TEXT,
    point TEXT,
    image TEXT NOT NULL,
    user_id BIGINT NOT NULL,
    liquor_id BIGINT NOT NULL,
    taste_id BIGINT NOT NULL,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (liquor_id) REFERENCES liquors(id),
    FOREIGN KEY (taste_id) REFERENCES tastes(id)
);

-- レビューテーブル
CREATE TABLE reviews (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    content TEXT NOT NULL,
    image TEXT,
    user_id BIGINT NOT NULL,
    recipe_id BIGINT NOT NULL,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

CREATE TABLE ingredients (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_num BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    amount VARCHAR(255) NOT NULL,
    recipe_id BIGINT NOT NULL,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

-- 手順テーブル
CREATE TABLE procedures (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_num BIGINT NOT NULL,
    procedure_text TEXT NOT NULL,
    image TEXT,
    recipe_id BIGINT NOT NULL,
    created_at datetime default current_timestamp,
    updated_at datetime default current_timestamp,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

INSERT INTO users (id, name, email, password, image) VALUES
(1, 'JohnDoe', 'john.doe@example.com', 'password123', 'wolf_man.png'),
(2, 'AliceSmith', 'alice.smith@example.com', 'securepass456', 'dracula.png'),
(3, 'BobJohnson', 'bob.johnson@example.com', 'userpass789', 'frankenstein.png'),
(4, 'EmilyBrown', 'emily.brown@example.com', 'mypassword10', 'man.png'),
(5, 'CharlieWhite', 'charlie.white@example.com', 'pass1234', 'woman.png'),
(6, 'OliviaJones', 'olivia.jones@example.com', 'securepass789', 'wolf_man.png'),
(7, 'JamesWilson', 'james.wilson@example.com', 'password567', 'dracula.png'),
(8, 'SophiaMiller', 'sophia.miller@example.com', 'userpass890', 'frankenstein.png'),
(9, 'DanielDavis', 'daniel.davis@example.com', 'mypassword20', 'man.png'),
(10, 'AvaGarcia', 'ava.garcia@example.com', 'pass5678', 'woman.png'),
(11, 'LiamMartinez', 'liam.martinez@example.com', 'securepass123', 'wolf_man.png'),
(12, 'EmmaRodriguez', 'emma.rodriguez@example.com', 'password890', 'dracula.png'),
(13, 'MiaLopez', 'mia.lopez@example.com', 'userpass234', 'frankenstein.png'),
(14, 'NoahTaylor', 'noah.taylor@example.com', 'mypassword30', 'man.png'),
(15, 'AveryTurner', 'avery.turner@example.com', 'pass6789', 'woman.png'),
(16, 'LoganWard', 'logan.ward@example.com', 'securepass456', 'wolf_man.png'),
(17, 'EllaCooper', 'ella.cooper@example.com', 'password234', 'dracula.png'),
(18, 'JacksonBaker', 'jackson.baker@example.com', 'userpass567', 'frankenstein.png'),
(19, 'GraceReed', 'grace.reed@example.com', 'mypassword40', 'man.png'),
(20, 'LucasWright', 'lucas.wright@example.com', 'pass7890', 'woman.png'),
(21, 'admin', 'admin@email.com', '1234', 'wolf_man.png');

INSERT INTO liquors (id, name) VALUES
(1, 'ワイン'),
(2, 'ビール'),
(3, '日本酒'),
(4, '焼酎'),
(5, 'ウイスキー'),
(6, 'ブランデー'),
(7, 'ジン'),
(8, 'ウォッカ'),
(9, 'ラム'),
(10, 'テキーラ'),
(11, '果実酒'),
(12, 'リキュール');

INSERT INTO tastes (id, name) VALUES
(1, '甘口'),
(2, '辛口'),
(3, '炭酸'),
(4, 'フルーティー'),
(5, 'シトラス'),
(6, 'ビター');

INSERT INTO recipes (id, name, summary, point, image, user_id, liquor_id, taste_id) VALUES
(1, 'フルーティーワインパンチ', 'ワインベースの爽やかなパンチ', '氷をたっぷりと入れて楽しむ', 'sangria-4469553_1280.jpg', 4, 1, 4),
(2, 'スパイシージントニック', 'ジンとスパイスが効いた辛口トニック', 'スターアニスをトニックに浸すと香りが引き立つ', 'gin-tonic-2018112_1280.jpg', 3, 7, 2),
(3, 'シトラスフレッシュビール', 'ビールで楽しむシトラスフレッシュ', 'オレンジピールを軽く絞り入れると爽やかな香りが広がる', 'photo-1558645836-e44122a743ee.jpg', 5, 2, 5),
(4, '和風梅酒サワー', '日本酒と梅干しで仕立てる和風サワー', 'シロップは控えめに調整して、梅酒の風味を楽しむ', 'prum_wine.webp', 4, 3, 1),
(5, 'スモーキーウイスキーコーラ', 'ウイスキーベースのスモーキーコーラ', 'オークチップでスモークアクセントを加える', 'smoky_coke.webp', 3, 5, 2),
(6, 'ラズベリーブランデーフリーズ', 'ブランデーで作る甘いフリーズドリンク', 'ラズベリーシロップで色と風味をプラス', 'rasberry_brandy.webp', 4, 6, 4),
(7, 'テキーラマンゴーマルガリータ', 'テキーラとマンゴーの爽やかなマルガリータ', 'マンゴーピューレを使用してフルーティーに仕上げる', 'mango-margaritas18857.jpg', 4, 10, 4),
(8, 'ウォッカベリーモヒート', 'ウォッカで作るベリー風味のモヒート', 'ベリーソースを加えて酸味と甘みをプラス', 'vodka_berry.jpg', 5, 8, 4),
(9, 'シャープパイナップルラム', 'ラムベースのシャープなパイナップルカクテル', 'シナモンスティックでスパイシーに仕上げる', 'rum_pineapple.jpg', 2, 9, 5),
(10, 'キャラメルアップルリキュール', 'リキュールで楽しむキャラメルアップル', 'キャラメルシロップとリンゴジュースの組み合わせが絶妙', 'caramel_apple33282888.jpg', 3, 12, 1),
(11, 'マイティミントモスコミュール', 'ウォッカとミントが爽やかなモスコミュール', '生姜ビールで辛さと爽やかさをプラス', 'vodka_mojito.jpg', 4, 8, 3),
(12, 'ブルーベリーシトラスサワー', 'シトラスとブルーベリーが絶妙なサワーカクテル', 'シトラスフルーツを絞って爽やかな風味を加える', 'citrus_blueberry.jpg', 4, 9, 4),
(13, 'ハニーウイスキーホットトディ', '寒い季節にぴったりのホットトディ', 'ハチミツとレモンで風邪対策にもなる', 'hot-toddy-cinnamon.jpg', 2, 5, 1),
(14, 'ピーチティーウイスキーサワー', '桃の風味が広がるサワーカクテル', '紅茶を加えて奥深い味わいに仕上げる', 'peach_whiskey.webp', 4, 5, 4),
(15, 'オレンジバニララムプランテーション', 'ラムとバニラが香るトロピカルなカクテル', 'オレンジジュースとパイナップルジュースでリッチな味わいに', 'orange_rum.jpg', 4, 9, 4),
(16, 'シナモンアップルブランデーホットトディ', 'シナモンが温まるホットトディ', 'りんごジュースとシナモンスティックで風味豊かに', 'sinnamon_apple.jpg', 2, 6, 1),
(17, 'ストロベリーレモネードテキーラ', 'テキーラで作る甘酸っぱいレモネード', 'ストロベリーピューレでフルーティーに仕上げる', 'strawberry_remonade.jpeg', 4, 10, 4),
(18, 'ラズベリーローズワインスプリッツァー', 'ローズワインが華やかなスプリッツァー', 'ラズベリーシロップとミントで彩りを加える', 'rasberry_spritzer.jpg', 4, 1, 4),
(19, 'クラシックモヒート', 'ミントとラムが爽やかなモヒート', '炭酸水で軽やかに仕上げ、ライムで風味をプラス', 'classic_ mojito.jpg', 3, 9, 6),
(20, 'チョコミントテキーラショット', 'チョコレートとミントの絶妙な組み合わせ', 'テキーラショットにチョコミントリキュールを加える', 'choco_mint.jpg', 1, 10, 6),
(21, 'ピンクグレープフルーツジンフィズ', 'ジンとピンクグレープフルーツの爽やかなフィズ', 'グレープフルーツソーダでさらにフルーティーに', 'Gin-Fizz-scaled.jpg', 4, 7, 4),
(22, 'シトラスハニーウォッカサワー', 'シトラスとハチミツが絶妙なウォッカサワー', 'オレンジとレモンの絞り汁で酸味を調整', 'orange_vodka.jpg', 4, 8, 4),
(23, 'ベリーミントモヒート', 'ミントとベリーが香るモヒート', 'ブルーベリーとラズベリーで彩りを加える', 'berry_mogito.jpg', 3, 9, 6),
(24, 'マンゴーテキーラスプリッツ', 'マンゴーの甘さとテキーラの絶妙な組み合わせ', 'シトラスソーダで軽やかに仕上げる', 'maogo_tequila.webp', 4, 10, 4),
(25, 'キウイパッションフルーツリキュール', 'キウイとパッションフルーツが広がるリキュール', 'シロップで甘さをプラス', 'kiwi_passion_fruit.jpg', 1, 11, 4),
(26, 'メープルバーボンアップルホットトディ', 'メープルバーボンとりんごの温かいホットトディ', 'シナモンスティックで香りを引き立てる', 'maple_hot_borbon.jpg', 2, 5, 1),
(27, 'クランベリーオレンジワインパンチ', 'クランベリーとオレンジの華やかなワインパンチ', 'シナモンとオレンジスライスでデコレーション', 'cranberry-wine.jpg', 4, 1, 4),
(28, 'ピナコラーダラムカクテル', 'ラムの優しいココナッツ風味のピナコラーダ', 'パイナップルジュースでトロピカルに', 'rum_pinacolada.jpg', 4, 9, 4),
(29, 'ハニーレモンジンジャービール', 'ハチミツとレモン、ジンジャービールが織りなす爽やかなドリンク', 'レモンスライスで飾り付け', 'honey_beer.jpg', 4, 7, 3),
(30, 'ミントチョコレートマティーニ', 'ミントとチョコレートの絶妙なマティーニ', 'チョコレートシロップで甘さをプラス', 'chocolate_matini.jpg', 1, 12, 5),
(31, '爽でシャンディガフ', 'お手軽にシャンディガフを作ることができます', 'アイスの量はお好みで調整してください', 'sou_shandygaff.jpg',  1, 2, 3),
(32, 'カツオ酒', 'ヒレ酒ならぬカツオ酒です。', '厚削りの鰹節を使うのがポイントです', 'katsuo_sake.webp', 2, 4, 2),
(33, 'ミックスベリーのウォッカ漬け', 'ミックスベリーをウォッカに漬け込むだけで、いろいろなアレンジができます。', '甘いのが好きな方は、砂糖を入れて漬け込むことでより美味しくなります', 'mixberry.jpg',  3, 8, 4),
(34, 'スパイシーハイボール', '黒胡椒のピリッとしたパンチがクセになる', '黒胡椒の量はお好みで調整してみてください', 'spicy_highball.jpg',  1, 5, 3);

INSERT INTO reviews (id, content, image, user_id, recipe_id) VALUES
(1, 'さっぱりしてて飲みやすいです！', 'review1.jpg', 1, 34),
(2, 'すごく美味しい！', 'review2.jpg', 2, 34),
(3, '香りが強烈で、黒胡椒の爽やかな香りがハイボールに広がります。一口飲むたびに、スパイシーで新鮮な感覚が広がります。', 'no_image.png', 3, 34),
(4, '辛いもの好きにはたまらない一杯。黒胡椒のピリッとした辛さが、ハイボールにアクセントを与えています。', 'no_image.png', 4, 34),
(5, '黒胡椒の風味がしっかり感じられつつも、飲みやすさも備えたハイボール。リラックスした時間にぴったりです。', 'review3.jpg', 5, 34),
(6, '手軽なハイボールでもクラフト感を楽しみたい方におすすめ。黒胡椒のアクセントが、普通のハイボールとは一線を画しています。', 'review4.jpg', 6, 34),
(7, '食事との相性が抜群。特に肉料理やシーフードとの相性が良く、食事と一緒に楽しむとより一層美味しいです。', 'no_image.png', 7, 34),
(8, 'スパイス好きにはたまらない組み合わせ。黒胡椒のスパイシーな風味が、飲み物に新しい次元を与えてくれます。', 'review5.jpg', 8, 34),
(9, '飲み終わった後のすっきり感が好印象。クセがなく、爽やかな余韻が残ります。', 'review6.jpg', 9, 34),
(10, 'おしゃれな雰囲気を楽しみながら、黒胡椒の個性的な風味を堪能できる一杯。', 'review7.jpg', 10, 34),
(11, '冷たい季節にぴったりな温かみを感じるハイボール。黒胡椒が身体を温めてくれる感じがします。', 'review8.jpg', 11, 34),
(12, 'スパイシーな刺激がクセになる、新しいハイボールの世界。', 'no_image.png', 12, 34),
(13, '香りと辛さが絶妙にマッチして、大人な雰囲気を楽しめる', 'no_image.png', 13, 34),
(14, '多めに入れてもいいかも', 'review9.jpg', 14, 34),
(15, '黒胡椒の風味が後味に残り、余韻が長く楽しめる。', 'review10.jpg', 15, 34),
(16, 'アウトドアにもピッタリ', 'review11.jpg', 16, 34),
(17, 'おしゃれな雰囲気が漂う中、黒胡椒のアクセントが光る', 'no_image.png', 17, 34),
(18, 'シンプルながらも奥深い味わいで、毎日でも飲みたくなる。', 'review12.jpg', 18, 34),
(19, '料理との相性が抜群で、食事中にもぴったりな一杯。', 'no_image.png', 19, 34),
(20, '黒胡椒のピリッとした辛さが、リフレッシュ感を与えてくれます。', 'no_image.png', 20, 34);


INSERT INTO ingredients (id, order_num, name, amount, recipe_id) VALUES
(1, 1, 'ワイン', '150ml', 1),
(2, 2, '氷', '適量', 1),
(3, 3, 'カットフルーツ', '適量', 1),
(4, 1, 'ジン', '50ml', 2),
(5, 2, 'スターアニス', '1本', 2),
(6, 3, '辛口トニック', '150ml', 2),
(7, 1, 'ビール', '200ml', 3),
(8, 2,  'オレンジピール', '1片', 3),
(9, 1, '日本酒', '100ml', 4),
(10, 2, '梅干し', '1個', 4),
(11, 3, 'シロップ', '20ml', 4),
(12, 1, 'ウイスキー', '60ml', 5),
(13, 2, 'オークチップ', '1片', 5),
(14, 3, 'コーラ', '150ml', 5),
(15, 1, 'ブランデー', '50ml', 6),
(16, 2, 'ラズベリーシロップ', '30ml', 6),
(17, 1, 'テキーラ', '60ml', 7),
(18, 2, 'マンゴーピューレ', '50ml', 7),
(19, 1, 'ウォッカ', '50ml', 8),
(20, 2, 'ベリーソース', '30ml', 8),
(21, 3, 'ミントの葉', '数枚', 8),
(22, 1, 'ラム', '60ml', 9),
(23, 2, 'パイナップルジュース', '50ml', 9),
(24, 3, 'シナモンスティック', '1本', 9),
(25, 1, 'リキュール', '40ml', 10),
(26, 2, 'リンゴジュース', '60ml', 10),
(27, 3, 'キャラメルシロップ', '20ml', 10),
(28, 1, 'ウォッカ', '50ml', 11),
(29, 2, 'ミントの葉', '数枚', 11),
(30, 3, '生姜ビール', '150ml', 11),
(31, 1, 'シトラスフルーツ（オレンジ、レモンなど）', '各1個', 12),
(32, 2, 'ブルーベリー', '適量', 12),
(33, 3, '氷', '適量', 12),
(34, 1, 'ウイスキー', '50ml', 13),
(35, 2, 'ハチミツ', '大さじ1', 13),
(36, 3, 'お湯', '150ml', 13),
(37, 4, 'レモンスライス', '1枚', 13),
(38, 5, 'シナモンスティック', '1本', 13),
(39, 1, 'ウイスキー', '50ml', 14),
(40, 2, 'ピーチティー', '150ml', 14),
(41, 3, '氷', '適量', 14),
(42, 4, '桃の輪切り', '1個', 14),
(43, 1, 'ラム', '50ml', 15),
(44, 2, 'バニラシロップ', '30ml', 15),
(45, 3, 'オレンジジュース', '30ml', 15),
(46, 4, 'パイナップルジュース', '30ml', 15),
(47, 5, '氷', '適量', 15),
(48, 1, 'ブランデー', '50ml', 16),
(49, 2, 'シナモンシロップ', '30ml', 16),
(50, 3, 'お湯', '150ml', 16),
(51, 4, 'りんごジュース', '30ml', 16),
(52, 5, 'シナモンスティック', '1本', 16),
(53, 1, 'テキーラ', '50ml', 17),
(54, 2, 'ストロベリーピューレ', '30ml', 17),
(55, 3, '氷', '適量', 17),
(56, 4, 'レモネード', '150ml', 17),
(57, 5, 'ストロベリーハーフ', '1個', 17),
(58, 1, 'ローズワイン', '150ml', 18),
(59, 2, '氷', '適量', 18),
(60, 3, 'ラズベリーシロップ', '30ml', 18),
(61, 4, 'ミント', '数枚', 18),
(62, 1, 'ミント', '数枚', 19),
(63, 2, 'ライム', '1個', 19),
(64, 3, 'ラム', '50ml', 19),
(65, 4, '氷', '適量', 19),
(66, 5, '炭酸水', '適量', 19),
(67, 6, 'ライムホイール', '1個', 19),
(68, 1, 'テキーラ', '50ml', 20),
(69, 2, 'チョコミントリキュール', '30ml', 20),
(70, 3, '氷', '適量', 20),
(71, 4, 'チョコミント', '1枚', 20),
(72, 1, 'ジン', '50ml', 21),
(73, 2, 'ピンクグレープフルーツジュース', '30ml', 21),
(74, 3, '氷', '適量', 21),
(75, 4, 'グレープフルーツソーダ', '適量', 21),
(76, 1, 'ウォッカ', '50ml', 22),
(77, 2, 'シトラスフルーツ（オレンジ、レモンなど）', '各1個', 22),
(78, 3, 'ハチミツ', '大さじ1', 22),
(79, 4, '氷', '適量', 22),
(80, 5, 'オレンジスライス', '1個', 22),
(81, 1, 'ミント', '数枚', 23),
(82, 2, 'ベリー類（ブルーベリー、ラズベリーなど）', '適量', 23),
(83, 3, '氷', '適量', 23),
(84, 4, 'ラム', '50ml', 23),
(85, 1, 'テキーラ', '50ml', 24),
(86, 2, 'マンゴージュース', '30ml', 24),
(87, 3, '氷', '適量', 24),
(88, 4, 'シトラスソーダ', '適量', 24),
(89, 5, 'マンゴーの輪切り', '1個', 24),
(90, 1, 'キウイパッションフルーツリキュール', '50ml', 25),
(91, 2, 'シロップ', '適量', 25),
(92, 3, 'キウイスライス', '1個', 25),
(93, 1, 'メープルバーボン', '50ml', 26),
(94, 2, 'りんごジュース', '150ml', 26),
(95, 3, 'お湯', '適量', 26),
(96, 4, 'シナモンスティック', '1本', 26),
(97, 1, 'クランベリーオレンジジュース', '150ml', 27),
(98, 2, 'ワイン', '150ml', 27),
(99, 3, '氷', '適量', 27),
(100, 4, 'シナモンスティック', '1本', 27),
(101, 5, 'オレンジスライス', '1個', 27),
(102, 1, 'ラム', '50ml', 28),
(103, 2, 'ココナッツクリーム', '30ml', 28),
(104, 3, 'パイナップルジュース', '30ml', 28),
(105, 4, '氷', '適量', 28),
(106, 5, 'パイナップルの輪切り', '1個', 28),
(107, 1, 'ジンジャービール', '150ml', 29),
(108, 2, 'レモンジュース', '30ml', 29),
(109, 3, 'ハチミツ', '大さじ1', 29),
(110, 4, '氷', '適量', 29),
(111, 5, 'レモンスライス', '1枚', 29),
(112, 1, 'ミント', '数枚', 30),
(113, 2, 'チョコレートリキュール', '30ml', 30),
(114, 3, '氷', '適量', 30),
(115, 4, 'チョコレートチップ', '適量', 30),
(116, 1, 'ビール', '350ml', 31),
(117, 2, '爽 ジンジャーエール味', '50g', 31),
(118, 1, '焼酎', 'お好み', 32),
(119, 2, '鰹節（厚削り）', '2〜3枚', 32),
(120, 1, 'ウォッカ（スミノフ）', '1瓶', 33),
(121, 2, '冷凍ミックスベリー', '1袋', 33),
(125, 1, 'ウイスキー', 'グラス1/4程度', 34),
(126, 2, '炭酸水', 'グラス3/4程度', 34),
(127, 3, '黒胡椒', 'お好み', 34);

INSERT INTO procedures (id, order_num, procedure_text, image, recipe_id) VALUES
(1, 1, 'ワインを氷で冷やす。', 'no_image.png', 1),
(2, 2, 'カットフルーツ（オレンジ、パイナップル、ベリーなど）をワインに加える。', 'no_image.png', 1),
(3, 3, '軽くステアして混ぜ、冷たいまま楽しむ。', 'no_image.png', 1),
(4, 1, 'ジンとスターアニスをシェークして混ぜる。', 'no_image.png', 2),
(5, 2, '辛口トニックをグラスに注ぎ、シェークしたジンとスターアニスを注ぐ。', 'no_image.png', 2),
(6, 3, '軽くステアして混ぜ、氷を加えて提供する。', 'no_image.png', 2),
(7, 1, 'ビールを氷で冷やす。', 'no_image.png', 3),
(8, 2, 'オレンジピールをビールに絞り入れる。', 'no_image.png', 3),
(9, 3, '軽くステアして混ぜ、冷たいまま楽しむ。', 'no_image.png', 3),
(10, 1, '氷をシェーカーに入れ、日本酒とシロップを加えてシェークする。', 'no_image.png', 4),
(11, 2, '梅干しを潰し、シェーカーに加えて軽く混ぜる。', 'no_image.png', 4),
(12, 3, 'グラスに氷を入れ、シェークした液体を注ぎ入れる。', 'no_image.png', 4),
(13, 1, 'ウイスキーとオークチップをシェーカーに入れ、スモークをかける。', 'no_image.png', 5),
(14, 2, '氷をグラスに入れ、スモーキーウイスキーを注ぎ入れる。', 'no_image.png', 5),
(15, 3, 'コーラを加えて軽くステアし、提供する。', 'no_image.png', 5),
(16, 1, 'ブレンダーに氷とブランデーを入れ、ラズベリーシロップも加えてフリーズする。', 'no_image.png', 6),
(17, 2, 'フリーズしたものをグラスに注ぎ、ラズベリーシロップでデコレーションする。', 'no_image.png', 6),
(18, 1, '氷をシェーカーに入れ、テキーラとマンゴーピューレを加えてシェークする。', 'no_image.png', 7),
(19, 2, 'グラスに氷を入れ、シェークした液体を注ぎ入れる。', 'no_image.png', 7),
(20, 3, '軽くステアして混ぜ、マンゴーウェッジでデコレーションする。', 'no_image.png', 7),
(21, 1, 'ミントとベリーソースをシェーカーに入れ、軽くマドラーで押して香りを引き出す。', 'no_image.png', 8),
(22, 2, '氷をグラスに入れ、ウォッカを注ぎ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 8),
(23, 3, '軽くステアして混ぜ、ミントの葉でデコレーションする。', 'no_image.png', 8),
(24, 1, '氷をシェーカーに入れ、ラムとシナモンスティックを加えてシェークする。', 'no_image.png', 9),
(25, 2, '氷をグラスに入れ、シェークした液体を注ぎ入れる。', 'no_image.png', 9),
(26, 3, '軽くステアして混ぜ、シナモンスティックでデコレーションする。', 'no_image.png', 9),
(27, 1, 'シェーカーにリキュールとリンゴジュースを入れ、シェークする。', 'no_image.png', 10),
(28, 2, 'グラスに氷を入れ、キャラメルシロップを加える。', 'no_image.png', 10),
(29, 3, 'シェーキングしたリキュールとリンゴジュースを注ぎ、軽くステアして混ぜる。', 'no_image.png', 10),
(30, 1, 'シェーカーにウォッカとミントを入れ、シェークする。', 'no_image.png', 11),
(31, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 11),
(32, 3, '生姜ビールを加えて軽くステアし、ミントでデコレーションする。', 'no_image.png', 11),
(33, 1, 'シェーカーにシトラスフルーツとブルーベリーを入れ、シェークする。', 'no_image.png', 12),
(34, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 12),
(35, 3, '軽くステアして混ぜ、オレンジスライスでデコレーションする。', 'no_image.png', 12),
(36, 1, 'マグカップにウイスキーとハチミツを入れ、お湯を注ぐ。', 'no_image.png', 13),
(37, 2, 'レモンスライスを浮かべ、シナモンスティックでデコレーションする。', 'no_image.png', 13),
(38, 1, 'シェーカーにウイスキーとピーチティーを入れ、シェークする。', 'no_image.png', 14),
(39, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 14),
(40, 3, '軽くステアして混ぜ、桃の輪切りでデコレーションする。', 'no_image.png', 14),
(41, 1, 'シェーカーにラムとバニラシロップを入れ、シェークする。', 'no_image.png', 15),
(42, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 15),
(43, 3, 'オレンジジュースとパイナップルジュースを加え、軽くステアして混ぜる。', 'no_image.png', 15),
(44, 1, 'マグカップにブランデーとシナモンシロップを入れ、お湯を注ぐ。', 'no_image.png', 16),
(45, 2, 'りんごジュースを加え、軽くステアして混ぜる。', 'no_image.png', 16),
(46, 3, 'シナモンスティックでデコレーションする。', 'no_image.png', 16),
(47, 1, 'シェーカーにテキーラとストロベリーピューレを入れ、シェークする。', 'no_image.png', 17),
(48, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 17),
(49, 3, 'レモネードを加え、軽くステアして混ぜ、ストロベリーハーフでデコレーションする。', 'no_image.png', 17),
(50, 1, 'ワイングラスに氷を入れ、ローズワインを注ぐ。', 'no_image.png', 18),
(51, 2, 'ラズベリーシロップを加え、軽くステアして混ぜる。', 'no_image.png', 18),
(52, 3, 'ミントでデコレーションする。', 'no_image.png', 18),
(53, 1, 'ミントとライムをシェーカーに入れ、軽くマドラーで押して香りを引き出す。', 'no_image.png', 19),
(54, 2, '氷をグラスに入れ、ラムを注ぎ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 19),
(55, 3, '軽くステアして混ぜ、ライムホイールでデコレーションする。', 'no_image.png', 19),
(56, 1, 'ショットグラスにテキーラを注ぎ、チョコミントリキュールを浮かべる。', 'no_image.png', 20),
(57, 2, '軽くステアして混ぜ、チョコミントでデコレーションする。', 'no_image.png', 20),
(58, 1, 'シェーカーにジンとピンクグレープフルーツジュースを入れ、シェークする。', 'no_image.png', 21),
(59, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 21),
(60, 3, 'グレープフルーツソーダを加え、軽くステアして混ぜる。', 'no_image.png', 21),
(61, 1, 'シェーカーにウォッカとシトラスフルーツの絞り汁、ハチミツを入れ、シェークする。', 'no_image.png', 22),
(62, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 22),
(63, 3, 'オレンジスライスでデコレーションする。', 'no_image.png', 22),
(64, 1, 'ミントとベリーをシェーカーに入れ、軽くマドラーで押して香りを引き出す。', 'no_image.png', 23),
(65, 2, '氷をグラスに入れ、ラムを注ぎ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 23),
(66, 3, '軽くステアして混ぜ、ブルーベリーとラズベリーでデコレーションする。', 'no_image.png', 23),
(67, 1, 'シェーカーにテキーラとマンゴージュースを入れ、シェークする。', 'no_image.png', 24),
(68, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 24),
(69, 3, 'シトラスソーダを加え、軽くステアして混ぜ、マンゴーの輪切りでデコレーションする。', 'no_image.png', 24),
(70, 1, 'ショットグラスにキウイパッションフルーツリキュールを注ぎ、シロップで甘さをプラスする。', 'no_image.png', 25),
(71, 2, '軽くステアして混ぜ、キウイスライスでデコレーションする。', 'no_image.png', 25),
(72, 1, 'マグカップにメープルバーボンとりんごジュースを入れ、お湯を注ぐ。', 'no_image.png', 26),
(73, 2, '軽くステアして混ぜ、シナモンスティックでデコレーションする。', 'no_image.png', 26),
(74, 1, 'ボウルにクランベリーオレンジジュースとワインを入れ、軽くステアして混ぜる。', 'no_image.png', 27),
(75, 2, '氷をグラスに入れ、ボウルの液体を注ぎ入れる。', 'no_image.png', 27),
(76, 3, 'シナモンスティックとオレンジスライスでデコレーションする。', 'no_image.png', 27),
(77, 1, 'シェーカーにラム、ココナッツクリーム、パイナップルジュースを入れ、シェークする。', 'no_image.png', 28),
(78, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 28),
(79, 3, 'パイナップルの輪切りでデコレーションする。', 'no_image.png', 28),
(80, 1, 'ジンジャービールをグラスに注ぎ、レモンジュースとハチミツで味を調整する。', 'no_image.png', 29),
(81, 2, '氷を加え、軽くステアして混ぜ、レモンスライスでデコレーションする。', 'no_image.png', 29),
(82, 1, 'シェーカーにミントとチョコレートリキュールを入れ、軽くマドラーで押して香りを引き出す。', 'no_image.png', 30),
(83, 2, '氷をグラスに入れ、シェーカーの液体を注ぎ入れる。', 'no_image.png', 30),
(84, 3, 'チョコレートチップでデコレーションする。', 'no_image.png', 30),
(85, 1, 'グラスにアイスを入れます', 'no_image.png', 31),
(86, 2, 'ビールを注いで混ぜて完成', 'no_image.png', 31),
(87, 1, '熱燗を用意します', 'no_image.png', 32),
(88, 2, '鰹節を入れ少し混ぜたら完成', 'no_image.png', 32),
(89, 1, 'ミックスベリーを瓶に入れ、スミノフを満たします', 'no_image.png', 33),
(90, 2, '1週間冷蔵庫に入れて完成', 'no_image.png', 33),
(91, 3, '炭酸で割っても美味しいです', 'no_image.png', 33),
(92, 1, 'お好みのハイボールを作ります', 'procedure1.jpg', 34),
(93, 2, '黒胡椒をお好みでふりかけたら完成', 'procedure2.webp', 34);
