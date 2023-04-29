/* 	
Curso: Taller
Catedrático: Jorge Luis Pérez Canto

	Nombre alumno: Josue Ambrosio
	Carné:	2021105
	Código técnico: IN5BM
	Grupo:1
	Fecha: 16/02/2022
*/
DROP DATABASE IF EXISTS funciones_andy_ambrosio;
CREATE DATABASE funciones_andy_ambrosio;

USE funciones_andy_ambrosio;

CREATE TABLE resultados (
	id INT AUTO_INCREMENT NOT NULL,
    area DECIMAL(10,2),
    impares VARCHAR(45),
    menor INT,
    PRIMARY KEY pk_funciones_Id (id)
);



-- 1. Crear un procedimiento almacenado para insertar registros en la tabla Resultados
DELIMITER $$
DROP PROCEDURE IF EXISTS ps_agregar $$
CREATE PROCEDURE ps_agregar(
	IN _area DECIMAL(10,2),
	IN _impares VARCHAR (255),
	IN _menor INT
) 
BEGIN
	INSERT INTO resultados (area,impares,menor)
    VALUES (_area,_impares,_menor);
END $$
DELIMITER ;
CALL ps_agregar(45.00," hola",2);

-- 2. Crear una función para calcular el área de un triangulo.
DELIMITER $$
DROP FUNCTION IF EXISTS fc_triangulo $$
CREATE FUNCTION fc_triangulo(
	_base DECIMAL(10,2),
	_altura DECIMAL(10,2))
RETURNS DECIMAL(10,2)
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE result DECIMAL(10,2);
   SET  result=(_base*_altura)/2;
	
	RETURN result;
END $$
DELIMITER ;
SELECT fc_triangulo(12,45);
-- 3. Crear una función que acumule en una variable todos los números impares del 1 al N.
DELIMITER $$
DROP FUNCTION IF EXISTS fc_impares $$
CREATE FUNCTION fc_impares(
	_final INT)
RETURNS VARCHAR (255)
READS SQL DATA DETERMINISTIC
BEGIN 
	DECLARE result VARCHAR (255) DEFAULT "";
    DECLARE i INT ;
    DECLARE almacen INT;
    SET i=0;
    WHILE i<=_final DO
		SET i=i+1;
    IF i%2=0 THEN
		SET almacen=i;	
		SET result=CONCAT(result," | ",almacen-1);
    END IF;
    END WHILE;
    
    RETURN result;
END $$
DELIMITER ;
SELECT fc_impares(16);
-- 4. Crear una función para calcular el número menor de 4 números enteros y mostrear el menor.
DELIMITER $$
DROP FUNCTION IF EXISTS fn_four $$
CREATE FUNCTION fn_four(
V1 INT,
V2 INT,
V3 INT,
V4 INT
)
RETURNS INT
READS SQL DATA DETERMINISTIC
BEGIN
	DECLARE result VARCHAR(255) DEFAULT " ";
    DECLARE minimo INT;
    IF V1<V2 AND V1<V3 AND V1<V4 THEN
		SET minimo=V1;
    ELSEIF V2<V1 AND V2<V3 AND V3<V4 THEN
		SET minimo=V2;
	ELSEIF V3<V1 AND V3<V2 AND V3<V4 THEN
		SET minimo=V3;
	ELSEIF V4<V1 AND V4<V2 AND V4<V3 THEN
		SET minimo=V4;
    END IF;
		
    RETURN minimo;
END $$
DELIMITER ;
SELECT fn_four(1,23,34,2);

-- 5. Llamar al procedimiento almacenado creado anteriormente para insertar el resultado de las funciones en la tabla Resultados
CALL ps_agregar(fc_triangulo(12,45),fc_impares(16),fn_four(1,23,34,2));

-- 6. Crear un procedimiento almacenado para listar todos los registros de la tabla resultado
DELIMITER $$
DROP PROCEDURE IF EXISTS ps_mostrar $$
CREATE PROCEDURE ps_mostrar( 
IN _id INT
)
BEGIN
SELECT r.area,r.impares, r.menor from resultados AS r
WHERE id=_id;
END $$
DELIMITER ;
CALL ps_mostrar(2);

