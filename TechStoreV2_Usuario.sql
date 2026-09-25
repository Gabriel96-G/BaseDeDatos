-- =====================================================

ALTER SESSION SET "_ORACLE_SCRIPT" = TRUE;

CREATE USER TECHSTOREV2 
IDENTIFIED BY TechStore123
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA UNLIMITED ON USERS;

GRANT CONNECT, RESOURCE TO TECHSTOREV2;

GRANT CREATE SESSION TO TECHSTOREV2;
GRANT CREATE TABLE TO TECHSTOREV2;
GRANT CREATE VIEW TO TECHSTOREV2;
GRANT CREATE SEQUENCE TO TECHSTOREV2;
GRANT CREATE PROCEDURE TO TECHSTOREV2;
GRANT CREATE TRIGGER TO TECHSTOREV2;


SELECT table_name
FROM user_tables
ORDER BY table_name;


---------------------------------

-- =====================================================
-- DATOS BASE PARA AVANCE 2 - TECHSTOREV2
-- Categorías, locales, productos, proveedores y clientes
-- =====================================================

-- CATEGORIAS
INSERT INTO CATEGORIA (ID_Categoria, Nombre_Categoria, Descripcion, Estado)
VALUES (1, 'Computadoras', 'Equipos de cómputo portátiles y de escritorio.', 'ACTIVA');

INSERT INTO CATEGORIA (ID_Categoria, Nombre_Categoria, Descripcion, Estado)
VALUES (2, 'Periféricos', 'Dispositivos complementarios para computadoras.', 'ACTIVA');

INSERT INTO CATEGORIA (ID_Categoria, Nombre_Categoria, Descripcion, Estado)
VALUES (3, 'Accesorios', 'Accesorios tecnológicos de uso general.', 'ACTIVA');


-- LOCALES
INSERT INTO LOCAL (ID_Local, Nombre_Local, Direccion, Estado)
VALUES (1, 'Local San José', 'Avenida Central, San José, Costa Rica', 'ACTIVO');

INSERT INTO LOCAL (ID_Local, Nombre_Local, Direccion, Estado)
VALUES (2, 'Local Heredia', 'Centro de Heredia, Costa Rica', 'ACTIVO');


-- PRODUCTOS
INSERT INTO PRODUCTO (ID_Producto, Nombre_Producto, Descripcion, Precio_Venta, Estado, CATEGORIA_ID_Categoria)
VALUES (1, 'Laptop Lenovo ThinkPad', 'Computadora portátil para uso empresarial.', 750000, 'ACTIVO', 1);

INSERT INTO PRODUCTO (ID_Producto, Nombre_Producto, Descripcion, Precio_Venta, Estado, CATEGORIA_ID_Categoria)
VALUES (2, 'Monitor Samsung 24 pulgadas', 'Monitor LED Full HD de 24 pulgadas.', 145000, 'ACTIVO', 2);

INSERT INTO PRODUCTO (ID_Producto, Nombre_Producto, Descripcion, Precio_Venta, Estado, CATEGORIA_ID_Categoria)
VALUES (3, 'Mouse Logitech Inalámbrico', 'Mouse inalámbrico ergonómico.', 18000, 'ACTIVO', 2);


-- PROVEEDORES
INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (1, 'Tecnología Global CR', '3101001001', 'San José, Costa Rica', '2222-1001', 'ventas@tecglobal.cr', 'Carlos Ramírez', 'ACTIVO');

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (2, 'Distribuidora Digital', '3101001002', 'Heredia, Costa Rica', '2222-1002', 'contacto@distdigital.cr', 'María Fernández', 'ACTIVO');

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (3, 'CompuPartes del Norte', '3101001003', 'Alajuela, Costa Rica', '2222-1003', 'info@compupartes.cr', 'Jorge Salas', 'ACTIVO');

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (4, 'Soluciones Tech CR', '3101001004', 'Cartago, Costa Rica', '2222-1004', 'ventas@solucionestech.cr', 'Ana Mora', 'ACTIVO');

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (5, 'Importadora PC Center', '3101001005', 'San Pedro, Costa Rica', '2222-1005', 'compras@pccenter.cr', 'Luis Hernández', 'ACTIVO');

