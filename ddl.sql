CREATE DATABASE IF NOT EXISTS `ecommerce_zapatos`;
USE `ecommerce_zapatos`;


CREATE TABLE `Usuarios` (
  `usuario_id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) DEFAULT NULL,
  `apellido` varchar(50) DEFAULT NULL,
  `correo` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`usuario_id`)
);
CREATE TABLE `Pedidos` (
  `pedido_id` int NOT NULL AUTO_INCREMENT,
  `usuario_id` int DEFAULT NULL,
  `fecha_pedido` date DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`pedido_id`),
  KEY `usuario_id` (`usuario_id`),
  CONSTRAINT `Pedidos_ibfk_1` FOREIGN KEY (`usuario_id`) REFERENCES `Usuarios` (`usuario_id`)
);



CREATE TABLE `Productos`(
    `producto_id` INT AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `precio_unitario` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `precio_venta` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`producto_id`)
);

CREATE TABLE `PedidoProducto`(
    `id` INT NOT NULL AUTO_INCREMENT,
    `pedido_id` INT NOT NULL,
    `producto_id` INT NOT NULL,
    `cantidad` INT NOT NULL DEFAULT 1,
    PRIMARY KEY(`id`)
);

ALTER TABLE `PedidoProducto` ADD FOREIGN KEY(`pedido_id`) REFERENCES `Pedidos`(`pedido_id`);

ALTER TABLE `PedidoProducto` ADD CONSTRAINT `Productos_producto_id_fk` FOREIGN KEY(`producto_id`) REFERENCES `Productos`(`producto_id`);


CREATE TABLE `Productos`(
    `producto_id` INT AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `precio_unitario` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    `precio_venta` DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (`producto_id`)
);

CREATE TABLE `PedidoProductoCompuesta`(
    `pedido_id` INT NOT NULL,
    `producto_id` INT NOT NULL,
    `cantidad` INT NOT NULL DEFAULT 1,
    PRIMARY KEY(`pedido_id`, `producto_id`),
    FOREIGN KEY(`pedido_id`) REFERENCES `Pedidos`(`pedido_id`),
    FOREIGN KEY(`producto_id`) REFERENCES `Productos`(`producto_id`)
);

-- Procedures


DELIMITER $$

CREATE PROCEDURE hola_mundo(IN p_nombre VARCHAR(100))
BEGIN
SELECT CONCAT('Hola :', p_nombre) AS Saludo;
END$$

DELIMITER ;

--Llamado

CALL hola_mundo(...);

DELIMITER //

CREATE PROCEDURE calcular_empleado(IN p_ventas DECIMAL(10,2))
BEGIN
  IF p_ventas >= 100000 THEN 
    SELECT 'EL empleado cumplio con las ventas' as resultado;
  ELSEIF p_ventas >= 50000 THEN
    SELECT 'El empleado CASI cumplio con las ventas' as resultado;
  ELSE
    SELECT 'El empleado efe de foca con las ventas' as resultado;
  END IF;
END //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE mostrar_top_ventas(IN p_min DECIMAL(10,2), IN p_max DECIMAL(10,2))
BEGIN
  SELECT * FROM pedidos WHERE total BETWEEN p_min AND p_max;
END //

DELIMITER ;

CALL mostrar_top_ventas(40.00, 100.00);