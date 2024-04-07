/*Eliminamos la base de datos en caso de que exista*/
drop database alkewallet;
/*Creamos la base de datos y luego la seleccionamos para su uso*/
create database alkewallet;
use alkewallet;

/*Creamos las tablas solicitadas*/
CREATE TABLE Usuario (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(50) UNIQUE NOT NULL,
    contraseña VARCHAR(100) NOT NULL,
    saldo DECIMAL(18, 2) DEFAULT 0.00
);

CREATE TABLE Moneda (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(10) NOT NULL
);

CREATE TABLE Transaccion (
    transaction_id INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id INT NOT NULL,
    receiver_user_id INT NOT NULL,
    currency_id INT NOT NULL,
    importe DECIMAL(18, 2) NOT NULL,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (receiver_user_id) REFERENCES Usuario(user_id),
    FOREIGN KEY (currency_id) REFERENCES Moneda(currency_id)
);

/*Poblaremos las tabls para que contenga registros sobres los cuales podamos operar*/

/*TABLA USUARIO*/

INSERT INTO Usuario (nombre, correo_electronico, contraseña, saldo) VALUES
('Juan Pérez', 'juan_perez@gmail.com', 'contraseña123', 100.00),
('María López', 'maria_godzilla@yahoo.com', 'maria123', 50.00),
('Pedro Ramirez', 'pedro.r@outlook.com', 'pedro123', 75.00),
('Ana Martinez', 'anamar@gmail.com', 'ana123', 120.00),
('Carlos García', 'carlos555@englishalways.com', 'carlos123', 200.00),
('Laura Diaz', 'lauraday@gmail.com', 'laura123', 300.00),
('Roberto Sanchez', 'robertos@hotmail.com', 'roberto123', 150.00),
('Sofía Romero', 'sofia_gomero@gmail.com', 'sofia123', 80.00),
('Daniel Gómez', 'daniel.g@hotmail.com', 'daniel123', 250.00),
('Alejandra Torres', 'alejantra@protonmail.com', 'alejandra123', 175.00);

/*Tabla Moneda*/

INSERT INTO Moneda (currency_name, currency_symbol) VALUES
('Dólar estadounidense', 'USD'),
('Euro', 'EUR'),
('Libra esterlina', 'GBP'),
('Yen japonés', 'JPY'),
('Dólar canadiense', 'CAD'),
('Peso mexicano', 'MXN'),
('Franco suizo', 'CHF'),
('Dólar australiano', 'AUD'),
('Dólar neozelandés', 'NZD'),
('Corona sueca', 'SEK');

/*Tabla Transaccion*/

INSERT INTO Transaccion (sender_user_id, receiver_user_id, currency_id, importe) VALUES
(1, 2, 3, 500.00),   -- Transacción en Libra esterlina
(2, 1, 5, 1000.00),  -- Transacción en Peso mexicano
(3, 7, 6, 750.50),   -- Transacción en Franco suizo
(4, 3, 4, 1200.75),  -- Transacción en Yen japonés
(3, 2, 7, 800.00),   -- Transacción en Dólar australiano
(6, 4, 9, 1500.00),  -- Transacción en Dólar neozelandés
(7, 1, 8, 300.00),   -- Transacción en Corona sueca
(8, 3, 10, 950.25),  -- Transacción en Dólar canadiense
(9, 5, 2, 650.00),   -- Transacción en Euro
(10, 4, 1, 550.50);  -- Transacción en Dólar estadounidense

/*Aplicando consultas SQL solicitadas*/

/* Consulta para obtener el nombre de la moneda elegida por un usuario específico */
SELECT m.currency_name "Nombre moneda"
FROM Transaccion t
JOIN Moneda m USING (currency_id)
WHERE t.sender_user_id = 1
LIMIT 1;

/* Consulta para obtener las transacciones realizadas por un usuario específico */
SELECT *
FROM Transaccion
WHERE sender_user_id = 5;

/* Consulta para obtener todos los usuarios registrados */
SELECT *
FROM Usuario;

/* Consulta para obtener todas las monedas registradas */
SELECT *
FROM Moneda;

/* Consulta para obtener todas las transacciones registradas */
SELECT *
FROM Transaccion;

/* Consulta para obtener todas las transacciones realizadas por un usuario específico */
SELECT *
FROM Transaccion
WHERE sender_user_id = 3;

/* Consulta para obtener todas las transacciones recibidas por un usuario específico */
SELECT *
FROM Transaccion
WHERE receiver_user_id = 7;

/** Sentencia DML para modificar el campo correo electrónico de un usuario específico **/
UPDATE Usuario
SET correo_electronico = 'nuevo_correo@gmail.com'
WHERE user_id = 10;

/** Sentencia para eliminar los datos de una transacción (eliminado de la fila completa) **/
DELETE FROM Transaccion
WHERE transaction_id = 8;

/* Sentencia para DDL modificar el nombre de la columna correo_electronico por email */
ALTER TABLE Usuario
CHANGE correo_electronico email VARCHAR(50) NOT NULL;