INSERT INTO PROVEEDOR (ID_Proveedor, Nombre_Proveedor, Identificacion_Fiscal, Direccion, Telefono, Correo, Contacto_Principal, Estado)
VALUES (6, 'Accesorios y Tecnología S.A.', '3101001006', 'Escazú, Costa Rica', '2222-1006', 'servicio@accesoriostech.cr', 'Daniela Vargas', 'ACTIVO');


-- CLIENTES
INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Identificacion, Direccion, Telefono, Estado, Correo)
VALUES (1, 'Andrés', 'Gómez Rojas', '101010101', 'San José, Costa Rica', '8888-1001', 'ACTIVO', 'andres.gomez@email.com');

INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Identificacion, Direccion, Telefono, Estado, Correo)
VALUES (2, 'Laura', 'Méndez Soto', '202020202', 'Heredia, Costa Rica', '8888-1002', 'ACTIVO', 'laura.mendez@email.com');

INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Identificacion, Direccion, Telefono, Estado, Correo)
VALUES (3, 'Felipe', 'Castro Jiménez', '303030303', 'Alajuela, Costa Rica', '8888-1003', 'ACTIVO', 'felipe.castro@email.com');

INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Identificacion, Direccion, Telefono, Estado, Correo)
VALUES (4, 'Sofía', 'Ramírez Mora', '404040404', 'Cartago, Costa Rica', '8888-1004', 'ACTIVO', 'sofia.ramirez@email.com');

INSERT INTO CLIENTE (ID_Cliente, Nombre, Apellidos, Identificacion, Direccion, Telefono, Estado, Correo)
VALUES (5, 'Gabriel', 'Vargas Solís', '505050505', 'San José, Costa Rica', '8888-1005', 'ACTIVO', 'gabriel.vargas@email.com');

COMMIT;


-----------------------------------------------------------------------------
-------------------------------------------------------------------------------

SELECT 'CATEGORIA' AS TABLA, COUNT(*) AS TOTAL FROM CATEGORIA
UNION ALL
SELECT 'LOCAL', COUNT(*) FROM LOCAL
UNION ALL
SELECT 'PRODUCTO', COUNT(*) FROM PRODUCTO
UNION ALL
SELECT 'PROVEEDOR', COUNT(*) FROM PROVEEDOR
UNION ALL
SELECT 'CLIENTE', COUNT(*) FROM CLIENTE;


--------------------------------------------------------------------------
----------------------------------------------------------------------------

-- =====================================================
-- RELACION PRODUCTO - PROVEEDOR
-- INVENTARIO INICIAL POR LOCAL
-- =====================================================

-- PRODUCTO_PROVEEDOR
INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (1, 1, 'LEN-TP-001', 620000, 'ACTIVA');

INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (1, 2, 'LEN-TP-002', 625000, 'ACTIVA');

INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (2, 3, 'MON-SAM-001', 110000, 'ACTIVA');

INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (2, 4, 'MON-SAM-002', 112000, 'ACTIVA');

INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (3, 5, 'MOU-LOG-001', 12000, 'ACTIVA');

INSERT INTO PRODUCTO_PROVEEDOR 
(PRODUCTO_ID_Producto, PROVEEDOR_ID_Proveedor, Codigo_Producto_Proveedor, Costo_Referencia, Estado)
VALUES (3, 6, 'MOU-LOG-002', 12500, 'ACTIVA');


-- INVENTARIO_LOCAL
-- Inventario inicial en Local San José
INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (1, 1, 0, 3, 'ACTIVO');

INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (1, 2, 0, 5, 'ACTIVO');

INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (1, 3, 0, 10, 'ACTIVO');


-- Inventario inicial en Local Heredia
INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (2, 1, 0, 3, 'ACTIVO');

INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (2, 2, 0, 5, 'ACTIVO');

INSERT INTO INVENTARIO_LOCAL 
(LOCAL_ID_Local, PRODUCTO_ID_Producto, Stock_Actual, Stock_Minimo, Estado)
VALUES (2, 3, 0, 10, 'ACTIVO');

COMMIT;


-----------------------------------------------------------------------
-----------------------------------------------------------------------
SELECT 'PRODUCTO_PROVEEDOR' AS TABLA, COUNT(*) AS TOTAL FROM PRODUCTO_PROVEEDOR
UNION ALL
SELECT 'INVENTARIO_LOCAL', COUNT(*) FROM INVENTARIO_LOCAL;
-----------------------------------------------------------------------
-----------------------------------------------------------------------


