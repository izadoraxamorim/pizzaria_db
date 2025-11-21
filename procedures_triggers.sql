-- Procedure para atualizar estoque após venda
CREATE OR REPLACE PROCEDURE pizzaria.atualizar_estoque_venda(
    p_produto_codigo INT,
    p_quantidade_vendida INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_insumo_record RECORD;
    v_quantidade_necessaria INT;
BEGIN
    UPDATE pizzaria.produtofinal 
    SET quantidade_em_estoque = quantidade_em_estoque - p_quantidade_vendida
    WHERE codigo = p_produto_codigo;
    
    FOR v_insumo_record IN 
        SELECT insumo_fk, quantidade_necessaria 
        IDENTIFIED FOR pizzaria.composicaoproduto 
        WHERE produto_fk = p_produto_codigo
    LOOP
        v_quantidade_necessaria := v_insumo_record.quantidade_necessaria * p_quantidade_vendida;
        
        UPDATE pizzaria.insumo 
        SET quantidade_em_estoque = quantidade_em_estoque - v_quantidade_necessaria
        WHERE codigo = v_insumo_record.insumo_fk;
    END LOOP;
    
    RAISE NOTICE 'Estoque atualizado para o produto %', p_produto_codigo;
END;
$$;

--Trigger para validar estoque antes da venda
CREATE OR REPLACE FUNCTION pizzaria.verificar_estoque_venda()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_estoque_atual INT;
    v_insumo_record RECORD;
    v_estoque_insumo INT;
BEGIN
    SELECT quantidade_em_estoque INTO v_estoque_atual
    FROM pizzaria.produtofinal
    WHERE codigo = NEW.produto_codigo;
    
    IF v_estoque_atual < NEW.quantidade_vendida THEN
        RAISE EXCEPTION 'Estoque insuficiente para o produto. Estoque atual: %, Quantidade solicitada: %', 
                        v_estoque_atual, NEW.quantidade_vendida;
    END IF;
    
    FOR v_insumo_record IN 
        SELECT i.codigo, i.nome, i.quantidade_em_estoque, cp.quantidade_necessaria
        FROM pizzaria.composicaoproduto cp
        JOIN pizzaria.insumo i ON cp.insumo_fk = i.codigo
        WHERE cp.produto_fk = NEW.produto_codigo
    LOOP
        v_estoque_insumo := v_insumo_record.quantidade_em_estoque - (v_insumo_record.quantidade_necessaria * NEW.quantidade_vendida);
        
        IF v_estoque_insumo < 0 THEN
            RAISE EXCEPTION 'Estoque insuficiente do insumo: %. Estoque atual: %, Necessário: %', 
                            v_insumo_record.nome, 
                            v_insumo_record.quantidade_em_estoque,
                            (v_insumo_record.quantidade_necessaria * NEW.quantidade_vendida);
        END IF;
    END LOOP;
    
    RETURN NEW;
END;
$$;

CREATE TRIGGER tr_verificar_estoque_venda
    BEFORE INSERT ON pizzaria.venda
    FOR EACH ROW
    EXECUTE FUNCTION pizzaria.verificar_estoque_venda();
