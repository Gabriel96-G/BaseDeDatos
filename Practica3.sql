-- =====================================================================
-- Universidad CENFOTEC - Escuela de Software
-- Codigo del curso: INF-03 | Fundamentos de Bases de Datos
-- Seccion: SCV4 | Periodo: 2026/c2
-- Estudiante: Alejandro Medrano Ruiz
-- Docente facilitador: Luis Alberto Monge Fuentes
-- Tercera Practica
-- =====================================================================


-- =====================================================================
-- COMPROBACION DEL ESTADO INICIAL
--
-- Ejecutar estas consultas antes de realizar cualquier UPDATE.
--
-- Resultados esperados:
-- Programadores: 23
-- Vendedores:    41
-- Empleados:    229
-- =====================================================================

SELECT COUNT(*) AS CANTIDAD_PROGRAMADORES
FROM empleados
WHERE IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'ING. SISTEMAS'
);


SELECT COUNT(*) AS CANTIDAD_VENDEDORES
FROM empleados
WHERE IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
);


SELECT COUNT(*) AS CANTIDAD_EMPLEADOS
FROM empleados;


-- =====================================================================
-- PUNTO DE RECUPERACION
--
-- Permite deshacer los cambios mientras no se haya ejecutado COMMIT.
-- =====================================================================

SAVEPOINT antes_practica3;


-- =====================================================================
-- PARTE 1
-- CAMBIOS EN LA BASE DE DATOS
-- =====================================================================


-- =====================================================================
-- a. Los programadores (Ing. Sistemas) tendran de jefe al
--    programador de mayor edad.
--
-- Mayor edad significa que tiene la fecha de nacimiento mas antigua.
-- =====================================================================

UPDATE empleados
SET IDjefe = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'ING. SISTEMAS'
        )
        ORDER BY dianacimiento ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
)
WHERE IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'ING. SISTEMAS'
);


-- =====================================================================
-- Resultado esperado del inciso a:
-- 23 rows updated.
-- =====================================================================


-- =====================================================================
-- Verificacion inmediata del inciso a.
--
-- Esta verificacion debe ejecutarse antes del inciso e.
--
-- Resultado esperado:
-- 321 | SHAELEIGH | CASH | 23
-- =====================================================================

SELECT j.IDemp AS ID_JEFE,
       j.nombre AS NOMBRE_JEFE,
       j.apellido AS APELLIDO_JEFE,
       COUNT(*) AS CANTIDAD_PROGRAMADORES
FROM empleados p
JOIN empleados j
  ON j.IDemp = p.IDjefe
WHERE p.IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'ING. SISTEMAS'
)
GROUP BY j.IDemp,
         j.nombre,
         j.apellido;


-- =====================================================================
-- b. Los vendedores (Experto en Ventas) tendran de jefe al
--    vendedor con mayor antiguedad.
--
-- Mayor antiguedad significa que tiene la fecha de ingreso mas antigua.
-- =====================================================================

UPDATE empleados
SET IDjefe = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
        )
        ORDER BY diaingreso ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
)
WHERE IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
);


-- =====================================================================
-- Resultado esperado del inciso b:
-- 41 rows updated.
-- =====================================================================


-- =====================================================================
-- Verificacion inmediata del inciso b.
--
-- Esta verificacion debe ejecutarse antes del inciso e.
--
-- Resultado esperado:
-- 178 | JANDER | PANELL | 41
-- =====================================================================

SELECT j.IDemp AS ID_JEFE,
       j.nombre AS NOMBRE_JEFE,
       j.apellido AS APELLIDO_JEFE,
       COUNT(*) AS CANTIDAD_VENDEDORES
FROM empleados v
JOIN empleados j
  ON j.IDemp = v.IDjefe
WHERE v.IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
)
GROUP BY j.IDemp,
         j.nombre,
         j.apellido;


