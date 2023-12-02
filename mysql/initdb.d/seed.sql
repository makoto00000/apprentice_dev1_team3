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
(1, 'John Doe', 'john@example.com', 'password123', 'image1.jpg'),
(2, 'Jane Smith', 'jane@example.com', 'password456', 'image2.jpg');

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
(1, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 1, 1),
(2, 'Red Wine and Cheese Guide','Perfect for wine lovers', 'Perfect for wine lovers', 'recipe_image.png', 2, 2, 2),
(3, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 3, 3),
(4, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 4, 4),
(5, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 5, 5),
(6, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 6, 6),
(7, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 7, 1),
(8, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 8, 2),
(9, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 9, 3),
(10, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 10, 4),
(11, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 11, 5),
(12, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 12, 6),
(13, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 1, 1),
(14, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 2, 2),
(15, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 3, 3),
(16, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 4, 4),
(17, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 5, 5),
(18, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 6, 6),
(19, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 7, 1),
(20, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 8, 2),
(21, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 9, 3),
(22, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 10, 4),
(23, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 11, 5),
(24, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 12, 6),
(25, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 1, 1),
(26, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 2, 2),
(27, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 3, 3),
(28, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 4, 4),
(29, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 5, 5),
(30, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 6, 6),
(31, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 7, 1),
(32, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 8, 2),
(33, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 9, 3),
(34, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 10, 4),
(35, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 11, 5),
(36, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 12, 6),
(37, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 1, 1),
(38, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 2, 2),
(39, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 3, 3),
(40, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 4, 4),
(41, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 5, 5),
(42, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 6, 6),
(43, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 7, 1),
(44, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 8, 2),
(45, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 9, 3),
(46, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 10, 4),
(47, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 11, 5),
(48, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 12, 6),
(49, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 1, 1),
(50, 'Classic Whiskey Sour', 'A timeless classic', 'A timeless classic', 'recipe_image.png',  1, 2, 2);

INSERT INTO reviews (id, content, image, user_id, recipe_id) VALUES
(1, 'Incredible whiskey cocktail recipe.', 'review_whiskey.jpg', 1, 1),
(2, 'Loved the wine pairing suggestions!', 'review_wine.jpg', 2, 2);


INSERT INTO ingredients (id, order_num, name, amount, recipe_id) VALUES
(1, 1, 'Whiskey', '60ml', 1),
(2, 2, 'Lemon Juice', '30ml', 1),
(3, 1, 'Red Wine', 'Bottle', 2),
(4, 2, 'Assorted Cheese', '200g', 2),
(5, 2, 'Whiskey', '60ml', 1);

INSERT INTO procedures (id, order_num, procedure_text, image, recipe_id) VALUES
(1, 1, 'Mix whiskey with lemon juice and syrup', 'whiskey_sour_procedure.jpg', 1),
(2, 2, 'Shake well and strain into glass', 'whiskey_sour_shake.jpg', 1),
(3, 1, 'Select cheeses to complement wine', 'wine_cheese_select.jpg', 2),
(4, 2, 'Arrange cheese and wine for serving', 'wine_cheese_serve.jpg', 2);

