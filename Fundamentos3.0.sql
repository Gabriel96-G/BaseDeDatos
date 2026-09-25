-------------------------------------------------------------------------
Q1
-------------------------------------------------------------------------


SELECT e.nombre AS NOMBRE,
       e.apellido AS APELLIDO,
       TO_NUMBER(TO_CHAR(e.dianacimiento, 'YYYY')) AS ANIO_NACIMIENTO,
       TRUNC(
           MONTHS_BETWEEN(SYSDATE, e.dianacimiento) / 12
       ) AS EDAD
FROM empleados e
WHERE (
          EXISTS (
              SELECT 1
              FROM empleados subalterno
              WHERE subalterno.IDjefe = e.IDemp
          )
          OR
          EXISTS (
              SELECT 1
              FROM departamentos d
              WHERE d.IDdirector = e.IDemp
          )
      )
  AND TRUNC(
          TO_NUMBER(TO_CHAR(e.dianacimiento, 'YYYY')),
          -1
      ) = (
          SELECT decada
          FROM (
              SELECT TRUNC(
                         TO_NUMBER(
                             TO_CHAR(persona.dianacimiento, 'YYYY')
                         ),
                         -1
                     ) AS decada,
                     COUNT(*) AS cantidad_personas
              FROM empleados persona
              WHERE NOT EXISTS (
                  SELECT 1
                  FROM empleados subalterno
                  WHERE subalterno.IDjefe = persona.IDemp
              )
              GROUP BY TRUNC(
                           TO_NUMBER(
                               TO_CHAR(persona.dianacimiento, 'YYYY')
                           ),
                           -1
                       )
              ORDER BY cantidad_personas DESC,
                       decada ASC
          )
          WHERE ROWNUM = 1
      )
ORDER BY e.apellido ASC,
         e.nombre ASC;

-------------------------------------------------------------------------
Q2
-------------------------------------------------------------------------

SELECT e.apellido AS APELLIDO,
       e.nombre AS NOMBRE,
       TO_CHAR(e.dianacimiento, 'MM') AS MES_NACIMIENTO,
       ROUND(
           MONTHS_BETWEEN(SYSDATE, e.dianacimiento) / 12
       ) AS EDAD
FROM empleados e
WHERE ROUND(
          MONTHS_BETWEEN(SYSDATE, e.dianacimiento) / 12
      ) = (
          SELECT TRUNC(
                     AVG(
                         MONTHS_BETWEEN(
                             SYSDATE,
                             empleado_dep.dianacimiento
                         ) / 12
                     )
                 )
          FROM empleados empleado_dep
          WHERE empleado_dep.IDdep = e.IDdep
      )
ORDER BY EDAD ASC,
         e.apellido ASC;
         
-------------------------------------------------------------------------
Q3
-------------------------------------------------------------------------
SELECT nombre AS NOMBRE,
       apellido AS APELLIDO,
       cantidad_subalternos_hombres AS CANTIDAD_SUBALTERNOS_HOMBRES
FROM (
    SELECT nombre,
           apellido,
           cantidad_subalternos_hombres,
           edad,
           dianacimiento,
           IDemp
    FROM (
        SELECT jefa.IDemp,
               jefa.nombre,
               jefa.apellido,
               jefa.dianacimiento,
               TRUNC(
                   MONTHS_BETWEEN(SYSDATE, jefa.dianacimiento) / 12
               ) AS edad,
               (
                   SELECT COUNT(*)
                   FROM empleados subalterno
                   WHERE subalterno.IDjefe = jefa.IDemp
                     AND subalterno.sexo = 'M'
               ) AS cantidad_subalternos_hombres
        FROM empleados jefa
        WHERE jefa.sexo = 'F'
          AND EXISTS (
              SELECT 1
              FROM empleados subalterno
              WHERE subalterno.IDjefe = jefa.IDemp
          )
        ORDER BY jefa.dianacimiento DESC,
                 jefa.IDemp ASC
    )
    WHERE ROWNUM <= 3
)
ORDER BY edad ASC,
         dianacimiento DESC,
         IDemp ASC;



-------------------------------------------------------------------------
Q4
-------------------------------------------------------------------------
SELECT d.nombre AS DEPARTAMENTO,
       director.apellido AS APELLIDO_DIRECTOR,
       (
           SELECT COUNT(*)
           FROM empleados empleado_dep
           WHERE empleado_dep.IDdep = d.IDdep
       ) AS CANTIDAD_EMPLEADOS
FROM departamentos d
JOIN empleados director
  ON director.IDemp = d.IDdirector
WHERE d.IDdep = (
    SELECT IDdep
    FROM (
        SELECT e.IDdep
        FROM empleados e
        WHERE e.IDdep IS NOT NULL
          AND NOT EXISTS (
              SELECT 1
              FROM empleados subalterno
              WHERE subalterno.IDjefe = e.IDemp
          )
        ORDER BY e.dianacimiento ASC,
                 e.IDemp ASC
    )
    WHERE ROWNUM = 1
);

----------------------------------------------------------------------
----------------------------------------------------------------------