-- =====================================================================
-- c. El nuevo jefe de los programadores tendra de jefe al
--    director mas joven.
--
-- El director mas joven es quien tiene la fecha de nacimiento
-- mas reciente.
-- =====================================================================

UPDATE empleados
SET IDjefe = (
    SELECT IDemp
    FROM (
        SELECT e.IDemp
        FROM empleados e
        WHERE e.IDemp IN (
            SELECT IDdirector
            FROM departamentos
            WHERE IDdirector IS NOT NULL
        )
        ORDER BY e.dianacimiento DESC,
                 e.IDemp ASC
    )
    WHERE ROWNUM = 1
)
WHERE IDemp = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'ING. SISTEMAS'
        )
        ORDER BY dianacimiento ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- Resultado esperado del inciso c:
-- 1 row updated.
-- =====================================================================


-- =====================================================================
-- Verificacion del inciso c.
--
-- Resultado esperado:
-- 321 | SHAELEIGH | CASH | 121 | LUCIUS | JOSEPH
-- =====================================================================

SELECT jp.IDemp AS ID_JEFE_PROGRAMADORES,
       jp.nombre AS NOMBRE_JEFE_PROGRAMADORES,
       jp.apellido AS APELLIDO_JEFE_PROGRAMADORES,
       director.IDemp AS ID_DIRECTOR,
       director.nombre AS NOMBRE_DIRECTOR,
       director.apellido AS APELLIDO_DIRECTOR
FROM empleados jp
JOIN empleados director
  ON director.IDemp = jp.IDjefe
WHERE jp.IDemp = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'ING. SISTEMAS'
        )
        ORDER BY dianacimiento ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- d. El nuevo jefe de los vendedores tendra de jefe al
--    director con menos antiguedad.
--
-- El director con menos antiguedad es quien tiene la fecha de ingreso
-- mas reciente.
-- =====================================================================

UPDATE empleados
SET IDjefe = (
    SELECT IDemp
    FROM (
        SELECT e.IDemp
        FROM empleados e
        WHERE e.IDemp IN (
            SELECT IDdirector
            FROM departamentos
            WHERE IDdirector IS NOT NULL
        )
        ORDER BY e.diaingreso DESC,
                 e.IDemp ASC
    )
    WHERE ROWNUM = 1
)
WHERE IDemp = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
        )
        ORDER BY diaingreso ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- Resultado esperado del inciso d:
-- 1 row updated.
-- =====================================================================


-- =====================================================================
-- Verificacion del inciso d.
--
-- Resultado esperado:
-- 178 | JANDER | PANELL | 108 | MATTHEW | POLLARD
-- =====================================================================

SELECT jv.IDemp AS ID_JEFE_VENDEDORES,
       jv.nombre AS NOMBRE_JEFE_VENDEDORES,
       jv.apellido AS APELLIDO_JEFE_VENDEDORES,
       director.IDemp AS ID_DIRECTOR,
       director.nombre AS NOMBRE_DIRECTOR,
       director.apellido AS APELLIDO_DIRECTOR
FROM empleados jv
JOIN empleados director
  ON director.IDemp = jv.IDjefe
WHERE jv.IDemp = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDpuesto = (
            SELECT IDpuesto
            FROM puestos
            WHERE UPPER(titulo) = 'EXPERTO EN VENTAS'
        )
        ORDER BY diaingreso ASC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- e. Todos los directores cambiaran de puesto al de
--    Director Principal.
--
-- Los directores son los empleados cuyo ID aparece en la columna
-- IDdirector de la tabla DEPARTAMENTOS.
-- =====================================================================

UPDATE empleados
SET IDpuesto = (
    SELECT IDpuesto
    FROM puestos
    WHERE UPPER(titulo) = 'DIRECTOR PRINCIPAL'
)
WHERE IDemp IN (
    SELECT IDdirector
    FROM departamentos
    WHERE IDdirector IS NOT NULL
);


