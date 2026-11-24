-- Tabla persona: responsables, hortelanos y voluntarios de los huertos

CREATE TABLE persona (
    id_persona  INT AUTO_INCREMENT PRIMARY KEY,
    nombre      VARCHAR(100) NOT NULL,
    telefono    VARCHAR(20),
    rol         VARCHAR(20) NOT NULL DEFAULT 'hortelano'
);

-- Datos 
INSERT INTO persona (nombre, telefono, rol) VALUES
 ('María Quispe',  '70111111', 'coordinador'),   
 ('Juan Mamani',   '70222222', 'coordinador'),  
 ('Rosa Condori',  '70333333', 'hortelano'),     
 ('Carlos Flores', '70444444', 'hortelano'),     
 ('Lucía Choque',  '70555555', 'voluntario');
