USE tienda;

-- 1
SELECT DISTINCT nombre from producto;

-- 2
SELECT nombre, precio FROM producto;

-- 3
SELECT * FROM producto;

-- 4
SELECT nombre, precio, ROUND(precio * 1.06, 2) FROM producto;

-- 5
SELECT nombre AS "nom de producto", precio AS "euros", ROUND(precio * 1.06, 2) AS "dólares" FROM producto;

-- 6
SELECT UPPER(nombre) AS nombre, precio FROM producto;

-- 7
SELECT LOWER(nombre) AS nombre, precio FROM producto;

-- 8
SELECT nombre, UPPER(SUBSTRING(nombre, 1, 2)) AS dos_primeras_letras FROM fabricante;

-- 9
SELECT nombre, ROUND(precio) AS precio FROM producto;

-- 10
SELECT nombre, TRUNCATE(precio, 0) AS precio FROM producto;

-- 11
SELECT codigo_fabricante FROM producto;

-- 12
SELECT DISTINCT codigo_fabricante FROM producto;

-- 13
SELECT nombre FROM fabricante ORDER BY nombre;

-- 14

-- 15

-- 16

-- 17


-- 18


-- 19


-- 20


-- 21


-- 22


-- 23


-- 24


-- 25


-- 26


-- 27


-- 28


-- 29


-- 30


-- 31


-- 32


-- 33


-- 34


-- 35


-- 36


-- 37


-- 38


-- 39


-- 40


-- 41