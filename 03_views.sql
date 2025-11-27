-- View para análise performance
CREATE OR REPLACE VIEW pizzaria.vw_analise_performance AS
SELECT 
    pf.codigo,
    pf.nome as produto,
    pf.tamanho,
    pf.quantidade_em_estoque,
    COUNT(v.codigo) as total_vendas,
    SUM(v.quantidade_vendida) as quantidade_total_vendida,
    SUM(v.valor_total_venda) as receita_total,
    AVG(v.valor_unitario_venda) as preco_medio_venda,
    pf.valor_unitario_custo as custo_unitario,
    (AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) as margem_unitaria,
    ROUND(((AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) / pf.valor_unitario_custo * 100), 2) as margem_percentual,
    CASE 
        WHEN COUNT(v.codigo) = 0 THEN '🟡 SEM VENDAS'
        WHEN (AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) > 5 THEN '🟢 ALTA MARGEM'
        WHEN (AVG(v.valor_unitario_venda) - pf.valor_unitario_custo) > 2 THEN '🟡 MARGEM MÉDIA'
        ELSE '🔴 BAIXA MARGEM'
    END as status_margem
FROM pizzaria.produtofinal pf
LEFT JOIN pizzaria.venda v ON pf.codigo = v.produto_codigo
GROUP BY pf.codigo, pf.nome, pf.tamanho, pf.quantidade_em_estoque, pf.valor_unitario_custo;
