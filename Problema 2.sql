-- 2.

CREATE TABLE siembra (
    id_siembra INT AUTO_INCREMENT PRIMARY KEY,
    id_parcela INT NOT NULL,
    id_cultivo INT NOT NULL,
    fecha_siembra DATE NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_parcela) REFERENCES parcela(id_parcela),
    FOREIGN KEY (id_cultivo) REFERENCES cultivo(id_cultivo)
);

-- datos

INSERT INTO siembra (id_parcela, id_cultivo, fecha_siembra, cantidad)
VALUES
(1, 1, '2026-03-10', 50),
(1, 2, '2026-03-15', 30),
(2, 3, '2026-03-20', 100),
(2, 4, '2026-04-05', 25),
(3, 5, '2026-04-12', 80),
(3, 6, '2026-04-18', 40),
(4, 7, '2026-05-01', 60),
(4, 8, '2026-05-10', 35),
(5, 9, '2026-05-15', 120),
(5, 10, '2026-05-20', 45),
(6, 1, '2026-06-01', 75),
(6, 2, '2026-06-05', 55),
(7, 3, '2026-06-10', 90),
(7, 4, '2026-06-15', 40),
(8, 5, '2026-06-20', 65),
(8, 6, '2026-06-25', 30),
(9, 7, '2026-07-01', 100),
(9, 8, '2026-07-05', 50),
(10, 9, '2026-07-10', 85),
(10, 10, '2026-07-15', 45);

-- mostrar

SELECT * FROM siembra;
