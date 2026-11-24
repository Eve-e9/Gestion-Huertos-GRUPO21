CREATE TABLE siembra (
    id_siembra INT AUTO_INCREMENT PRIMARY KEY,
    id_parcela INT NOT NULL,
    id_cultivo INT NOT NULL,
    id_persona INT,
    fecha_siembra DATE NOT NULL,
    cantidad INT NOT NULL,
    unidad VARCHAR(15) NOT NULL DEFAULT 'semillas',
    fecha_estimada_cosecha DATE,
    estado VARCHAR(15) NOT NULL DEFAULT 'pendiente'
);

INSERT INTO siembra
(id_parcela, id_cultivo, id_persona, fecha_siembra, cantidad, unidad, fecha_estimada_cosecha, estado)
VALUES
(1, 1, 1, '2026-01-10', 500, 'semillas', '2026-04-10', 'pendiente'),
(2, 2, 2, '2026-01-15', 300, 'semillas', '2026-05-15', 'creciendo'),
(3, 3, 1, '2026-02-01', 200, 'plantas', '2026-06-01', 'creciendo'),
(4, 4, 3, '2026-02-10', 100, 'semillas', '2026-07-10', 'cosechado'),
(5, 5, 2, '2026-03-05', 400, 'semillas', '2026-08-05', 'pendiente');

SELECT * FROM siembra;
