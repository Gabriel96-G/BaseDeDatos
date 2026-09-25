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


--------------


START C:\Users\amedr\bases\Fundamentos.sql





---------------------------------------
-- =====================================================================
-- Universidad CENFOTEC - Escuela de Software
-- Curso: INF-03 Fundamentos de Bases de Datos - Sección SCV4
-- Segunda Práctica - Periodo 2026/c2
-- 
-- a. Matriz con la cantidad de personas por el día de la semana de su
--    nacimiento vs. la década de su año de nacimiento
-- =====================================================================



SELECT dia,
       COUNT(CASE WHEN decada='50s' THEN 1 END) AS "50s",
       COUNT(CASE WHEN decada='60s' THEN 1 END) AS "60s",
       COUNT(CASE WHEN decada='70s' THEN 1 END) AS "70s",
       COUNT(CASE WHEN decada='80s' THEN 1 END) AS "80s",
       COUNT(CASE WHEN decada='90s' THEN 1 END) AS "90s",
       COUNT(CASE WHEN decada='00s' THEN 1 END) AS "00s"
FROM (
    SELECT
        CASE MOD(MOD(TRUNC(dianacimiento) - TO_DATE('2018-01-01','YYYY-MM-DD'),7)+7,7)
            WHEN 0 THEN 'Lunes'
            WHEN 1 THEN 'Martes'
            WHEN 2 THEN 'Miercoles'
            WHEN 3 THEN 'Jueves'
            WHEN 4 THEN 'Viernes'
            WHEN 5 THEN 'Sabado'
            WHEN 6 THEN 'Domingo'
        END AS dia,
        MOD(MOD(TRUNC(dianacimiento) - TO_DATE('2018-01-01','YYYY-MM-DD'),7)+7,7) AS dia_num,
        TO_CHAR(MOD(TRUNC(EXTRACT(YEAR FROM dianacimiento)/10)*10,100),'FM00')||'s' AS decada
    FROM empleados
)
GROUP BY dia, dia_num
ORDER BY dia_num;


-- =====================================================================
-- b. Matriz con los promedios de edad de mujeres y de hombres
--    agrupados por su signo zodiacal
-- =====================================================================

SELECT signo,
       ROUND(AVG(CASE WHEN sexo='F' THEN edad END)) AS Mujeres,
       ROUND(AVG(CASE WHEN sexo='M' THEN edad END)) AS Hombres
FROM (
    SELECT sexo,
           TRUNC(MONTHS_BETWEEN(SYSDATE, dianacimiento)/12) AS edad,
           CASE
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0321' AND '0419' THEN 'Aries'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0420' AND '0520' THEN 'Tauro'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0521' AND '0620' THEN 'Geminis'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0621' AND '0722' THEN 'Cancer'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0723' AND '0822' THEN 'Leo'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0823' AND '0922' THEN 'Virgo'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0923' AND '1022' THEN 'Libra'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '1023' AND '1121' THEN 'Escorpio'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '1122' AND '1221' THEN 'Sagitario'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0120' AND '0218' THEN 'Acuario'
               WHEN TO_CHAR(dianacimiento,'MMDD') BETWEEN '0219' AND '0320' THEN 'Piscis'
               ELSE 'Capricornio'
           END AS signo
    FROM empleados
)
GROUP BY signo
ORDER BY signo;




---------------------------------------------------------------------------------
----------------------------------------------------------------------------------

COLUMN NOMBRE FORMAT A25
COLUMN CIUDAD FORMAT A15
COLUMN CONTINENTE FORMAT A10

SELECT e.nombre || ' ' || e.apellido AS NOMBRE,
       e.salario AS SALARIO,
       o.ciudad AS CIUDAD,
       o.idpais AS ID,
       c.nombre AS CONTINENTE
FROM empleados e
JOIN departamentos d ON e.iddep = d.iddep
JOIN oficinas o       ON d.idoficina = o.idoficina
JOIN paises p         ON o.idpais = p.idpais
JOIN continentes c    ON p.idcont = c.idcont
WHERE c.nombre = 'America'
  AND p.idpais <> 'US'
ORDER BY e.nombre, e.apellido;

