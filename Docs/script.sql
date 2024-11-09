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


CREATE TABLE IF NOT EXISTS customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
	email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
value  decimal(10,4) NOT NULL,
description  VARCHAR(255) NOT NULL,
stock_quantity int NOT NULL
);

CREATE TABLE IF NOT EXISTS orders(
id INT PRIMARY KEY AUTO_INCREMENT,
status VARCHAR(50) NOT NULL,
created_at DATETIME NOT NULL  DEFAULT NOW(),
delevery_at DATETIME,
updated_at DATETIME NOT NULL  DEFAULT NOW(),
payment_methods VARCHAR(50),
customer_id INT,
FOREIGN KEY (customer_id) REFERENCES customers(id)
);


CREATE TABLE IF NOT EXISTS orders_details (
order_id INT,
product_id INT,
unit_value DECIMAL(10,4) NOT NULL,
quantity INT NOT NULL,
create_at DATETIME NOT NULL  DEFAULT NOW(),
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (product_id) REFERENCES products(id)
);


INSERT INTO users (id,name, surname, email, password)
VALUES
(1,'Carlos', 'Silva Oliveira', 'carlos.silva@outlook.com', 'senhaSegura123'),
(2,'Ana', 'Santos Almeida', 'ana.santos@gmail.com', 'senhaSegura123'),
(3,'Pedro', 'Santos Almeida', 'pedro.santos@gmail.com', 'senhaSegura123');



INSERT INTO `products` (`name`, `value`, `description`, `stock_quantity`) VALUES
('Smartphone Galaxy S20', 999.9900, 'Smartphone Samsung Galaxy S20 com 128GB', 15),
('Notebook Dell Inspiron', 2799.9900, 'Notebook Dell Inspiron com 8GB RAM e 512GB SSD', 8),
('Smart TV LG 55"', 2299.9900, 'Smart TV LG 4K UHD 55 Polegadas', 5),
('Fone Bluetooth JBL', 199.9900, 'Fone de ouvido JBL sem fio', 25),
('Câmera Canon EOS', 1499.9900, 'Câmera Digital Canon EOS com lente 18-55mm', 12),
('Impressora HP LaserJet', 499.9900, 'Impressora HP LaserJet Pro P1102w', 10),
('Tablet Apple iPad', 3299.9900, 'Apple iPad 10.2" Wi-Fi 128GB', 6),
('Monitor Samsung 24"', 849.9900, 'Monitor Samsung LED Full HD 24"', 14),
('Teclado Mecânico HyperX', 349.9900, 'Teclado Mecânico HyperX Alloy FPS Pro', 20),
('Mouse Gamer Logitech', 149.9900, 'Mouse Logitech G203 Prodigy RGB', 30),
('Caixa de Som Bluetooth Sony', 499.9900, 'Caixa de Som Sony Extra Bass Bluetooth', 18),
('SSD Kingston 480GB', 279.9900, 'SSD Kingston 480GB SATA III', 22),
('Placa de Vídeo GTX 1660', 1899.9900, 'Placa de vídeo NVIDIA GeForce GTX 1660', 7),
('HD Externo 1TB', 399.9900, 'HD Externo Seagate Expansion 1TB', 16),
('Carregador Portátil 10000mAh', 99.9900, 'Power Bank de 10000mAh com saída USB', 35),
('Webcam Logitech HD', 249.9900, 'Webcam Logitech C270 HD', 9),
('Switch 8 Portas TP-Link', 129.9900, 'Switch de Rede TP-Link TL-SF1008D', 40),
('Roteador Wi-Fi TP-Link', 159.9900, 'Roteador Wi-Fi TP-Link Archer C6', 13),
('Smartwatch Xiaomi Mi Band', 299.9900, 'Smartwatch Xiaomi Mi Band 6', 27),
('Console PlayStation 5', 4999.9900, 'Console Sony PlayStation 5', 4),
('Drone DJI Mini 2', 3199.9900, 'Drone DJI Mini 2 Fly More Combo', 6),
('Lâmpada Inteligente Xiaomi', 69.9900, 'Lâmpada LED Inteligente Xiaomi Wi-Fi', 40),
('Carregador Rápido Samsung', 119.9900, 'Carregador Turbo Samsung 25W', 25),
('Roteador Mesh Xiaomi', 299.9900, 'Roteador Wi-Fi Mesh Xiaomi AX3000', 10),
('Controle Xbox Series X', 349.9900, 'Controle sem fio Xbox Series X', 30),
('Headset Gamer Redragon', 199.9900, 'Headset Redragon Zeus 2', 18),
('Smart Speaker Amazon Echo Dot', 399.9900, 'Amazon Echo Dot com Alexa', 19),
('Projetor Epson 1080p', 2999.9900, 'Projetor Epson Full HD 1080p', 3),
('Smartphone iPhone 12', 3999.9900, 'Apple iPhone 12 64GB', 6),
('Notebook Lenovo Ideapad', 2899.9900, 'Notebook Lenovo com 8GB RAM e 256GB SSD', 9),
('Câmera GoPro HERO9', 2499.9900, 'Câmera GoPro HERO9 Black', 8),
('Smart TV Samsung 43"', 1999.9900, 'Smart TV Samsung 43" 4K UHD', 7);

