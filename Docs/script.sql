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
    created_at DATETIME NOT NULL DEFAULT NOW(),
    updated_at DATETIME DEFAULT NOW()
);


CREATE TABLE IF NOT EXISTS categories(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
value  decimal(10,4) NOT NULL,
description  VARCHAR(255) NOT NULL,
stock_quantity int NOT NULL,
category_id INT NOT NULL,
FOREIGN KEY (category_id) REFERENCES categories(id)
);

CREATE TABLE IF NOT EXISTS produt_image(
id INT PRIMARY KEY AUTO_INCREMENT,
path VARCHAR(255) NOT NULL,
product_id INT,
FOREIGN KEY (product_id) REFERENCES products(id)
);



INSERT INTO users (name, surname, email, password, is_active, created_at, updated_at) VALUES
('Alice', 'Silva', 'alice.silva@gmail.com', 'senha123', TRUE, NOW(), NOW()),
('Bruno', 'Souza', 'bruno.souza@yahoo.com', 'senha123', TRUE, NOW(), NOW()),
('Carla', 'Santos', 'carla.santos@outlook.com', 'senha123', TRUE, NOW(), NOW()),
('Daniel', 'Oliveira', 'daniel.oliveira@icloud.com', 'senha123', TRUE, NOW(), NOW()),
('Eduarda', 'Lima', 'eduarda.lima@hotmail.com', 'senha123', TRUE, NOW(), NOW()),
('Felipe', 'Mendes', 'felipe.mendes@live.com', 'senha123', TRUE, NOW(), NOW()),
('Gabriela', 'Ferreira', 'gabriela.ferreira@gmail.com', 'senha123', TRUE, NOW(), NOW()),
('Henrique', 'Ribeiro', 'henrique.ribeiro@yahoo.com', 'senha123', TRUE, NOW(), NOW()),
('Isabela', 'Martins', 'isabela.martins@outlook.com', 'senha123', TRUE, NOW(), NOW()),
('João', 'Barros', 'joao.barros@icloud.com', 'senha123', TRUE, NOW(), NOW()),
('Karina', 'Costa', 'karina.costa@gmail.com', 'senha123', TRUE, NOW(), NOW()),
('Leonardo', 'Moreira', 'leonardo.moreira@yahoo.com', 'senha123', TRUE, NOW(), NOW()),
('Mariana', 'Pereira', 'mariana.pereira@outlook.com', 'senha123', TRUE, NOW(), NOW()),
('Nicolas', 'Almeida', 'nicolas.almeida@icloud.com', 'senha123', TRUE, NOW(), NOW()),
('Olivia', 'Gomes', 'olivia.gomes@hotmail.com', 'senha123', TRUE, NOW(), NOW()),
('Pedro', 'Cardoso', 'pedro.cardoso@live.com', 'senha123', TRUE, NOW(), NOW()),
('Quésia', 'Araújo', 'quesia.araujo@gmail.com', 'senha123', TRUE, NOW(), NOW()),
('Rafael', 'Farias', 'rafael.farias@yahoo.com', 'senha123', TRUE, NOW(), NOW()),
('Sofia', 'Rodrigues', 'sofia.rodrigues@outlook.com', 'senha123', TRUE, NOW(), NOW()),
('Thiago', 'Vieira', 'thiago.vieira@icloud.com', 'senha123', TRUE, NOW(), NOW());


-- Inserindo categorias de produtos eletrônicos
INSERT INTO categories (name) VALUES
('Smartphones'),
('Notebooks'),
('Tablets'),
('Televisores'),
('Acessórios'),
('Consoles de Videogame'),
('Áudio e Fones de Ouvido'),
('Drones'),
('Câmeras Digitais'),
('Eletrodomésticos');

-- Inserindo produtos eletrônicos variados
INSERT INTO products (name, value, description, stock_quantity, category_id) VALUES
('iPhone 14', 5999.99, 'Smartphone Apple iPhone 14 com 128GB de armazenamento', 20, 1),
('Samsung Galaxy S23', 3999.99, 'Smartphone Samsung Galaxy S23 com 256GB de armazenamento', 15, 1),
('MacBook Pro', 12999.99, 'Notebook Apple MacBook Pro com 16GB RAM e 512GB SSD', 10, 2),
('Dell XPS 13', 7999.99, 'Notebook Dell XPS 13 com 8GB RAM e 256GB SSD', 12, 2),
('iPad Air', 4499.99, 'Tablet Apple iPad Air com tela de 10.9" e 64GB', 18, 3),
('Samsung Galaxy Tab S8', 3499.99, 'Tablet Samsung Galaxy Tab S8 com 128GB', 20, 3),
('TV LG OLED 55"', 7999.99, 'Televisor LG OLED 55" 4K com AI ThinQ', 8, 4),
('TV Samsung QLED 65"', 10999.99, 'Televisor Samsung QLED 65" 4K com HDR', 6, 4),
('Carregador Rápido 20W', 199.99, 'Carregador rápido de 20W compatível com smartphones e tablets', 50, 5),
('Cabo USB-C para Lightning', 99.99, 'Cabo de conexão USB-C para Lightning de 1 metro', 40, 5),
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
