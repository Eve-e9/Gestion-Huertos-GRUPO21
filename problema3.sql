-- 3: Controlar el estado de los cultivos (sembrado, en crecimiento o cosechado)

-- Cuántos cultivos hay en cada estado
SELECT estado, COUNT(*) AS total 
FROM siembra 
GROUP BY estado;

-- Cultivos que siguen activos
SELECT * 
FROM v_estado_cultivos 
WHERE estado <> 'cosechado';

-- Cambiar el estado de una siembra 
UPDATE siembra 
SET estado = 'en_crecimiento' 
WHERE id_siembra = 11;

-- Ver el historial de cambios de esa siembra
SELECT * 
FROM historial_estado_siembra 
WHERE id_siembra = 11 
ORDER BY fecha_cambio;
