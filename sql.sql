DROP DATABASE LojaTenis;

CREATE DATABASE LojaTenis;

USE LojaTenis;

CREATE TABLE utilizadores (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    saldo DECIMAL(10,2) NOT NULL DEFAULT 0,
    is_admin BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY (id)
);

CREATE TABLE sneaker_modelos (
    id INT NOT NULL AUTO_INCREMENT,
    model VARCHAR(255) NOT NULL,
    marca VARCHAR(255) NOT NULL,
    data_lancamento DATE NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE sneakers (
    id INT NOT NULL AUTO_INCREMENT,
    model_id INT NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL DEFAULT 0,
    tamanhos VARCHAR(255) NOT NULL,
    img VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (model_id) REFERENCES sneaker_modelos(id)
);

CREATE TABLE vendas (
    id INT NOT NULL AUTO_INCREMENT,
    sneaker_id INT NOT NULL,
    utilizador_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco DECIMAL(10,2) NOT NULL,
    data_venda TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    FOREIGN KEY (sneaker_id) REFERENCES sneakers(id),
    FOREIGN KEY (utilizador_id) REFERENCES utilizadores(id)
);

DELIMITER //
CREATE PROCEDURE atualizar_stock_sneaker(IN sneaker_id INT, IN quantity INT)
BEGIN
    UPDATE sneakers
    SET stock = stock - quantity
    WHERE id = sneaker_id;
END
//
CREATE PROCEDURE inserirCompra (IN sneaker_id INT, IN utilizador_id INT, IN quantidade INT)
BEGIN
    DECLARE tmp_preco DECIMAL(10,2);
    DECLARE tmp_stock INT;
    SELECT preco, stock INTO tmp_preco, tmp_stock FROM sneakers WHERE id = sneaker_id;

    IF quantidade <= tmp_stock THEN
        SET tmp_preco = tmp_preco * quantidade;
        START TRANSACTION;
        INSERT INTO vendas (sneaker_id, utilizador_id, quantidade, preco)
        VALUES (sneaker_id, utilizador_id, quantidade, tmp_preco);
        CALL atualizar_stock_sneaker(sneaker_id, quantidade);
        COMMIT;
    ELSE
        SELECT 'Stock insuficiente';
    END IF;
END
//
CREATE PROCEDURE listarUltimasVendas(IN qtd INT)
BEGIN
    SELECT sneaker_id, utilizador_id, quantidade, preco, data_venda 
    FROM vendas
    ORDER BY data_venda DESC
    LIMIT qtd;
END
//
CREATE VIEW sneaker_infos AS
    SELECT 
        sneaker_modelos.model,
        sneaker_modelos.marca,
        sneaker_modelos.data_lancamento,
        sneakers.nome,
        sneakers.preco,
        sneakers.tamanhos,
        sneakers.img
    FROM
        sneaker_modelos
    JOIN
        sneakers ON sneaker_modelos.id = sneakers.model_id;
//
CREATE VIEW info_vendas_formatado AS
    SELECT 
        sneakers.nome AS sneaker_nome,
        utilizadores.nome AS cliente_nome,
        vendas.quantidade,
        vendas.preco,
        vendas.data_venda
    FROM
        vendas
    JOIN
        utilizadores ON vendas.utilizador_id = utilizadores.id
    JOIN
        sneakers ON vendas.sneaker_id = sneakers.id;
//
CREATE TRIGGER verificarSaldoPreVenda
BEFORE INSERT ON vendas
FOR EACH ROW
BEGIN
    DECLARE tmp_saldo DECIMAL(10,2);
    SELECT saldo INTO tmp_saldo FROM utilizadores WHERE id = NEW.utilizador_id;
    IF tmp_saldo < (SELECT preco FROM sneakers WHERE id = NEW.sneaker_id) * NEW.quantidade THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Fundos insuficientes para efetuar compra';
    END IF;
END
//
CREATE TRIGGER atualizarSaldoPosVenda
AFTER INSERT ON vendas
FOR EACH ROW
BEGIN
    DECLARE preco_total DECIMAL(10,2);
    SET preco_total = (SELECT preco FROM sneakers WHERE id = NEW.sneaker_id) * NEW.quantidade;
    UPDATE utilizadores SET saldo = saldo - preco_total WHERE id = NEW.utilizador_id;
END

INSERT INTO utilizadores (nome, email, password, saldo) 
VALUES ('Francisco Nascimento', 'sanfran1998@gmail.com', 'Sanfran1998 :)', 100.00);

INSERT INTO utilizadores (nome, email, password, saldo) 
VALUES ('Beatriz', 'bea@email.com', 'dbManager', 50.00);

INSERT INTO utilizadores (nome, email, password, saldo) 
VALUES ('Pedro Teixeira', 'RockAndStone@dwarfmail.com', 'oldmanshower123', 0);

INSERT INTO utilizadores (nome, email, password, saldo, is_admin) 
VALUES ('Guilherme Silva', 'gui@email.com', 'nickGur', 1000000, 1);

INSERT INTO utilizadores (nome, email, password, saldo, is_admin) 
VALUES ('Pedro Martins', 'pedro.martins@email.com', 'password112', 150.00, 1);


INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Air Jordan 1', 'Nike', '2022-01-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Yeezy Boost 350', 'Adidas', '2022-02-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Air Max 90', 'Nike', '2022-03-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Ultra Boost', 'Adidas', '2022-04-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Converse Chuck Taylor', 'Converse', '2022-05-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Superstar', 'Adidas', '2022-06-01');

INSERT INTO sneaker_modelos (model, marca, data_lancamento) 
VALUES ('Air Force 1', 'Nike', '2022-07-01');


INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (1, 'Air Jordan 1 Retro', 110.00, 10, '7,8,9,10,11', 'jordan1.jpg');

INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (2, 'Yeezy Boost 350 V2', 250.00, 5, '8,9,10', 'yeezy350.jpg');

INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (3, 'Air Max 90 Essential', 90.00, 15, '7,8,9,10,11', 'airmax90.jpg');

INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (4, 'Ultra Boost Uncaged', 180.00, 8, '8,9,10,11', 'ultraboost.jpg');

INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (5, 'Converse Chuck Taylor All Star', 60.00, 20, '7,8,9,10,11', 'chucktaylor.jpg');

INSERT INTO sneakers (model_id, nome, preco, stock, tamanhos, img) 
VALUES (6, 'Adidas Superstar', 80.00, 12, '8,9,10,11', 'superstar.jpg');