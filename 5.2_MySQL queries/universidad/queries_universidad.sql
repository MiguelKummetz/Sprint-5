USE universidad;

-- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p 
INNER JOIN alumno_se_matricula_asignatura a ON p.id = a.id_alumno
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p 
INNER JOIN alumno_se_matricula_asignatura a ON p.id = a.id_alumno
WHERE p.telefono IS NULL;

-- 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p 
INNER JOIN alumno_se_matricula_asignatura a ON p.id = a.id_alumno
WHERE p.fecha_nacimiento LIKE '1999%';

-- 4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p 
INNER JOIN profesor o ON p.id = o.id_profesor
WHERE (p.telefono IS NULL) AND (p.nif LIKE '%K');

-- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT a.id, a.nombre FROM asignatura a 
INNER JOIN grado g ON a.id_grado = g.id
WHERE (a.cuatrimestre = 1) AND (a.curso = 3) AND (g.id = 7);

-- 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM persona p 
INNER JOIN profesor o ON p.id = o.id_profesor
INNER JOIN departamento d ON o.id_departamento = d.id
ORDER BY p.apellido1, p.apellido2, p.nombre;

-- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre, c.anyo_inicio, c.anyo_fin FROM alumno_se_matricula_asignatura m
INNER JOIN persona p ON m.id_alumno = p.id
INNER JOIN asignatura a ON m.id_asignatura = a.id
INNER JOIN curso_escolar c ON m.id_curso_escolar = c.id
WHERE p.nif = '26902806M';

-- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM departamento d
INNER JOIN profesor p ON d.id = p.id_departamento
INNER JOIN asignatura a ON p.id_profesor = a.id_profesor
INNER JOIN grado g ON g.id = a.id_grado
WHERE g.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.apellido1, p.apellido2, p.nombre FROM persona p
INNER JOIN alumno_se_matricula_asignatura m ON p.id = m.id_alumno
INNER JOIN curso_escolar c ON m.id_curso_escolar = c.id
WHERE c.anyo_inicio = 2018;

--------------------
-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT DISTINCT d.nombre AS 'nombre del departamento',
p.nombre, p.apellido1, p.apellido2
FROM persona p
LEFT JOIN profesor r ON p.id = r.id_profesor
LEFT JOIN departamento d ON r.id_departamento = d.id
LEFT JOIN asignatura a ON r.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor'
ORDER BY d.nombre, p.apellido1, p.apellido2, p.nombre;

-- 2 Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM persona p
LEFT JOIN profesor r ON p.id = r.id_profesor
LEFT JOIN asignatura a ON r.id_profesor = a.id_profesor
WHERE p.tipo = 'profesor' AND r.id_departamento IS NULL;

-- 3 Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT DISTINCT d.nombre AS 'departamento sin profesor asocido'
FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
WHERE p.id_departamento IS NULL;

-- 4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM asignatura a
RIGHT JOIN profesor r ON a.id_profesor = r.id_profesor
LEFT JOIN persona p ON r.id_profesor = p.id
WHERE a.id_profesor IS NULL;

-- 5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2
FROM asignatura a
RIGHT JOIN profesor r ON a.id_profesor = r.id_profesor
LEFT JOIN persona p ON r.id_profesor = p.id
WHERE a.id_profesor IS NULL;

-- 6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT DISTINCT d.nombre FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
WHERE a.curso IS NULL

--------------------
-- Consultes resum:

-- 1 Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(DISTINCT a.id_alumno) AS 'numero de alumnos' FROM alumno_se_matricula_asignatura a;

-- 2 Calcula quants alumnes van néixer en 1999.
SELECT COUNT(DISTINCT a.id_alumno) AS 'numero de alumnos nacidos en 1999' FROM alumno_se_matricula_asignatura a
INNER JOIN persona p ON a.id_alumno = p.id
WHERE p.fecha_nacimiento LIKE '1999%';

-- 3 Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT d.nombre AS 'nombre del departamento',
COUNT(p.id_profesor) AS 'numero de profesores' FROM departamento d
INNER JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;

-- 4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre AS 'nombre del departamento',
COUNT(p.id_profesor) AS 'numero de profesores' FROM departamento d
LEFT JOIN profesor p ON d.id = p.id_departamento
GROUP BY d.nombre ORDER BY COUNT(p.id_profesor) DESC;

-- 5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre AS 'nombre del grado',
COUNT(a.id) AS 'numero de asignaturas' FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre ORDER BY COUNT(a.id) DESC;

-- 6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre AS 'nombre del grado',
COUNT(a.id) AS 'numero de asignaturas' FROM grado g
LEFT JOIN asignatura a ON g.id = a.id_grado
GROUP BY g.nombre 
HAVING COUNT(a.id) > 40
ORDER BY COUNT(a.id) DESC;

-- 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre AS 'nombre del grado',
a.tipo AS 'tipo de asignatura',
SUM(a.creditos) AS 'suma total de creditos'
FROM asignatura a
INNER JOIN grado g ON a.id_grado = g.id
GROUP BY g.nombre, a.tipo;

-- 8 Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT c.anyo_inicio AS 'año de inicio escolar',
COUNT(DISTINCT a.id_alumno) AS 'numero de alumnos matriculados'
FROM curso_escolar c
INNER JOIN alumno_se_matricula_asignatura a ON c.id = a.id_curso_escolar
GROUP BY c.anyo_inicio;

-- 9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT r.id, r.nombre, r.apellido1, r.apellido2,
COUNT(a.id_profesor) AS 'numero de asignaturas'
FROM profesor p
LEFT JOIN asignatura a ON p.id_profesor = a.id_profesor
INNER JOIN persona r ON p.id_profesor = r.id
GROUP BY r.id
ORDER BY COUNT(a.id_profesor) DESC;

-- 10 Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona
WHERE tipo = 'alumno'
ORDER BY fecha_nacimiento DESC LIMIT 1;

-- 11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.id, p.nombre, p.apellido1, p.apellido2, 
d.nombre AS 'nombre del departamento' FROM profesor r
LEFT JOIN persona p ON r.id_profesor = p.id
LEFT JOIN departamento d ON r.id_departamento = d.id
LEFT JOIN asignatura a ON r.id_profesor = a.id_profesor
WHERE a.id_profesor IS NULL;