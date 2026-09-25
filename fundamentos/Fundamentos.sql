SELECT *
FROM cat;

-- Mostrar los registros de la tabla paises
SELECT *
FROM paises;

-- Mostrar empleados cuyo nombre comienza con A
SELECT nombre, apellido, idemp, salario, iddep
FROM empleados
WHERE nombre LIKE 'A%'
ORDER BY nombre;