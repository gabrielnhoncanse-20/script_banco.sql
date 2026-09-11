-- 1. Ocorrências por Tipo de Pavimento (GROUP BY + COUNT)
SELECT 
    l.tipo_pavimento,
    COUNT(r.id_registro) AS total_ocorrencias
FROM locais l
LEFT JOIN vegetacao_registros r ON l.id_local = r.id_local
GROUP BY l.tipo_pavimento
ORDER BY total_ocorrencias DESC;

-- 2. Altura Média em Locais de Difícil Acesso (JOIN + WHERE + AVG)
SELECT 
    ROUND(AVG(r.altura_cm), 2) AS altura_media_cm
FROM vegetacao_registros r
JOIN locais l ON r.id_local = l.id_local
WHERE l.dificuldade_acesso = 'Difícil';

-- 3. Custo por Tipo de Inclinação (JOIN + GROUP BY + SUM + ORDER BY)
SELECT 
    l.inclinacao,
    SUM(r.custo_poda) AS custo_total_poda
FROM locais l
JOIN vegetacao_registros r ON l.id_local = r.id_local
GROUP BY l.inclinacao
ORDER BY custo_total_poda DESC;

-- 4. Setores Extensos com Vegetação Crítica (JOIN + WHERE + ORDER BY + LIMIT)
SELECT 
    l.nome_terminal,
    l.setor,
    l.area_m2,
    r.altura_cm,
    r.tipo_vegetacao
FROM locais l
JOIN vegetacao_registros r ON l.id_local = r.id_local
WHERE r.altura_cm > 50
ORDER BY l.area_m2 DESC
LIMIT 5;

-- 5. Altura Mínima e Máxima por Setor (GROUP BY + MIN + MAX)
SELECT 
    l.setor,
    MIN(r.altura_cm) AS altura_minima_cm,
    MAX(r.altura_cm) AS altura_maxima_cm
FROM locais l
JOIN vegetacao_registros r ON l.id_local = r.id_local
GROUP BY l.setor
ORDER BY l.setor;