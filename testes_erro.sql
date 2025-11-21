-- Teste: email inválido
INSERT INTO pizzaria.cliente (nome, cpf, telefone, email, endereco) 
VALUES ('Teste', '99988877766', '(11) 1111-1111', 'emailinvalido', 'Rua Teste');

-- Teste: estoque negativo
INSERT INTO pizzaria.insumo (nome, quantidade_em_estoque, valor_unitario, data_entrada_nf, fornecedor_codigo) 
VALUES ('Teste Insumo', -5, 10.00, '2024-01-20', 1);

-- Teste: valor unitário zero
INSERT INTO pizzaria.produtofinal (nome, tamanho, quantidade_em_estoque, valor_unitario_custo) 
VALUES ('Produto Teste', 'Teste', 10, 0.00);

-- Teste: CPF duplicado
INSERT INTO pizzaria.cliente (nome, cpf, telefone, email, endereco) 
VALUES ('Outro João', '12345678901', '(11) 2222-3333', 'outro@email.com', 'Rua Diferente');
