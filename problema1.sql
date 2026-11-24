--Creacion de la base de datos Sistema de Gestion de Huertos Urbanos
CREATE DATABASE gestion_huertos;
USE gestion_huertos;

--1. Registrar huertos, parcelas y tipos de cultivos
--registro HUERTOS
CREATE TABLE huerto (
    id_huerto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(150) NOT NULL,
    superficie_total DECIMAL(10,2) NOT NULL
);

--regustro PARCELAS
CREATE TABLE parcela (
    id_parcela INT AUTO_INCREMENT PRIMARY KEY,
    id_huerto INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    superficie DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_huerto) REFERENCES huerto(id_huerto)
);

--registro CULTIVOS
CREATE TABLE cultivo (
    id_cultivo INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    temporada VARCHAR(50)
);