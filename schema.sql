CREATE DATABASE pizzaria_db; 

CREATE SCHEMA if NOT EXISTS pizzaria; 
SET search_path to pizzaria; 

CREATE TABLE pizzaria.fornecedor (
    codigo SERIAL PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    cnpj CHAR(14) UNIQUE NOT NULL,
    nome_fantasia VARCHAR(100),
    telefone VARCHAR(20),
    endereco VARCHAR(150),
    dados_bancarios VARCHAR(255)
);

CREATE TABLE pizzaria.cliente (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%.%'),
    endereco VARCHAR(150)
);

CREATE TABLE pizzaria.funcionario (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) UNIQUE NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(100) CHECK (email LIKE '%@%.%'),
    endereco VARCHAR(150),
    dados_bancarios VARCHAR(255),
    setor VARCHAR(50),
    cargo VARCHAR(50)
);

CREATE TABLE pizzaria.insumo (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    quantidade_em_estoque INT CHECK (quantidade_em_estoque >= 0) DEFAULT 0,
    valor_unitario DECIMAL(10,2) CHECK (valor_unitario > 0),
    data_entrada_nf DATE CHECK (data_entrada_nf <= CURRENT_DATE),
    data_vencimento DATE,
    fornecedor_codigo INT REFERENCES pizzaria.fornecedor(codigo)
);

CREATE TABLE pizzaria.produtofinal (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    tamanho VARCHAR(30),
    quantidade_em_estoque INT CHECK (quantidade_em_estoque >= 0) DEFAULT 0,
    valor_unitario_custo DECIMAL(10,2) CHECK (valor_unitario_custo > 0)
);

CREATE TABLE pizzaria.composicaoproduto (
    produto_fk INT REFERENCES pizzaria.produtofinal(codigo),
    insumo_fk INT REFERENCES pizzaria.insumo(codigo),
    quantidade_necessaria INT CHECK (quantidade_necessaria > 0),
    PRIMARY KEY (produto_fk, insumo_fk)
);

CREATE TABLE pizzaria.venda (
    codigo SERIAL PRIMARY KEY,
    data_venda DATE NOT NULL,
    valor_unitario_venda DECIMAL(10,2) CHECK (valor_unitario_venda > 0),
    forma_pagamento VARCHAR(30),
    quantidade_vendida INT CHECK (quantidade_vendida > 0),
    tamanho_produto VARCHAR(30),
    valor_total_venda DECIMAL(10,2),
    produto_codigo INT REFERENCES pizzaria.produtofinal(codigo),
    cliente_codigo INT REFERENCES pizzaria.cliente(codigo),
    funcionario_codigo INT REFERENCES pizzaria.funcionario(codigo)
);

CREATE TABLE pizzaria.entrega (
    numero_ordem_entrega SERIAL PRIMARY KEY,
    data_entrega DATE NOT NULL,
    valor_total_venda DECIMAL(10,2),
    forma_pagamento VARCHAR(30),
    quantidade_vendida INT,
    tamanho VARCHAR(30),
    venda_codigo INT REFERENCES pizzaria.venda(codigo)
);