-- =====================================================
-- SIMULACION DE COMPRAS
-- 3 productos, 2 locales, 6 proveedores
-- =====================================================

-- COMPRA 1: Laptop para Local San Jose - Proveedor 1
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(1, TO_TIMESTAMP('2026-07-09 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-001', 'PROCESADA', 1, 1);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(1, 1, 5, 620000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 5
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 1;


-- COMPRA 2: Laptop para Local Heredia - Proveedor 2
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(2, TO_TIMESTAMP('2026-07-09 09:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-002', 'PROCESADA', 2, 2);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(2, 1, 4, 625000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 4
WHERE LOCAL_ID_Local = 2
AND PRODUCTO_ID_Producto = 1;


-- COMPRA 3: Monitor para Local San Jose - Proveedor 3
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(3, TO_TIMESTAMP('2026-07-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-003', 'PROCESADA', 3, 1);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(3, 2, 10, 110000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 10
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 2;


-- COMPRA 4: Monitor para Local Heredia - Proveedor 4
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(4, TO_TIMESTAMP('2026-07-09 10:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-004', 'PROCESADA', 4, 2);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(4, 2, 8, 112000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 8
WHERE LOCAL_ID_Local = 2
AND PRODUCTO_ID_Producto = 2;


-- COMPRA 5: Mouse para Local San Jose - Proveedor 5
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(5, TO_TIMESTAMP('2026-07-09 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-005', 'PROCESADA', 5, 1);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(5, 3, 20, 12000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 20
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 3;


-- COMPRA 6: Mouse para Local Heredia - Proveedor 6
INSERT INTO COMPRA 
(ID_Compra, Fecha_Compra, Numero_Factura, Estado, PROVEEDOR_ID_Proveedor, LOCAL_ID_Local)
VALUES 
(6, TO_TIMESTAMP('2026-07-09 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'C-006', 'PROCESADA', 6, 2);

INSERT INTO DETALLE_COMPRA 
(COMPRA_ID_Compra, PRODUCTO_ID_Producto, Cantidad, Costo_Unitario)
VALUES 
(6, 3, 15, 12500);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual + 15
WHERE LOCAL_ID_Local = 2
AND PRODUCTO_ID_Producto = 3;

COMMIT;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

SELECT 'COMPRA' AS TABLA, COUNT(*) AS TOTAL FROM COMPRA
UNION ALL
SELECT 'DETALLE_COMPRA', COUNT(*) FROM DETALLE_COMPRA;

-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------

SELECT 
    l.Nombre_Local,
    p.Nombre_Producto,
    il.Stock_Actual,
    il.Stock_Minimo
FROM INVENTARIO_LOCAL il
JOIN LOCAL l
    ON il.LOCAL_ID_Local = l.ID_Local
JOIN PRODUCTO p
    ON il.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY l.Nombre_Local, p.Nombre_Producto;


-----------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------


-- =====================================================
-- SIMULACION DE VENTAS
-- 2 productos en existencia para 5 clientes
-- =====================================================

-- VENTA 1: Cliente 1 compra 1 Laptop en Local San Jose
INSERT INTO VENTA
(CLIENTE_ID_Cliente, ID_Venta, Fecha_Venta, Numero_Factura, Estado, LOCAL_ID_Local)
VALUES
(1, 1, TO_TIMESTAMP('2026-07-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'V-001', 'PROCESADA', 1);

INSERT INTO DETALLE_VENTA
(VENTA_ID_Venta, PRODUCTO_ID_Producto, Cantidad, Precio_Unitario)
VALUES
(1, 1, 1, 750000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual - 1
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 1;


-- VENTA 2: Cliente 2 compra 2 Monitores en Local San Jose
INSERT INTO VENTA
(CLIENTE_ID_Cliente, ID_Venta, Fecha_Venta, Numero_Factura, Estado, LOCAL_ID_Local)
VALUES
(2, 2, TO_TIMESTAMP('2026-07-09 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'V-002', 'PROCESADA', 1);

INSERT INTO DETALLE_VENTA
(VENTA_ID_Venta, PRODUCTO_ID_Producto, Cantidad, Precio_Unitario)
VALUES
(2, 2, 2, 145000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual - 2
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 2;


-- VENTA 3: Cliente 3 compra 1 Laptop en Local Heredia
INSERT INTO VENTA
(CLIENTE_ID_Cliente, ID_Venta, Fecha_Venta, Numero_Factura, Estado, LOCAL_ID_Local)
VALUES
(3, 3, TO_TIMESTAMP('2026-07-09 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'V-003', 'PROCESADA', 2);

INSERT INTO DETALLE_VENTA
(VENTA_ID_Venta, PRODUCTO_ID_Producto, Cantidad, Precio_Unitario)
VALUES
(3, 1, 1, 750000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual - 1
WHERE LOCAL_ID_Local = 2
AND PRODUCTO_ID_Producto = 1;


-- VENTA 4: Cliente 4 compra 3 Monitores en Local Heredia
INSERT INTO VENTA
(CLIENTE_ID_Cliente, ID_Venta, Fecha_Venta, Numero_Factura, Estado, LOCAL_ID_Local)
VALUES
(4, 4, TO_TIMESTAMP('2026-07-09 14:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'V-004', 'PROCESADA', 2);

INSERT INTO DETALLE_VENTA
(VENTA_ID_Venta, PRODUCTO_ID_Producto, Cantidad, Precio_Unitario)
VALUES
(4, 2, 3, 145000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual - 3
WHERE LOCAL_ID_Local = 2
AND PRODUCTO_ID_Producto = 2;


-- VENTA 5: Cliente 5 compra 1 Laptop en Local San Jose
INSERT INTO VENTA
(CLIENTE_ID_Cliente, ID_Venta, Fecha_Venta, Numero_Factura, Estado, LOCAL_ID_Local)
VALUES
(5, 5, TO_TIMESTAMP('2026-07-09 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'V-005', 'PROCESADA', 1);

INSERT INTO DETALLE_VENTA
(VENTA_ID_Venta, PRODUCTO_ID_Producto, Cantidad, Precio_Unitario)
VALUES
(5, 1, 1, 750000);

UPDATE INVENTARIO_LOCAL
SET Stock_Actual = Stock_Actual - 1
WHERE LOCAL_ID_Local = 1
AND PRODUCTO_ID_Producto = 1;

COMMIT;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------

SELECT 'VENTA' AS TABLA, COUNT(*) AS TOTAL FROM VENTA
UNION ALL
SELECT 'DETALLE_VENTA', COUNT(*) FROM DETALLE_VENTA;

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
SELECT 
    l.Nombre_Local,
    p.Nombre_Producto,
    il.Stock_Actual,
    il.Stock_Minimo
FROM INVENTARIO_LOCAL il
JOIN LOCAL l
    ON il.LOCAL_ID_Local = l.ID_Local
JOIN PRODUCTO p
    ON il.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY l.Nombre_Local, p.Nombre_Producto;


-- =====================================================
--Ejecutar dos queries para revisar el inventario:
-- i. Lista de Productos con cantidad de unidades existentes por Local
-- ii. Reporte de Compras por Proveedor y Productos
-- =====================================================

SELECT 
    l.Nombre_Local,
    p.Nombre_Producto,
    il.Stock_Actual,
    il.Stock_Minimo
FROM INVENTARIO_LOCAL il
JOIN LOCAL l
    ON il.LOCAL_ID_Local = l.ID_Local
JOIN PRODUCTO p
    ON il.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY l.Nombre_Local, p.Nombre_Producto;

-- =====================================================
-- Ejecutar dos queries para revisar el inventario:
-- ii. Reporte de Compras por Proveedor y Productos
-- =====================================================

SELECT
    pr.Nombre_Proveedor,
    l.Nombre_Local,
    c.Numero_Factura,
    TO_CHAR(c.Fecha_Compra, 'DD/MM/YYYY HH24:MI:SS') AS Fecha_Compra,
    p.Nombre_Producto,
    dc.Cantidad,
    dc.Costo_Unitario,
    dc.Cantidad * dc.Costo_Unitario AS Total_Linea
FROM COMPRA c
JOIN PROVEEDOR pr
    ON c.PROVEEDOR_ID_Proveedor = pr.ID_Proveedor
JOIN LOCAL l
    ON c.LOCAL_ID_Local = l.ID_Local
JOIN DETALLE_COMPRA dc
    ON c.ID_Compra = dc.COMPRA_ID_Compra
JOIN PRODUCTO p
    ON dc.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY pr.Nombre_Proveedor, c.Fecha_Compra, p.Nombre_Producto;

-- =====================================================
-- Verificación final de datos. Esto sirve como evidencia de que todas las tablas tienen información.
-- =====================================================
SELECT 'CATEGORIA' AS TABLA, COUNT(*) AS TOTAL FROM CATEGORIA
UNION ALL
SELECT 'LOCAL', COUNT(*) FROM LOCAL
UNION ALL
SELECT 'PRODUCTO', COUNT(*) FROM PRODUCTO
UNION ALL
SELECT 'PROVEEDOR', COUNT(*) FROM PROVEEDOR
UNION ALL
SELECT 'CLIENTE', COUNT(*) FROM CLIENTE
UNION ALL
SELECT 'PRODUCTO_PROVEEDOR', COUNT(*) FROM PRODUCTO_PROVEEDOR
UNION ALL
SELECT 'INVENTARIO_LOCAL', COUNT(*) FROM INVENTARIO_LOCAL
UNION ALL
SELECT 'COMPRA', COUNT(*) FROM COMPRA
UNION ALL
SELECT 'DETALLE_COMPRA', COUNT(*) FROM DETALLE_COMPRA
UNION ALL
SELECT 'VENTA', COUNT(*) FROM VENTA
UNION ALL
SELECT 'DETALLE_VENTA', COUNT(*) FROM DETALLE_VENTA;

-- =====================================================
-- e. Ejecutar dos queries para revisar el inventario:
-- i. Lista de Productos con cantidad de unidades existentes por Local
-- =====================================================

SELECT 
    l.Nombre_Local,
    p.Nombre_Producto,
    il.Stock_Actual AS Unidades_Existentes,
    il.Stock_Minimo,
    il.Estado
FROM INVENTARIO_LOCAL il
JOIN LOCAL l
    ON il.LOCAL_ID_Local = l.ID_Local
JOIN PRODUCTO p
    ON il.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY l.Nombre_Local, p.Nombre_Producto;

-- =====================================================
-- ii. Reporte de Compras por Proveedor y Productos
-- =====================================================

SELECT
    pr.Nombre_Proveedor,
    l.Nombre_Local,
    c.Numero_Factura,
    TO_CHAR(c.Fecha_Compra, 'DD/MM/YYYY HH24:MI:SS') AS Fecha_Compra,
    p.Nombre_Producto,
    dc.Cantidad,
    dc.Costo_Unitario,
    dc.Cantidad * dc.Costo_Unitario AS Total_Linea
FROM COMPRA c
JOIN PROVEEDOR pr
    ON c.PROVEEDOR_ID_Proveedor = pr.ID_Proveedor
JOIN LOCAL l
    ON c.LOCAL_ID_Local = l.ID_Local
JOIN DETALLE_COMPRA dc
    ON c.ID_Compra = dc.COMPRA_ID_Compra
JOIN PRODUCTO p
    ON dc.PRODUCTO_ID_Producto = p.ID_Producto
ORDER BY pr.Nombre_Proveedor, c.Fecha_Compra, p.Nombre_Producto;

-- =====================================================
-- Verificación final de datos cargados en la base de datos
-- =====================================================

SELECT 'CATEGORIA' AS TABLA, COUNT(*) AS TOTAL FROM CATEGORIA
UNION ALL
SELECT 'LOCAL', COUNT(*) FROM LOCAL
UNION ALL
SELECT 'PRODUCTO', COUNT(*) FROM PRODUCTO
UNION ALL
SELECT 'PROVEEDOR', COUNT(*) FROM PROVEEDOR
UNION ALL
SELECT 'CLIENTE', COUNT(*) FROM CLIENTE
UNION ALL
SELECT 'PRODUCTO_PROVEEDOR', COUNT(*) FROM PRODUCTO_PROVEEDOR
UNION ALL
SELECT 'INVENTARIO_LOCAL', COUNT(*) FROM INVENTARIO_LOCAL
UNION ALL
SELECT 'COMPRA', COUNT(*) FROM COMPRA
UNION ALL
SELECT 'DETALLE_COMPRA', COUNT(*) FROM DETALLE_COMPRA
UNION ALL
SELECT 'VENTA', COUNT(*) FROM VENTA
UNION ALL
SELECT 'DETALLE_VENTA', COUNT(*) FROM DETALLE_VENTA;

-- =====================================================