-- =====================================================================
-- Resultado esperado del inciso e:
-- 18 rows updated.
-- =====================================================================


-- =====================================================================
-- Verificar que los directores tengan el puesto Director Principal.
--
-- Debe mostrar 18 empleados diferentes con:
-- IDpuesto = A02
-- titulo   = Director Principal
-- =====================================================================

SELECT DISTINCT e.IDemp,
       e.nombre,
       e.apellido,
       e.IDpuesto,
       p.titulo
FROM empleados e
JOIN puestos p
  ON p.IDpuesto = e.IDpuesto
JOIN departamentos d
  ON d.IDdirector = e.IDemp
ORDER BY e.IDemp;


-- =====================================================================
-- Verificacion adicional despues del inciso e.
--
-- Resultados esperados:
-- Programadores C04: 22
-- Vendedores C05:    40
--
-- Esto ocurre porque:
-- Alec Payne era C04 y tambien era director.
-- Hermione Buck era C05 y tambien era directora.
-- Ambos pasan al puesto A02.
-- =====================================================================

SELECT COUNT(*) AS PROGRAMADORES_DESPUES_INCISO_E
FROM empleados
WHERE IDpuesto = 'C04';


SELECT COUNT(*) AS VENDEDORES_DESPUES_INCISO_E
FROM empleados
WHERE IDpuesto = 'C05';


-- =====================================================================
-- f. El email de los empleados que NO son jefes se formara con:
--
--    3 letras del apellido
--    + punto
--    + 3 letras del nombre
--    + guion bajo
--    + mes de ingreso
--    + arroba
--    + 3 letras de la ciudad
--    + punto
--    + ID del pais
--
-- Ejemplo:
-- MOR.BRU_01@Mun.DE
-- =====================================================================

UPDATE empleados e
SET email = (
    SELECT UPPER(SUBSTR(e.apellido, 1, 3))
           || '.'
           || UPPER(SUBSTR(e.nombre, 1, 3))
           || '_'
           || TO_CHAR(e.diaingreso, 'MM')
           || '@'
           || INITCAP(SUBSTR(o.ciudad, 1, 3))
           || '.'
           || UPPER(o.IDpais)
    FROM departamentos d
    JOIN oficinas o
      ON o.IDoficina = d.IDoficina
    WHERE d.IDdep = e.IDdep
)
WHERE NOT EXISTS (
    SELECT 1
    FROM empleados subordinado
    WHERE subordinado.IDjefe = e.IDemp
);


-- =====================================================================
-- Resultado esperado del inciso f:
-- 205 rows updated.
--
-- La base contiene:
-- 230 empleados
-- 25 empleados que son jefes
-- 205 empleados que no son jefes
-- =====================================================================


-- =====================================================================
-- Verificar la cantidad de empleados que no son jefes.
--
-- Resultado esperado:
-- 205
-- =====================================================================

SELECT COUNT(*) AS EMPLEADOS_NO_JEFES
FROM empleados e
WHERE NOT EXISTS (
    SELECT 1
    FROM empleados subordinado
    WHERE subordinado.IDjefe = e.IDemp
);

SELECT COUNT(*) AS TOTAL_EMPLEADOS
FROM empleados;

SELECT COUNT(DISTINCT IDjefe) AS TOTAL_JEFES
FROM empleados
WHERE IDjefe IS NOT NULL;

SELECT COUNT(*) AS EMPLEADOS_NO_JEFES
FROM empleados e
WHERE NOT EXISTS (
    SELECT 1
    FROM empleados s
    WHERE s.IDjefe = e.IDemp
);
-- =====================================================================
-- Verificar los emails de los empleados que no son jefes.
-- =====================================================================

SELECT e.IDemp,
       e.nombre,
       e.apellido,
       e.email
FROM empleados e
WHERE NOT EXISTS (
    SELECT 1
    FROM empleados subordinado
    WHERE subordinado.IDjefe = e.IDemp
)
ORDER BY e.IDemp;


