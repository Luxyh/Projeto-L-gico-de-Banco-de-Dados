-- criação do banco de dados para o cenario de E-commerce

-- ============================================
-- CRIAÇÃO DO BANCO DE DADOS
-- ============================================
CREATE DATABASE Ecommerce_DB;
USE Ecommerce_DB;

-- ============================================
-- TABELAS PRINCIPAIS
-- ============================================

-- CLIENTE (superclasse)
CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(45) NOT NULL,
    NomeMeio VARCHAR(45),
    Sobrenome VARCHAR(20),
    CPF CHAR(11) UNIQUE NOT NULL,
    Endereco VARCHAR(45),
    DataNascimento DATE NOT NULL
);

-- CLIENTE PESSOA FÍSICA
CREATE TABLE Cliente_PF (
    idCliente_PF INT PRIMARY KEY,
    CPF CHAR(11) UNIQUE NOT NULL,
    Nome VARCHAR(45) NOT NULL,
    FOREIGN KEY (idCliente_PF) REFERENCES Cliente(idCliente)
);

-- CLIENTE PESSOA JURÍDICA
CREATE TABLE Cliente_PJ (
    idCliente_PJ INT PRIMARY KEY,
    CNPJ VARCHAR(45) UNIQUE NOT NULL,
    RazaoSocial VARCHAR(45) UNIQUE NOT NULL,
    FOREIGN KEY (idCliente_PJ) REFERENCES Cliente(idCliente)
);

-- FORNECEDOR
CREATE TABLE Fornecedor (
    idFornecedor INT PRIMARY KEY AUTO_INCREMENT,
    RazaoSocial VARCHAR(45) UNIQUE NOT NULL,
    CNPJ VARCHAR(45) NOT NULL
);

-- TERCEIRO VENDEDOR
CREATE TABLE Terceiro_Vendedor (
    idTerceiro_Vendedor INT PRIMARY KEY,
    RazaoSocial VARCHAR(45) UNIQUE NOT NULL,
    Local VARCHAR(45)
);

-- PRODUTO
CREATE TABLE Produto (
    idProduto INT PRIMARY KEY AUTO_INCREMENT,
    Categoria VARCHAR(45),
    Descricao VARCHAR(45),
    Valor DECIMAL(10,2),
    Status ENUM('Disponivel', 'Sem estoque')
);

-- RELAÇÃO FORNECEDOR - PRODUTO
CREATE TABLE Disponibilizando_Produto (
    Fornecedor_idFornecedor INT,
    Produto_idProduto INT,
    PRIMARY KEY (Fornecedor_idFornecedor, Produto_idProduto),
    FOREIGN KEY (Fornecedor_idFornecedor) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- RELAÇÃO TERCEIRO VENDEDOR - PRODUTO
CREATE TABLE Produto_por_Vendedor (
    Terceiro_Vendedor_idTerceiro_Vendedor INT,
    Produto_idProduto INT,
    Quantidade INT,
    PRIMARY KEY (Terceiro_Vendedor_idTerceiro_Vendedor, Produto_idProduto),
    FOREIGN KEY (Terceiro_Vendedor_idTerceiro_Vendedor) REFERENCES Terceiro_Vendedor(idTerceiro_Vendedor),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto)
);

-- ESTOQUE
CREATE TABLE Estoque (
    idEstoque INT PRIMARY KEY AUTO_INCREMENT,
    Local VARCHAR(45)
);

-- PRODUTO HAS ESTOQUE
CREATE TABLE Produto_has_Estoque (
    Produto_idProduto INT,
    Estoque_idEstoque INT,
    Quantidade INT,
    PRIMARY KEY (Produto_idProduto, Estoque_idEstoque),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Estoque_idEstoque) REFERENCES Estoque(idEstoque)
);

