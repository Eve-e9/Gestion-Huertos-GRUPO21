USE gestion_huertos;

-- 5. Obtener reportes de producción agrícola por cultivo y periodo

-- Producción total por cultivo en un periodo (ej. de junio a septiembre de 2026)
SELECT
    cu.nombre                           AS cultivo,
    COUNT(c.id_cosecha)                 AS numero_cosechas,
    SUM(c.cantidad_cosechada)           AS total_cosechado
FROM cosecha c
INNER JOIN siembra s  ON c.id_siembra = s.id_siembra
INNER JOIN cultivo cu ON s.id_cultivo = cu.id_cultivo
WHERE c.fecha_cosecha BETWEEN '2026-06-01' AND '2026-09-30'
GROUP BY cu.id_cultivo, cu.nombre
ORDER BY total_cosechado DESC;

-- Producción de cada cultivo mes a mes
SELECT
    cu.nombre                             AS cultivo,
    DATE_FORMAT(c.fecha_cosecha, '%Y-%m') AS periodo,
    SUM(c.cantidad_cosechada)             AS total_cosechado
FROM cosecha c
INNER JOIN siembra s  ON c.id_siembra = s.id_siembra
INNER JOIN cultivo cu ON s.id_cultivo = cu.id_cultivo
GROUP BY cu.id_cultivo, cu.nombre, DATE_FORMAT(c.fecha_cosecha, '%Y-%m')
ORDER BY cu.nombre, periodo;