-- =====================================================================
-- Verificar especificamente el email de Bruno Morton.
--
-- Resultado esperado:
-- 507 | BRUNO | MORTON | MOR.BRU_01@Mun.DE
-- =====================================================================

SELECT IDemp,
       nombre,
       apellido,
       email
FROM empleados
WHERE UPPER(nombre) = 'BRUNO'
  AND UPPER(apellido) = 'MORTON';


-- =====================================================================
-- PARTE 2
-- QUERIES PARA RESOLVER LAS PREGUNTAS
-- =====================================================================


-- =====================================================================
-- a. ¿Cuantos jefes con mas de 5 subalternos hay?
-- =====================================================================

SELECT COUNT(*) AS CANTIDAD_JEFES
FROM (
    SELECT IDjefe
    FROM empleados
    WHERE IDjefe IS NOT NULL
    GROUP BY IDjefe
    HAVING COUNT(*) > 5
);


-- =====================================================================
-- Resultado esperado:
-- 16
-- =====================================================================


-- =====================================================================
-- Comprobacion de la pregunta a.
--
-- Debe mostrar 16 filas.
-- =====================================================================

SELECT jefe.IDemp AS ID_JEFE,
       jefe.nombre,
       jefe.apellido,
       COUNT(*) AS CANTIDAD_SUBALTERNOS
FROM empleados subordinado
JOIN empleados jefe
  ON jefe.IDemp = subordinado.IDjefe
GROUP BY jefe.IDemp,
         jefe.nombre,
         jefe.apellido
HAVING COUNT(*) > 5
ORDER BY CANTIDAD_SUBALTERNOS DESC,
         jefe.IDemp ASC;


-- =====================================================================
-- b. ¿Cual es el apellido del director-jefe con menos antiguedad?
--
-- Menos antiguedad significa que tiene la fecha de ingreso
-- mas reciente.
-- =====================================================================

SELECT apellido AS APELLIDO_DIRECTOR_JEFE
FROM (
    SELECT e.apellido,
           e.diaingreso,
           e.IDemp
    FROM empleados e
    WHERE e.IDemp IN (
        SELECT IDdirector
        FROM departamentos
        WHERE IDdirector IS NOT NULL
    )
      AND EXISTS (
          SELECT 1
          FROM empleados subordinado
          WHERE subordinado.IDjefe = e.IDemp
      )
    ORDER BY e.diaingreso DESC,
             e.IDemp ASC
)
WHERE ROWNUM = 1;


-- =====================================================================
-- Resultado esperado:
-- POLLARD
-- =====================================================================


-- =====================================================================
-- Comprobacion de la pregunta b.
--
-- Resultado esperado:
-- 108 | MATTHEW | POLLARD | 28/04/2027
-- =====================================================================

SELECT IDemp,
       nombre,
       apellido,
       diaingreso
FROM (
    SELECT e.IDemp,
           e.nombre,
           e.apellido,
           e.diaingreso
    FROM empleados e
    WHERE e.IDemp IN (
        SELECT IDdirector
        FROM departamentos
        WHERE IDdirector IS NOT NULL
    )
      AND EXISTS (
          SELECT 1
          FROM empleados subordinado
          WHERE subordinado.IDjefe = e.IDemp
      )
    ORDER BY e.diaingreso DESC,
             e.IDemp ASC
)
WHERE ROWNUM = 1;


-- =====================================================================
-- c. ¿Cual es la edad del jefe con mas subalternos?
-- =====================================================================

SELECT edad AS EDAD_JEFE_MAS_SUBALTERNOS
FROM (
    SELECT jefe.IDemp,
           TRUNC(
               MONTHS_BETWEEN(SYSDATE, jefe.dianacimiento) / 12
           ) AS edad,
           COUNT(*) AS cantidad_subalternos
    FROM empleados jefe
    JOIN empleados subordinado
      ON subordinado.IDjefe = jefe.IDemp
    GROUP BY jefe.IDemp,
             jefe.dianacimiento
    ORDER BY COUNT(*) DESC,
             jefe.IDemp ASC
)
WHERE ROWNUM = 1;


