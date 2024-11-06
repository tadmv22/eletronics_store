DROP DATABASE IF EXISTS eletronics_store;
CREATE DATABASE eletronics_store;
USE eletronics_store;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    surname VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    zipcode VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATETIME NOT NULL DEFAULT (NOW())
);

create table products(
id INT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL UNIQUE,
value  decimal(10,4) NOT NULL,
description  VARCHAR(255) NOT NULL,
stock_quantity int NOT NULL
);

CREATE TABLE IF NOT EXISTS orders(
id INT PRIMARY KEY AUTO_INCREMENT,
status VARCHAR(50) NOT NULL,
created_at DATETIME NOT NULL default(now()),
delevery_at DATETIME,
updated_at DATETIME NOT NULL default(now()),
payment_methods VARCHAR(50),
user_id INT,
FOREIGN KEY (user_id) REFERENCES users(id)
);


CREATE TABLE IF NOT EXISTS orders_details (
order_id INT,
product_id INT,
unit_value DECIMAL(10,4) NOT NULL,
quantity INT NOT NULL,
create_at DATETIME NOT NULL default(now()),
FOREIGN KEY (order_id) REFERENCES orders(id),
FOREIGN KEY (product_id) REFERENCES products(id)
);


INSERT INTO users (name, surname, email, password, address, zipcode)
VALUES
('Carlos', 'Silva Oliveira', 'carlos.silva@outlook.com', 'senhaSegura123', 'Rua das Flores, 123', '01001-000'),
('Ana', 'Santos Almeida', 'ana.santos@gmail.com', 'senhaSegura123', 'Avenida Paulista, 1500', '01311-000'),
('José', 'Costa Pereira', 'jose.costa@yahoo.com', 'senhaSegura123', 'Rua São Bento, 200', '01011-000'),
('Maria', 'Melo Azevedo', 'maria.melo@uol.com.br', 'senhaSegura123', 'Rua Augusta, 2100', '01413-000'),
('Luiz', 'Ferreira Lima', 'luiz.ferreira@terra.com.br', 'senhaSegura123', 'Rua 25 de Março, 500', '01021-200'),
('Paula', 'Gomes Barbosa', 'paula.gomes@bol.com.br', 'senhaSegura123', 'Avenida Rebouças, 1234', '05402-000'),
('Ricardo', 'Carvalho dos Santos', 'ricardo.carvalho@outlook.com', 'senhaSegura123', 'Rua Vergueiro, 150', '01504-000'),
('Juliana', 'Ribeiro da Costa', 'juliana.ribeiro@gmail.com', 'senhaSegura123', 'Rua Consolação, 300', '01302-900'),
('Pedro', 'Martins Dias', 'pedro.martins@yahoo.com', 'senhaSegura123', 'Rua da Glória, 210', '01510-000'),
('Fernanda', 'Lopes Fernandes', 'fernanda.lopes@uol.com.br', 'senhaSegura123', 'Rua Tabapuã, 123', '04533-000'),
('Roberto', 'Alves Cardoso', 'roberto.alves@terra.com.br', 'senhaSegura123', 'Avenida Faria Lima, 4500', '04538-132'),
('Sandra', 'Sousa Rocha', 'sandra.sousa@bol.com.br', 'senhaSegura123', 'Rua Boa Vista, 220', '01014-000'),
('Marcelo', 'Pereira Moraes', 'marcelo.pereira@outlook.com', 'senhaSegura123', 'Rua Haddock Lobo, 300', '01414-001'),
('Patrícia', 'Oliveira Lima', 'patricia.oliveira@gmail.com', 'senhaSegura123', 'Rua Bela Cintra, 700', '01415-000'),
('Tiago', 'Rodrigues Araújo', 'tiago.rodrigues@yahoo.com', 'senhaSegura123', 'Rua da Liberdade, 150', '01503-000'),
('Marta', 'Barros Correia', 'marta.barros@uol.com.br', 'senhaSegura123', 'Avenida Ibirapuera, 2500', '04028-000'),
('Rafael', 'Ferreira Campos', 'rafael.ferreira@terra.com.br', 'senhaSegura123', 'Avenida Paulista, 2222', '01310-200'),
('Beatriz', 'Martins de Oliveira', 'beatriz.martins@bol.com.br', 'senhaSegura123', 'Rua dos Trilhos, 345', '03168-010'),
('Gustavo', 'Nunes Ribeiro', 'gustavo.nunes@outlook.com', 'senhaSegura123', 'Rua Bela Cintra, 1234', '01415-000'),
('Carla', 'Teixeira Souza', 'carla.teixeira@gmail.com', 'senhaSegura123', 'Rua Clélia, 678', '05042-000'),
('Alexandre', 'Silveira Machado', 'alexandre.silveira@yahoo.com', 'senhaSegura123', 'Rua Doutor Arnaldo, 567', '01255-000'),
('Camila', 'Gonçalves Pinto', 'camila.goncalves@uol.com.br', 'senhaSegura123', 'Rua João Cachoeira, 150', '04535-000'),
('Felipe', 'Cunha Santana', 'felipe.cunha@terra.com.br', 'senhaSegura123', 'Rua Harmonia, 230', '05435-001'),
('André', 'Vieira Mendes', 'andre.vieira@bol.com.br', 'senhaSegura123', 'Rua dos Estudantes, 345', '01505-000'),
('Débora', 'Ramos Souza', 'debora.ramos@outlook.com', 'senhaSegura123', 'Rua Lins de Vasconcelos, 500', '01538-001'),
('Leandro', 'Batista Almeida', 'leandro.batista@gmail.com', 'senhaSegura123', 'Avenida Pacaembu, 600', '01234-010'),
('Lorena', 'Freitas Vieira', 'lorena.freitas@yahoo.com', 'senhaSegura123', 'Rua Manuel da Nóbrega, 350', '04001-000'),
('Rodrigo', 'Moreira Azevedo', 'rodrigo.moreira@uol.com.br', 'senhaSegura123', 'Rua Cipriano Barata, 450', '04205-000'),
('Tatiana', 'Figueiredo Lima', 'tatiana.figueiredo@terra.com.br', 'senhaSegura123', 'Rua da Mooca, 780', '03162-020'),
('Maurício', 'Campos Martins', 'mauricio.campos@bol.com.br', 'senhaSegura123', 'Rua Augusta, 1100', '01305-000'),
('Larissa', 'Andrade Oliveira', 'larissa.andrade@outlook.com', 'senhaSegura123', 'Rua Gomes de Carvalho, 1500', '04547-001'),
('Fabio', 'Carvalho Rocha', 'fabio.carvalho@gmail.com', 'senhaSegura123', 'Avenida Brigadeiro Faria Lima, 100', '01452-000'),
('Júlia', 'Silva Cruz', 'julia.silva@yahoo.com', 'senhaSegura123', 'Rua Maria Antônia, 250', '01222-010'),
('Rafael', 'Santos Lopes', 'rafael.santos@uol.com.br', 'senhaSegura123', 'Rua Vergueiro, 2900', '04101-300'),
('Letícia', 'Medeiros Almeida', 'leticia.medeiros@terra.com.br', 'senhaSegura123', 'Rua Diogo de Faria, 1234', '04037-002'),
('Fernando', 'Pires Gonçalves', 'fernando.pires@bol.com.br', 'senhaSegura123', 'Avenida Santo Amaro, 400', '04506-000'),
('Viviane', 'Cardoso Rocha', 'viviane.cardoso@outlook.com', 'senhaSegura123', 'Rua Antônio de Barros, 235', '03401-000'),
('Carlos', 'Lima Rocha', 'carlos.lima@gmail.com', 'senhaSegura123', 'Rua Maria Marcolina, 512', '03001-020'),
('Mariana', 'Martins da Silva', 'mariana.martins@yahoo.com', 'senhaSegura123', 'Rua Santa Cruz, 654', '04122-000'),
('Vinícius', 'Farias Alves', 'vinicius.farias@uol.com.br', 'senhaSegura123', 'Avenida Ipiranga, 1800', '01046-010'),
('Simone', 'Albuquerque Ribeiro', 'simone.albuquerque@terra.com.br', 'senhaSegura123', 'Rua Fradique Coutinho, 1000', '05416-001'),
('Tiago', 'Oliveira Martins', 'tiago.oliveira@bol.com.br', 'senhaSegura123', 'Rua Jacarezinho, 190', '05414-000'),
('Thaís', 'Dias Monteiro', 'thais.dias@outlook.com', 'senhaSegura123', 'Rua dos Trilhos, 900', '03168-020'),
('Ricardo', 'Lopes Pereira', 'ricardo.lopes@gmail.com', 'senhaSegura123', 'Rua Pamplona, 450', '01405-000'),
('Isabela', 'Matos Correia', 'isabela.matos@yahoo.com', 'senhaSegura123', 'Rua dos Jasmins, 78', '03254-010'),
('Lucas', 'Sousa Nogueira', 'lucas.sousa@uol.com.br', 'senhaSegura123', 'Rua da Prata, 654', '03001-030'),
('Natália', 'Ramos Barreto', 'natalia.ramos@terra.com.br', 'senhaSegura123', 'Avenida Senador Queirós, 180', '01026-001'),
('Renato', 'Cardoso Silva', 'renato.cardoso@bol.com.br', 'senhaSegura123', 'Rua dos Timbiras, 240', '01208-010');

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

