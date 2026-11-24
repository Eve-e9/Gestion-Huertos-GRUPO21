USE gestion_huertos;

-- 4. Registrar las cosechas y consultar el historial por parcela
CREATE TABLE IF NOT EXISTS cosecha (
    id_cosecha INT AUTO_INCREMENT PRIMARY KEY,
    id_parcela INT NOT NULL,
    id_siembra INT NULL,
    fecha_cosecha DATE NOT NULL,
    cantidad_cosechada DECIMAL(10,2) NOT NULL,
    observaciones VARCHAR(255) NULL,
    FOREIGN KEY (id_parcela) REFERENCES parcela(id_parcela),
    FOREIGN KEY (id_siembra) REFERENCES siembra(id_siembra)
);

-- Registrar cosechas de ejemplo (alineadas con id_parcela e id_siembra del Problema 2)
INSERT INTO cosecha (id_parcela, id_siembra, fecha_cosecha, cantidad_cosechada, observaciones)
VALUES
(1, 1, '2026-06-15', 45.00, 'Cosecha de prueba en parcela 1'),
(1, 2, '2026-07-01', 28.50, 'Segunda cosecha registrada en parcela 1'),
(2, 3, '2026-07-10', 92.00, 'Cosecha en parcela 2');

-- Consultar el historial de cosechas de una parcela específica (ej. parcela 1)
SELECT
    c.id_cosecha,
    p.nombre AS parcela,
    cu.nombre AS cultivo,
    s.fecha_siembra,
    c.fecha_cosecha,
    s.cantidad AS cantidad_sembrada,
    c.cantidad_cosechada,
    c.observaciones
FROM cosecha c
INNER JOIN parcela p ON c.id_parcela = p.id_parcela
LEFT JOIN siembra s ON c.id_siembra = s.id_siembra
LEFT JOIN cultivo cu ON s.id_cultivo = cu.id_cultivo
WHERE c.id_parcela = 1
ORDER BY c.fecha_cosecha DESC, c.id_cosecha DESC;