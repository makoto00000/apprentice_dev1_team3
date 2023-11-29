-- ユーザーテーブル
CREATE TABLE users (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    image TEXT
);

-- ジャンルテーブル
CREATE TABLE genres (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    category VARCHAR(255) NOT NULL
);

-- レシピテーブル
CREATE TABLE recipes (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    name TEXT NOT NULL,
    point TEXT,
    image TEXT NOT NULL,
    user_id BIGINT NOT NULL,
    genre_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

-- レビューテーブル
CREATE TABLE reviews (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    content TEXT NOT NULL,
    image TEXT,
    user_id BIGINT NOT NULL,
    recipe_id BIGINT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

CREATE TABLE ingredients (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_num BIGINT NOT NULL,
    name VARCHAR(255) NOT NULL,
    amount VARCHAR(255) NOT NULL,
    recipe_id BIGINT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

-- 手順テーブル
CREATE TABLE procedures (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    order_num BIGINT NOT NULL,
    procedure_text TEXT NOT NULL,
    image TEXT,
    recipe_id BIGINT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id)
);

-- レシピジャンルテーブル
CREATE TABLE recipe_genre (
    id BIGINT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    recipe_id BIGINT NOT NULL,
    genre_id BIGINT NOT NULL,
    FOREIGN KEY (recipe_id) REFERENCES recipes(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id)
);

INSERT INTO users (id, name, email, password, image) VALUES
(1, 'John Doe', 'john@example.com', 'password123', 'image1.jpg'),
(2, 'Jane Smith', 'jane@example.com', 'password456', 'image2.jpg');

INSERT INTO genres (id, name, category) VALUES
(1, 'Cocktails', 'Beverage'),
(2, 'Wine Pairings', 'Food');

INSERT INTO recipes (id, name, point, image, user_id, genre_id) VALUES
(1, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(2, 'Red Wine and Cheese Guide', 'Perfect for wine lovers', 'recipe_image.png', 2, 2),
(3, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(4, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(5, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(6, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(7, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(8, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(9, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(10, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(11, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(12, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(13, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(14, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(15, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(16, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(17, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(18, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(19, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(20, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(21, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(22, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(23, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(24, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(25, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(26, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(27, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(28, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(29, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(30, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(31, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(32, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(33, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(34, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(35, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(36, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(37, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(38, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(39, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(40, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(41, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(42, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(43, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(44, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(45, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(46, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(47, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(48, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(49, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1),
(50, 'Classic Whiskey Sour', 'A timeless classic', 'recipe_image.png',  1, 1);

INSERT INTO reviews (id, content, image, user_id, recipe_id) VALUES
(1, 'Incredible whiskey cocktail recipe.', 'review_whiskey.jpg', 1, 1),
(2, 'Loved the wine pairing suggestions!', 'review_wine.jpg', 2, 2);

INSERT INTO recipe_genre (id, recipe_id, genre_id) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 1),
(4, 4, 1),
(5, 5, 1),
(6, 6, 1),
(7, 7, 1),
(8, 8, 1),
(9, 9, 1),
(10, 10, 1),
(11, 11, 1),
(12, 12, 1),
(13, 13, 1),
(14, 14, 1),
(15, 15, 1),
(16, 16, 1),
(17, 17, 1),
(18, 18, 1),
(19, 19, 1),
(20, 20, 1),
(21, 21, 1),
(22, 22, 1),
(23, 23, 1),
(24, 24, 1),
(25, 25, 1),
(26, 26, 1),
(27, 27, 1),
(28, 28, 1),
(29, 29, 1),
(30, 30, 1),
(31, 31, 1),
(32, 32, 1),
(33, 33, 1),
(34, 34, 1),
(35, 35, 1),
(36, 36, 1),
(37, 37, 1),
(38, 38, 1),
(39, 39, 1),
(40, 40, 1),
(41, 41, 1),
(42, 42, 1),
(43, 43, 1),
(44, 44, 1),
(45, 45, 1),
(46, 46, 1),
(47, 47, 1),
(48, 48, 1),
(49, 49, 1),
(50, 50, 1);

INSERT INTO ingredients (id, order_num, name, amount, recipe_id) VALUES
(1, 1, 'Whiskey', '60ml', 1),
(2, 2, 'Lemon Juice', '30ml', 1),
(3, 1, 'Red Wine', 'Bottle', 2),
(4, 2, 'Assorted Cheese', '200g', 2);


INSERT INTO procedures (id, order_num, procedure_text, image, recipe_id) VALUES
(1, 1, 'Mix whiskey with lemon juice and syrup', 'whiskey_sour_procedure.jpg', 1),
(2, 2, 'Shake well and strain into glass', 'whiskey_sour_shake.jpg', 1),
(3, 1, 'Select cheeses to complement wine', 'wine_cheese_select.jpg', 2),
(4, 2, 'Arrange cheese and wine for serving', 'wine_cheese_serve.jpg', 2);

