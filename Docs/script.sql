DROP DATABASE IF EXISTS eletronics_store;
CREATE DATABASE eletronics_store;
USE eletronics_store;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE IF NOT EXISTS categories (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    description VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS products (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL UNIQUE,
    value DECIMAL(10 , 4 ) NOT NULL,
    description TEXT NOT NULL,
    stock_quantity INT NOT NULL CHECK (stock_quantity >= 0),
    category_id INT,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS coupons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT,
	discount_value DECIMAL(10, 2) NOT NULL,
    start_at DATETIME NOT NULL, 
    expiration_at DATETIME, 
    is_active BOOLEAN NOT NULL DEFAULT TRUE, 
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS product_coupon (
    product_id INT NOT NULL,
    coupon_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (product_id, coupon_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (coupon_id) REFERENCES coupons(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE IF NOT EXISTS produt_image (
    id INT PRIMARY KEY AUTO_INCREMENT,
    path VARCHAR(255) NOT NULL,
    product_id INT,
    FOREIGN KEY (product_id) REFERENCES products (id) ON DELETE SET NULL
);


INSERT INTO users (name, surname, email, password, is_active, created_at, updated_at) VALUES
('Alice', 'Silva', 'alice.silva@gmail.com', 'senha123', TRUE, NOW(), NOW()),
('Bruno', 'Souza', 'bruno.souza@yahoo.com', 'senha123', TRUE, NOW(), NOW()),
('Carla', 'Santos', 'carla.santos@outlook.com', 'senha123', TRUE, NOW(), NOW()),
('Marcelo', 'Moreno', 'marcelo.moreno@senac.com', '12345678', TRUE, NOW(), NOW());

-- Inserindo categorias de produtos eletrônicos
INSERT INTO categories (name, description) VALUES
('Smartphones', 'Dispositivos móveis para comunicação e entretenimento'),
('Televisores', 'Televisores de diferentes tamanhos e tecnologias, como LED, OLED, e QLED'),
('Computadores', 'Computadores desktop e acessórios para trabalho e entretenimento'),
('Notebooks', 'Laptops de várias marcas e especificações para uso pessoal e profissional'),
('Tablets', 'Dispositivos portáteis maiores que smartphones, ideais para leitura e multimídia'),
('Acessórios', 'Itens complementares para diversos dispositivos, como cabos, cases e carregadores'),
('Áudio', 'Fones de ouvido, caixas de som e sistemas de som para áudio de alta qualidade'),
('Câmeras', 'Câmeras fotográficas e acessórios para fotografia e vídeo'),
('Consoles', 'Consoles e acessórios de videogame para jogadores casuais e hardcore'),
('Casa Inteligente', 'Dispositivos de automação residencial, como lâmpadas e fechaduras inteligentes'),
('PCs', 'Dispositivos de automação residencial, como lâmpadas e fechaduras inteligentes');


-- Inserindo produtos eletrônicos variados
INSERT INTO products (name, value, description, stock_quantity, category_id) VALUES
('iPhone 14', 5999.99, 'Smartphone Apple iPhone 14 com 128GB de armazenamento', 20, 1),
('Samsung Galaxy S23', 3999.99, 'Smartphone Samsung Galaxy S23 com 256GB de armazenamento', 15, 1),
('MacBook Pro', 12999.99, 'Notebook Apple MacBook Pro com 16GB RAM e 512GB SSD', 10, 2),
('Dell XPS 13', 7999.99, 'Notebook Dell XPS 13 com 8GB RAM e 256GB SSD', 12, 2),
('iPad Air', 4499.99, 'Tablet Apple iPad Air com tela de 10.9" e 64GB', 18, 3),
('Samsung Galaxy Tab S8', 3499.99, 'Tablet Samsung Galaxy Tab S8 com 128GB', 20, 3),
('TV LG OLED 55', 7999.99, 'Televisor LG OLED 55" 4K com AI ThinQ', 8, 4),
('TV Samsung QLED 65"', 10999.99, 'Televisor Samsung QLED 65" 4K com HDR', 6, 4),
('Carregador Rápido 20W', 199.99, 'Carregador rápido de 20W compatível com smartphones e tablets', 50, NULL),
('Cabo USB-C para Lightning', 99.99, 'Cabo de conexão USB-C para Lightning de 1 metro', 40, NULL),
('PlayStation 5', 4999.99, 'Console de videogame Sony PlayStation 5 com SSD de 825GB', 5, 6),
('Xbox Series X', 4699.99, 'Console de videogame Microsoft Xbox Series X com 1TB', 7, 6),
('Fone de Ouvido Bluetooth JBL', 299.99, 'Fone de ouvido JBL Bluetooth com tecnologia Pure Bass', 30, 7),
('Caixa de Som Portátil JBL', 599.99, 'Caixa de som portátil JBL com resistência à água e Bluetooth', 25, 7),
('Drone DJI Mini 3', 3499.99, 'Drone DJI Mini 3 com câmera 4K e 30 minutos de voo', 4, 8),
('Drone DJI Air 2S', 4999.99, 'Drone DJI Air 2S com câmera de 1" e 5.4K', 2, 8),
('Câmera Canon EOS Rebel T7', 2999.99, 'Câmera DSLR Canon EOS Rebel T7 com lente 18-55mm', 10, 9),
('Câmera Sony Alpha a7 III', 8999.99, 'Câmera mirrorless Sony Alpha a7 III com lente 28-70mm', 5, 9),
('Liquidificador Philips Walita', 399.99, 'Liquidificador Philips Walita com 5 velocidades e 700W', 15, 10),
('Cafeteira Expresso Nespresso', 499.99, 'Cafeteira expresso Nespresso com sistema de cápsulas', 20, 10),
('Aspirador de Pó Vertical Electrolux', 799.99, 'Aspirador de pó vertical Electrolux sem fio', 12, 10),
('Air Fryer Mondial', 599.99, 'Fritadeira Air Fryer Mondial com capacidade de 3.5L', 18, 10),
('Smartwatch Samsung Galaxy Watch', 1299.99, 'Smartwatch Samsung Galaxy Watch com monitoramento de saúde', 25, 1),
('Smartwatch Apple Watch Series 8', 1999.99, 'Apple Watch Series 8 com GPS e tela retina', 15, 1),
('Notebook Lenovo IdeaPad 3', 3999.99, 'Notebook Lenovo IdeaPad 3 com 8GB RAM e 256GB SSD', 10, 2);


INSERT INTO coupons (id,code, description, discount_value, start_at, expiration_at, is_active)
VALUES 
    (1,'SUMMER2024', 'Desconto de verão', 15.00, '2024-06-01 00:00:00', '2024-08-31 23:59:59', TRUE),
    (2,'WINTER2024', 'Desconto de inverno', 20.00, '2024-12-01 00:00:00', '2025-02-28 23:59:59', TRUE),
    (3,'WELCOME10', 'Desconto de boas-vindas', 10.00, '2024-01-01 00:00:00', NULL, TRUE),
    (4,'FREESHIP', 'Frete grátis', 5.00, '2024-01-01 00:00:00', NULL, FALSE),
    (5,'BLACKFRIDAY2024', 'Desconto de Black Friday 2024', 50.00, '2024-11-25 00:00:00', '2024-11-30 23:59:59', TRUE),
    (6,'CYBERMONDAY2024', 'Desconto de Cyber Monday 2024', 30.00, '2024-12-02 00:00:00', '2024-12-02 23:59:59', TRUE);

INSERT INTO product_coupon (product_id,coupon_id) VALUES 
(1,2),
(1,3),
(2,2);


CREATE VIEW CategoryViewAnalytics AS
SELECT 
    c.id,
    c.name,
    COUNT(p.id) AS total_products,
    SUM(p.stock_quantity) AS total_units,
    SUM(p.value * p.stock_quantity) AS total_balance,
    IFNULL(SUM(p.value * p.stock_quantity) / NULLIF(SUM(p.stock_quantity), 0), 0) AS average_value_per_unit
FROM
    eletronics_store.categories c
        LEFT JOIN
    eletronics_store.products p ON c.id = p.category_id
GROUP BY 
    c.id, c.name;
    
    
CREATE VIEW ProductsViewAnalytics AS
    SELECT 
        SUM(stock_quantity) AS total_units,
        SUM(value * stock_quantity) total_balanceas,
        SUM(value * stock_quantity) / SUM(stock_quantity) * 100 AS averange
    FROM
        eletronics_store.products