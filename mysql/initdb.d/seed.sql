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
(1, 'Classic Whiskey Sour', 'A timeless classic', 'Whiskey.jpg',  1, 1),
(2, 'Red Wine and Cheese Guide', 'Perfect for wine lovers', 'Wine.jpg', 2, 2);

INSERT INTO reviews (id, content, image, user_id, recipe_id) VALUES
(1, 'Incredible whiskey cocktail recipe.', 'review_whiskey.jpg', 1, 1),
(2, 'Loved the wine pairing suggestions!', 'review_wine.jpg', 2, 2);

INSERT INTO recipe_genre (id, recipe_id, genre_id) VALUES
(1, 1, 1),
(2, 2, 2);

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

