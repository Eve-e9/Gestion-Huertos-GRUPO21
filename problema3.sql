-- =====================================================================
-- PROBLEMA 3: Controlar el estado de los cultivos
--             (sembrado, en crecimiento o cosechado)
-- Compatible con XAMPP (MariaDB 10.4+) / MySQL 8.0.16+
--
-- Requiere las tablas del Problema 1 y 2: siembra, cosecha, parcela,
-- huerto y cultivo. Si en tu esquema los nombres son distintos,
-- ajusta los nombres de tablas/columnas de este archivo.
-- =====================================================================

-- ---------------------------------------------------------------------
-- 1. Campo "estado" restringido a los tres valores permitidos
--    (si la tabla siembra ya trae la columna estado, omite el ADD COLUMN)
-- ---------------------------------------------------------------------
ALTER TABLE siembra
    ADD COLUMN estado VARCHAR(15) NOT NULL DEFAULT 'sembrado';

ALTER TABLE siembra
    ADD CONSTRAINT ck_siembra_estado
    CHECK (estado IN ('sembrado','en_crecimiento','cosechado'));

-- ---------------------------------------------------------------------
-- 2. Historial de cambios de estado
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS historial_estado_siembra (
    id_historial     INT AUTO_INCREMENT PRIMARY KEY,
    id_siembra       INT NOT NULL,
    estado_anterior  VARCHAR(15),
    estado_nuevo     VARCHAR(15) NOT NULL,
    fecha_cambio     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_hist_siembra FOREIGN KEY (id_siembra)
        REFERENCES siembra(id_siembra) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- 3. Triggers
-- ---------------------------------------------------------------------
DELIMITER $$

-- Registra el estado inicial al crear una siembra
CREATE TRIGGER trg_siembra_ai
AFTER INSERT ON siembra
FOR EACH ROW
BEGIN
    INSERT INTO historial_estado_siembra (id_siembra, estado_anterior, estado_nuevo)
    VALUES (NEW.id_siembra, NULL, NEW.estado);
END$$

-- Registra cada cambio de estado
CREATE TRIGGER trg_siembra_au
AFTER UPDATE ON siembra
FOR EACH ROW
BEGIN
    IF NEW.estado <> OLD.estado THEN
        INSERT INTO historial_estado_siembra (id_siembra, estado_anterior, estado_nuevo)
        VALUES (NEW.id_siembra, OLD.estado, NEW.estado);
    END IF;
END$$

-- Al registrar una cosecha final, la siembra pasa a 'cosechado'
-- (requiere la columna es_final en la tabla cosecha)
CREATE TRIGGER trg_cosecha_ai
AFTER INSERT ON cosecha
FOR EACH ROW
BEGIN
    IF NEW.es_final THEN
        UPDATE siembra SET estado = 'cosechado' WHERE id_siembra = NEW.id_siembra;
    END IF;
END$$

DELIMITER ;

-- ---------------------------------------------------------------------
-- 4. Vista con el estado actual de todos los cultivos
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_estado_cultivos AS
SELECT h.nombre AS huerto, p.codigo AS parcela, c.nombre AS cultivo,
       s.fecha_siembra, s.cantidad, s.estado
FROM siembra s
JOIN parcela p ON p.id_parcela = s.id_parcela
JOIN huerto  h ON h.id_huerto  = p.id_huerto
JOIN cultivo c ON c.id_cultivo = s.id_cultivo;

-- ---------------------------------------------------------------------
-- 5. Consultas de demostración
-- ---------------------------------------------------------------------

-- Cuántos cultivos hay en cada estado
SELECT estado, COUNT(*) AS total FROM siembra GROUP BY estado;

-- Cultivos que siguen activos
SELECT * FROM v_estado_cultivos WHERE estado <> 'cosechado';

-- Cambiar el estado de una siembra (ejemplo: siembra 11)
UPDATE siembra SET estado = 'en_crecimiento' WHERE id_siembra = 11;

-- Ver el historial de cambios de esa siembra
SELECT * FROM historial_estado_siembra WHERE id_siembra = 11 ORDER BY fecha_cambio;

-- Prueba de validación: debe dar error por estado no permitido
-- UPDATE siembra SET estado = 'podrido' WHERE id_siembra = 11;
