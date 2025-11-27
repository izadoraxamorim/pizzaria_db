--Consulta para validar relacionamentos e integridade referencial
SELECT 'Fornecedores: ' || COUNT(*)::TEXT as info FROM pizzaria.fornecedor
UNION ALL
SELECT 'Clientes: ' || COUNT(*)::TEXT FROM pizzaria.cliente
UNION ALL
SELECT 'Funcionários: ' || COUNT(*)::TEXT FROM pizzaria.funcionario
UNION ALL
SELECT 'Insumos: ' || COUNT(*)::TEXT FROM pizzaria.insumo
UNION ALL
SELECT 'Produtos Finais: ' || COUNT(*)::TEXT FROM pizzaria.produtofinal
UNION ALL
SELECT 'Composições: ' || COUNT(*)::TEXT FROM pizzaria.composicaoproduto
UNION ALL
SELECT 'Vendas: ' || COUNT(*)::TEXT FROM pizzaria.venda
UNION ALL
SELECT 'Entregas: ' || COUNT(*)::TEXT FROM pizzaria.entrega;

-- Consulta para validar estoque de insumos
SELECT 
    i.nome as insumo,
    i.quantidade_em_estoque,
    i.valor_unitario,
    f.razao_social as fornecedor
FROM pizzaria.insumo i
JOIN pizzaria.fornecedor f ON i.fornecedor_codigo = f.codigo
ORDER BY i.quantidade_em_estoque DESC;

-- Consulta para validar composição dos produtos
SELECT 
    pf.nome as produto,
    pf.tamanho,
    i.nome as insumo,
    cp.quantidade_necessaria,
    pf.valor_unitario_custo as custo_produto
FROM pizzaria.produtofinal pf
JOIN pizzaria.composicaoproduto cp ON pf.codigo = cp.produto_fk
JOIN pizzaria.insumo i ON cp.insumo_fk = i.codigo
ORDER BY pf.nome, pf.tamanho;

-- Consulta para validar vendas e relacionamentos
SELECT 
    v.codigo as venda,
    v.data_venda,
    c.nome as cliente,
    f.nome as funcionario,
    pf.nome as produto,
    v.tamanho_produto,
    v.quantidade_vendida,
    v.valor_total_venda,
    v.forma_pagamento
FROM pizzaria.venda v
JOIN pizzaria.cliente c ON v.cliente_codigo = c.codigo
JOIN pizzaria.funcionario f ON v.funcionario_codigo = f.codigo
JOIN pizzaria.produtofinal pf ON v.produto_codigo = pf.codigo;

-- Consulta para validar entregas
SELECT 
    e.numero_ordem_entrega,
    e.data_entrega,
    v.codigo as venda_codigo,
    c.nome as cliente,
    pf.nome as produto,
    e.valor_total_venda
FROM pizzaria.entrega e
JOIN pizzaria.venda v ON e.venda_codigo = v.codigo
JOIN pizzaria.cliente c ON v.cliente_codigo = c.codigo
JOIN pizzaria.produtofinal pf ON v.produto_codigo = pf.codigo;

-- Consulta para validar margem de lucro dos produtos
SELECT 
    pf.nome as produto,
    pf.tamanho,
    pf.valor_unitario_custo as custo,
    AVG(v.valor_unitario_venda) as preco_venda_medio,
    (AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) as lucro_unitario,
    ROUND(((AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) / pf.valor_unitario_custo * 100), 2) as margem_percentual
FROM pizzaria.produtofinal pf
JOIN pizzaria.venda v ON pf.codigo = v.produto_codigo
GROUP BY pf.codigo, pf.nome, pf.tamanho, pf.valor_unitario_custo;

-- Consulta para validar restrições de integridade (estoque não negativo)
SELECT 
    'Insumos com estoque negativo: ' || COUNT(*)::TEXT as validacao
FROM pizzaria.insumo 
WHERE quantidade_em_estoque < 0
UNION ALL
SELECT 
    'Produtos com estoque negativo: ' || COUNT(*)::TEXT
FROM pizzaria.produtofinal 
WHERE quantidade_em_estoque < 0;

-- Consulta para validar formas de pagamento nas vendas
SELECT 
    forma_pagamento,
    COUNT(*) as quantidade_vendas,
    SUM(valor_total_venda) as total_arrecadado
FROM pizzaria.venda
GROUP BY forma_pagamento
ORDER BY total_arrecadado DESC;

-- Consulta para validar relacionamento fornecedor-insumo
SELECT 
    f.razao_social as fornecedor,
    COUNT(i.codigo) as quantidade_insumos_fornecidos,
    SUM(i.quantidade_em_estoque * i.valor_unitario) as valor_total_estoque
FROM pizzaria.fornecedor f
LEFT JOIN pizzaria.insumo i ON f.codigo = i.fornecedor_codigo
GROUP BY f.codigo, f.razao_social
ORDER BY valor_total_estoque DESC;
