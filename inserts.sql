--acessar o banco
USE pizzaria_db;
SET search_path TO pizzaria;


INSERT INTO pizzaria.fornecedor (razao_social, cnpj, nome_fantasia, telefone, endereco, dados_bancarios) VALUES
('Distribuidora de Alimentos LTDA', '12345678000195', 'Distribuidora Alimentos', '(11) 3333-4444', 'Rua das Indústrias, 100 - São Paulo/SP', 'Banco XYZ - Ag 1234 - CC 56789'),
('Laticínios Premium SA', '98765432000187', 'Laticínios Premium', '(11) 2222-3333', 'Av. dos Laticínios, 500 - Campinas/SP', 'Banco ABC - Ag 5678 - CC 12345'),
('Hortifruti Natural ME', '45678912000134', 'Hortifruti Natural', '(11) 4444-5555', 'Rua das Hortaliças, 200 - São Paulo/SP', 'Banco DEF - Ag 9012 - CC 34567'),
('Bebidas Refrescantes LTDA', '78912345000123', 'Bebidas Refrescantes', '(11) 5555-6666', 'Av. das Bebidas, 300 - São Paulo/SP', 'Banco GHI - Ag 3456 - CC 78901');


INSERT INTO pizzaria.cliente (nome, cpf, telefone, email, endereco) VALUES
('João Silva', '12345678901', '(11) 9999-8888', 'joao.silva@email.com', 'Rua A, 123 - São Paulo/SP'),
('Maria Santos', '98765432109', '(11) 8888-7777', 'maria.santos@email.com', 'Av. B, 456 - São Paulo/SP'),
('Pedro Oliveira', '45678912345', '(11) 7777-6666', 'pedro.oliveira@email.com', 'Rua C, 789 - São Paulo/SP'),
('Ana Costa', '32165498732', '(11) 6666-5555', 'ana.costa@email.com', 'Av. D, 321 - São Paulo/SP'),
('Carlos Souza', '65498732165', '(11) 5555-4444', 'carlos.souza@email.com', 'Rua E, 654 - São Paulo/SP');


INSERT INTO pizzaria.funcionario (nome, cpf, telefone, email, endereco, dados_bancarios, setor, cargo) VALUES
('Roberto Alves', '11122233344', '(11) 3333-2222', 'roberto.alves@pizzaria.com', 'Rua F, 111 - São Paulo/SP', 'Banco JKL - Ag 7890 - CC 23456', 'Produção', 'Pizzaiolo'),
('Fernanda Lima', '22233344455', '(11) 4444-3333', 'fernanda.lima@pizzaria.com', 'Av. G, 222 - São Paulo/SP', 'Banco MNO - Ag 1234 - CC 45678', 'Atendimento', 'Atendente'),
('Ricardo Santos', '33344455566', '(11) 5555-4444', 'ricardo.santos@pizzaria.com', 'Rua H, 333 - São Paulo/SP', 'Banco PQR - Ag 5678 - CC 67890', 'Entrega', 'Entregador'),
('Juliana Pereira', '44455566677', '(11) 6666-5555', 'juliana.pereira@pizzaria.com', 'Av. I, 444 - São Paulo/SP', 'Banco STU - Ag 9012 - CC 89012', 'Administrativo', 'Gerente');


INSERT INTO pizzaria.insumo (nome, quantidade_em_estoque, valor_unitario, data_entrada_nf, data_vencimento, fornecedor_codigo) VALUES
('Farinha de Trigo', 100, 4.50, '2024-01-15', '2024-12-31', 1),
('Queijo Mussarela', 50, 28.90, '2024-01-10', '2024-02-10', 2),
('Molho de Tomate', 80, 6.80, '2024-01-12', '2024-12-31', 1),
('Pepperoni', 30, 35.00, '2024-01-08', '2024-03-08', 1),
('Azeitonas', 40, 12.50, '2024-01-05', '2024-12-31', 3),
('Orégano', 25, 8.90, '2024-01-03', '2025-01-03', 1),
('Refrigerante Coca-Cola 2L', 60, 9.50, '2024-01-14', '2024-12-31', 4),
('Refrigerante Guaraná 2L', 55, 8.90, '2024-01-14', '2024-12-31', 4);


INSERT INTO pizzaria.produtofinal (nome, tamanho, quantidade_em_estoque, valor_unitario_custo) VALUES
('Pizza Margherita', 'Grande', 20, 12.50),
('Pizza Margherita', 'Média', 25, 9.80),
('Pizza Pepperoni', 'Grande', 18, 15.80),
('Pizza Pepperoni', 'Média', 22, 12.50),
('Pizza Portuguesa', 'Grande', 15, 16.20),
('Refrigerante Coca-Cola', '2L', 60, 4.75),
('Refrigerante Guaraná', '2L', 55, 4.45);


INSERT INTO pizzaria.composicaoproduto (produto_fk, insumo_fk, quantidade_necessaria) VALUES
(1, 1, 2), 
(1, 2, 1),
(1, 3, 1),
(1, 6, 1), 

(2, 1, 1), 
(2, 2, 1),
(2, 3, 1), 
(2, 6, 1),

(3, 1, 2), 
(3, 2, 1), 
(3, 3, 1), 
(3, 4, 1), 
(3, 6, 1), 

(4, 1, 1),
(4, 2, 1), 
(4, 3, 1),
(4, 4, 1), 
(4, 6, 1), 

(5, 1, 2), 
(5, 2, 1),  
(5, 3, 1), 
(5, 5, 1), 
(5, 6, 1), 

(6, 7, 1),  
(7, 8, 1); 

INSERT INTO pizzaria.venda (data_venda, valor_unitario_venda, forma_pagamento, quantidade_vendida, tamanho_produto, valor_total_venda, produto_codigo, cliente_codigo, funcionario_codigo) VALUES
('2024-01-20', 35.00, 'Cartão de Crédito', 1, 'Grande', 35.00, 1, 1, 2),
('2024-01-20', 28.00, 'Dinheiro', 1, 'Média', 28.00, 2, 2, 2),
('2024-01-20', 42.00, 'Cartão de Débito', 1, 'Grande', 42.00, 3, 3, 2),
('2024-01-21', 45.00, 'PIX', 1, 'Grande', 45.00, 5, 4, 2),
('2024-01-21', 12.00, 'Dinheiro', 2, '2L', 24.00, 6, 5, 2);

INSERT INTO pizzaria.entrega (data_entrega, valor_total_venda, forma_pagamento, quantidade_vendida, tamanho, venda_codigo) VALUES
('2024-01-20', 35.00, 'Cartão de Crédito', 1, 'Grande', 1),
('2024-01-20', 42.00, 'Cartão de Débito', 1, 'Grande', 3),
('2024-01-21', 45.00, 'PIX', 1, 'Grande', 4);
