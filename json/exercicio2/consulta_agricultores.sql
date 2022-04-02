SELECT json_build_object(
    'Agricultores', (SELECT json_agg(row_to_json(Agricultor)) from Agricultor),
    'Produtos', (SELECT json_agg(row_to_json(Produto)) from Produto),
    'Restaurantes', (SELECT json_agg(row_to_json(Restaurante)) from Restaurante),
    'Entregas', (select json_agg(row_to_json(eu))
        from (
        select CodA, (
            select row_to_json(Agricultor) from Agricultor where Entrega.CodA = Agricultor.CodA
        ) Agricultor, (
            select row_to_json(Restaurante) from Restaurante where Entrega.CodR = Restaurante.CodR
        ) Restaurante, (
            select row_to_json(Produto) from Produto where Entrega.CodP = Produto.CodP
        ) Produto
        from Entrega
        ) eu)
);