-- PEDIDO
CREATE TABLE Pedido (
    idPedido INT PRIMARY KEY AUTO_INCREMENT,
    StatusPedido ENUM('Em andamento', 'Processando', 'Enviado', 'Entregue') NOT NULL,
    Descricao VARCHAR(45),
    Frete FLOAT,
    Cliente_idCliente INT NOT NULL,
    FOREIGN KEY (Cliente_idCliente) REFERENCES Cliente(idCliente)
);

-- RELAÇÃO PRODUTO - PEDIDO
CREATE TABLE Relacao_Produto_Pedido (
    Produto_idProduto INT,
    Pedido_idPedido INT,
    Quantidade INT,
    Status ENUM('Disponivel', 'Sem estoque'),
    PRIMARY KEY (Produto_idProduto, Pedido_idPedido),
    FOREIGN KEY (Produto_idProduto) REFERENCES Produto(idProduto),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- ENTREGA
CREATE TABLE Entrega (
    idEntrega INT PRIMARY KEY AUTO_INCREMENT,
    DataEnvio DATE,
    DataEntregaPrevista DATE,
    DataEntregaReal DATE,
    Status VARCHAR(45),
    Pedido_idPedido INT NOT NULL,
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- FORMA DE PAGAMENTO
CREATE TABLE Forma_Pagamento (
    idForma_Pagamento INT PRIMARY KEY AUTO_INCREMENT,
    Tipo VARCHAR(45)
);

-- PAGAMENTO
CREATE TABLE Pagamento (
    idPagamento INT PRIMARY KEY AUTO_INCREMENT,
    Valor DECIMAL(10,2),
    Data DATE,
    Status VARCHAR(45),
    Forma_Pagamento_idForma_Pagamento INT,
    Pedido_idPedido INT,
    FOREIGN KEY (Forma_Pagamento_idForma_Pagamento) REFERENCES Forma_Pagamento(idForma_Pagamento),
    FOREIGN KEY (Pedido_idPedido) REFERENCES Pedido(idPedido)
);

-- ============================================
-- DADOS DE EXEMPLO
-- ============================================

INSERT INTO Cliente (Nome, NomeMeio, Sobrenome, CPF, Endereco, DataNascimento)
VALUES ('Luiz', 'Henrique', 'Souza', '12345678901', 'Rua A, 100', '2000-05-10'),
       ('Ana', 'Beatriz', 'Oliveira', '98765432100', 'Rua B, 200', '1999-03-15');

INSERT INTO Fornecedor (RazaoSocial, CNPJ) VALUES
('Papelaria Global', '11222333444455'),
('TechMaster Ltda', '99887766554433');

INSERT INTO Terceiro_Vendedor (idTerceiro_Vendedor, RazaoSocial, Local) VALUES
(1, 'Loja Parceira A', 'Feira de Santana'),
(2, 'Vendas Express', 'Salvador');

INSERT INTO Produto (Categoria, Descricao, Valor, Status)
VALUES ('Eletrônico', 'Mouse Gamer RGB', 120.00, 'Disponivel'),
       ('Material Escolar', 'Caderno 200 folhas', 25.00, 'Disponivel'),
       ('Informática', 'Teclado Mecânico', 250.00, 'Sem estoque');

INSERT INTO Estoque (Local) VALUES ('Centro de Distribuição 1'), ('Depósito Salvador');

INSERT INTO Produto_has_Estoque VALUES (1,1,50), (2,1,200), (3,2,0);

INSERT INTO Pedido (StatusPedido, Descricao, Frete, Cliente_idCliente)
VALUES ('Em andamento', 'Compra online via site', 20.50, 1),
       ('Enviado', 'Pedido expresso', 15.00, 2);

INSERT INTO Relacao_Produto_Pedido VALUES (1,1,2,'Disponivel'), (2,1,1,'Disponivel'), (3,2,1,'Sem estoque');

INSERT INTO Forma_Pagamento (Tipo) VALUES ('Cartão de Crédito'), ('Pix');

INSERT INTO Pagamento (Valor, Data, Status, Forma_Pagamento_idForma_Pagamento, Pedido_idPedido)
VALUES (265.00, '2025-10-18', 'Aprovado', 1, 1),
       (250.00, '2025-10-17', 'Pendente', 2, 2);

INSERT INTO Entrega (DataEnvio, DataEntregaPrevista, DataEntregaReal, Status, Pedido_idPedido)
VALUES ('2025-10-15', '2025-10-20', NULL, 'Em trânsito', 1),
       ('2025-10-10', '2025-10-15', '2025-10-14', 'Entregue', 2);
       
-- Novo cliente
INSERT INTO Cliente (Nome, NomeMeio, Sobrenome, CPF, Endereco, DataNascimento)
VALUES ('Carlos', 'Eduardo', 'Menezes', '11122233344', 'Rua C, 300', '1995-09-20');

-- Dois pedidos para o mesmo cliente
INSERT INTO Pedido (StatusPedido, Descricao, Frete, Cliente_idCliente)
VALUES 
('Processando', 'Compra de periféricos', 25.00, 3),
('Entregue', 'Compra de papelaria', 10.00, 3);

-- Associar produtos existentes a vendedores terceiros
INSERT INTO Produto_por_Vendedor (Terceiro_Vendedor_idTerceiro_Vendedor, Produto_idProduto, Quantidade)
VALUES 
(1, 1, 30),   -- Loja Parceira A vende o Mouse Gamer
(2, 2, 50);   -- Vendas Express vende o Caderno



-- ============================================
-- CONSULTAS DO DESAFIO
-- ============================================

-- 1. Recuperação simples (SELECT)
SELECT Nome, Sobrenome, CPF FROM Cliente;

-- 2. Filtro com WHERE
SELECT * FROM Produto WHERE Status = 'Disponivel' AND Valor > 50;

-- 3. Atributo derivado (expressão)
SELECT Nome, YEAR(CURDATE()) - YEAR(DataNascimento) AS Idade FROM Cliente;

-- 4. Ordenação dos dados
SELECT Descricao, Valor FROM Produto ORDER BY Valor DESC;

-- 5. Agrupamento e HAVING (clientes com mais de 1 pedido)
SELECT c.Nome, COUNT(p.idPedido) AS TotalPedidos
FROM Cliente c
JOIN Pedido p ON c.idCliente = p.Cliente_idCliente
GROUP BY c.Nome
HAVING COUNT(p.idPedido) > 1;

-- 6. Junção entre várias tabelas (pedido + cliente + pagamento + entrega)
SELECT 
    c.Nome,
    p.idPedido,
    pg.Status AS StatusPagamento,
    e.Status AS StatusEntrega,
    SUM(r.Quantidade * pr.Valor) AS TotalPedido
FROM Pedido p
JOIN Cliente c ON p.Cliente_idCliente = c.idCliente
JOIN Pagamento pg ON pg.Pedido_idPedido = p.idPedido
JOIN Entrega e ON e.Pedido_idPedido = p.idPedido
JOIN Relacao_Produto_Pedido r ON r.Pedido_idPedido = p.idPedido
JOIN Produto pr ON pr.idProduto = r.Produto_idProduto
GROUP BY p.idPedido, c.Nome, pg.Status, e.Status;

-- 7. Consulta com cálculo e filtro derivado
SELECT 
    c.Nome, 
    SUM(pg.Valor) AS TotalGasto
FROM Cliente c
JOIN Pedido p ON p.Cliente_idCliente = c.idCliente
JOIN Pagamento pg ON pg.Pedido_idPedido = p.idPedido
GROUP BY c.Nome
HAVING SUM(pg.Valor) > 200;

-- 8. Produtos vendidos por terceiros
SELECT 
    tv.RazaoSocial AS Vendedor,
    pr.Descricao AS Produto,
    ppv.Quantidade
FROM Produto_por_Vendedor ppv
JOIN Terceiro_Vendedor tv ON tv.idTerceiro_Vendedor = ppv.Terceiro_Vendedor_idTerceiro_Vendedor
JOIN Produto pr ON pr.idProduto = ppv.Produto_idProduto;

