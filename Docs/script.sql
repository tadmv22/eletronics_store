DROP DATABASE IF EXISTS eletronics_store;
CREATE DATABASE eletronics_store;
USE eletronics_store;

CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at DATE NOT NULL DEFAULT (NOW())
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
FOREIGN KEY (user_id) references users(id)
);


CREATE TABLE IF NOT EXISTS orders_details (
order_id int,
product_id int,
unit_value decimal(10,4) NOT NULL,
quantity INT NOT NULL,
create_at DATETIME NOT NULL default(now()),
foreign key (order_id) references orders(id),
foreign key (product_id) references products(id)
);