-- =====================================================================
-- Resultado esperado al 02/08/2026:
-- 51
-- =====================================================================


-- =====================================================================
-- Comprobacion de la pregunta c.
--
-- Resultado esperado:
-- 178 | JANDER | PANELL | 51 | 40
-- =====================================================================

SELECT IDemp,
       nombre,
       apellido,
       edad,
       cantidad_subalternos
FROM (
    SELECT jefe.IDemp,
           jefe.nombre,
           jefe.apellido,
           TRUNC(
               MONTHS_BETWEEN(SYSDATE, jefe.dianacimiento) / 12
           ) AS edad,
           COUNT(*) AS cantidad_subalternos
    FROM empleados jefe
    JOIN empleados subordinado
      ON subordinado.IDjefe = jefe.IDemp
    GROUP BY jefe.IDemp,
             jefe.nombre,
             jefe.apellido,
             jefe.dianacimiento
    ORDER BY COUNT(*) DESC,
             jefe.IDemp ASC
)
WHERE ROWNUM = 1;


-- =====================================================================
-- d. ¿Cual es la edad del director del departamento que tiene
--    a la persona mas joven?
-- =====================================================================

SELECT TRUNC(
           MONTHS_BETWEEN(SYSDATE, director.dianacimiento) / 12
       ) AS EDAD_DIRECTOR
FROM empleados director
JOIN departamentos d
  ON d.IDdirector = director.IDemp
WHERE d.IDdep = (
    SELECT IDdep
    FROM (
        SELECT IDdep
        FROM empleados
        WHERE IDdep IS NOT NULL
        ORDER BY dianacimiento DESC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- Resultado esperado al 02/08/2026:
-- 52
-- =====================================================================


-- =====================================================================
-- Comprobacion de la pregunta d.
--
-- Resultado esperado:
-- 148 | CHARLOTTE | PERKINS | 29/10/2000
-- Departamento 80 | Gestion de Ventas
-- Director 145 | LEVI | MENDOZA | 52
-- =====================================================================

SELECT joven.IDemp AS ID_PERSONA_JOVEN,
       joven.nombre AS NOMBRE_PERSONA_JOVEN,
       joven.apellido AS APELLIDO_PERSONA_JOVEN,
       joven.dianacimiento,
       d.IDdep,
       d.nombre AS DEPARTAMENTO,
       director.IDemp AS ID_DIRECTOR,
       director.nombre AS NOMBRE_DIRECTOR,
       director.apellido AS APELLIDO_DIRECTOR,
       TRUNC(
           MONTHS_BETWEEN(SYSDATE, director.dianacimiento) / 12
       ) AS EDAD_DIRECTOR
FROM empleados joven
JOIN departamentos d
  ON d.IDdep = joven.IDdep
JOIN empleados director
  ON director.IDemp = d.IDdirector
WHERE joven.IDemp = (
    SELECT IDemp
    FROM (
        SELECT IDemp
        FROM empleados
        WHERE IDdep IS NOT NULL
        ORDER BY dianacimiento DESC,
                 IDemp ASC
    )
    WHERE ROWNUM = 1
);


-- =====================================================================
-- CONFIRMAR LOS CAMBIOS
--
-- Ejecutar COMMIT solamente cuando todos los resultados hayan sido
-- revisados y sean correctos.
-- =====================================================================

COMMIT;


-- =====================================================================
-- Para deshacer los cambios antes del COMMIT:
--
-- ROLLBACK TO antes_practica3;
-- =====================================================================

ROLLBACK TO antes_practica3;
-- =====================================================================
-- Nombre del documento para Moodle:
-- Medrano-Alejandro-Practica3.pdf
-- =====================================================================

























