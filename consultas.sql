USE tienda;
/**
1.1.3 Consultas sobre una tabla
Lista el nombre de todos los productos que hay en la tabla producto.
**/
SELECT nombre FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto.
SELECT nombre, precio FROM producto;

-- Lista todas las columnas de la tabla producto.
SELECT * FROM producto;

-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD).
SELECT nombre,
	  CONCAT('$',FORMAT(precio,2,'es_US')), -- formato precio dolar
      CONCAT('€',FORMAT(precio,2,'de_DE'))  -- formato precio euro
	FROM producto;
	
-- Lista el nombre de los productos, el precio en euros y el precio en dólares estadounidenses (USD). Utiliza los siguientes alias para las columnas: nombre de producto, euros, dólares.
SELECT nombre AS 'Productos',
		CONCAT('$',FORMAT(precio,2,'es_US')) AS 'Dólares',
        CONCAT('€',FORMAT(precio,2,'de_DE')) AS 'Euros'
	FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre) AS 'Nombre', precio FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, convirtiendo los nombres a minúscula.
SELECT LOWER(nombre) AS 'Nombre', precio FROM producto;

-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre AS "Nombres Fabricantes",
		MID(nombre,1,2) AS 'Primeros 2 caracteres' 
	FROM fabricante;

-- Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.
SELECT nombre, 
	   precio, 
       ROUND(precio) AS 'Precio redondeado' 
	FROM producto;

-- Lista los nombres y los precios de todos los productos de la tabla producto, 
-- truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT  nombre, 
		precio,
		REPLACE(CAST(precio AS CHAR(6)),".","") AS 'Precio entero'
	FROM producto;

-- Lista el identificador de los fabricantes que tienen productos en la tabla producto.
SELECT id AS "id_Producto", id_fabricante FROM producto;

-- Lista el identificador de los fabricantes que tienen productos en la tabla producto, eliminando los identificadores que aparecen repetidos.
SELECT DISTINCT id_fabricante FROM producto;

-- Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante
ORDER BY nombre;

-- Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante
ORDER BY nombre DESC;

-- Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.
SELECT nombre, precio
	FROM producto
ORDER BY nombre, precio DESC;

-- Devuelve una lista con las 5 primeras filas de la tabla fabricante.
SELECT * FROM fabricante
LIMIT 5;

-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla fabricante. La cuarta fila también se debe incluir en la respuesta.
SELECT * FROM fabricante
LIMIT 3,2;

-- Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto
ORDER BY precio
LIMIT 1;

-- Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER BY y LIMIT)
SELECT nombre, precio FROM producto
ORDER BY precio DESC
LIMIT 1;

-- Lista el nombre de todos los productos del fabricante cuyo identificador de fabricante es igual a 2.
SELECT nombre FROM producto
WHERE id_fabricante = 2;

-- Lista el nombre de los productos que tienen un precio menor o igual a 120€.
SELECT nombre FROM producto
WHERE precio <= 120;

-- Lista el nombre de los productos que tienen un precio mayor o igual a 400€.
SELECT nombre FROM producto
WHERE precio >= 400;

-- Lista el nombre de los productos que no tienen un precio mayor o igual a 400€.
SELECT nombre,precio FROM producto 
WHERE NOT precio >=400;

-- Lista todos los productos que tengan un precio entre 80€ y 300€. Sin utilizar el operador BETWEEN.
SELECT * FROM producto
WHERE precio > 80 AND precio < 300;

-- Lista todos los productos que tengan un precio entre 60€ y 200€. Utilizando el operador BETWEEN.
SELECT * FROM producto
WHERE precio BETWEEN 60 AND 200;

-- Lista todos los productos que tengan un precio mayor que 200€ y que el identificador de fabricante sea igual a 6.
SELECT * FROM producto
WHERE precio > 200 AND id_fabricante = 6;

-- Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Sin utilizar el operador IN.
SELECT * FROM producto 
WHERE id_fabricante = 1 OR id_fabricante = 3 OR id_fabricante = 5;

-- Lista todos los productos donde el identificador de fabricante sea 1, 3 o 5. Utilizando el operador IN.
SELECT * FROM producto
WHERE id_fabricante IN (1,3,5);

-- Lista el nombre y el precio de los productos en céntimos 
-- (Habrá que multiplicar por 100 el valor del precio). Cree un alias para la columna que contiene el precio que se llame céntimos.
SELECT nombre, 
	   (precio * 100) AS 'Céntimos' 
	FROM producto;

-- Lista los nombres de los fabricantes cuyo nombre empiece por la letra S.
SELECT nombre FROM fabricante
WHERE nombre LIKE 's%';

-- Lista los nombres de los fabricantes cuyo nombre termine por la vocal e.
SELECT nombre FROM fabricante
WHERE nombre LIKE '%e';

-- Lista los nombres de los fabricantes cuyo nombre contenga el carácter w.
SELECT nombre FROM fabricante
WHERE nombre LIKE '%w%';

-- Lista los nombres de los fabricantes cuyo nombre sea de 4 caracteres.
SELECT nombre FROM fabricante
WHERE nombre LIKE '____';

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil en el nombre.
SELECT nombre FROM producto
WHERE nombre LIKE '%Portátil%';

-- Devuelve una lista con el nombre de todos los productos que contienen la cadena Monitor en el nombre y tienen un precio inferior a 215 €.
SELECT nombre, precio FROM producto
WHERE nombre LIKE '%Monitor%' AND precio < 215;

-- Lista el nombre y el precio de todos los productos que tengan un precio mayor o igual a 180€. 
-- Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente).
SELECT nombre, precio FROM producto
WHERE precio >= 180
ORDER BY precio DESC, nombre;

/**1.1.4 Consultas multitabla (Composición interna)
Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2.
--Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
**/
-- consulta combinada
SELECT p.nombre,
		p.precio,
	 (SELECT f.nombre FROM fabricante f WHERE f.id = p.id_fabricante) AS 'Nombre Fabricante'
FROM producto p;

-- Join
SELECT p.nombre, 
		p.precio,
	f.nombre AS 'Nombre Fabricante' FROM producto p
INNER JOIN fabricante f ON f.id = p.id_fabricante;


-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
-- Ordene el resultado por el nombre del fabricante, por orden alfabético.

SELECT p.nombre, p.precio, f.nombre FROM producto p
INNER JOIN fabricante f 
ON p.id_fabricante = f.id
ORDER BY f.nombre;

-- Devuelve una lista con el identificador del producto, nombre del producto, 
-- identificador del fabricante y nombre del fabricante, de todos los productos de la base de datos.

SELECT p.id, 
	   p.nombre, 
	   p.id_fabricante, 
	   f.nombre 
	FROM producto p
INNER JOIN fabricante f 
ON p.id_fabricante = f.id;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre, p.precio, f.nombre AS 'Fabricante' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY precio
LIMIT 1;

-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre, p.precio, f.nombre AS 'Fabricante' FROM producto p 
LEFT JOIN fabricante f ON p.id_fabricante = f.id
ORDER BY precio DESC
LIMIT 1;

-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT  p.id,
		p.nombre AS 'Nombre Producto',
		p.precio,
		p.id_fabricante, 
		f.nombre AS 'Nombre Fabricante'
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo';

-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.id AS 'Id_Producto',
       p.nombre AS 'Nombre Producto', 
       p.precio,
       f.id AS 'Id_Fabricante',
       f.nombre AS 'Nombre Fabricante'
  FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre IN ('Crucial') AND p.precio > 200;

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT * FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';

-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Utilizando el operador IN.
SELECT * FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre IN ('Asus','Hewlett-Packard','Seagate');

-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre termine por la vocal e.
SELECT p.nombre, p.precio, f.nombre FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id 
WHERE f.nombre LIKE '%e'; 

-- Devuelve un listado con el nombre y el precio de todos los productos cuyo nombre de fabricante contenga el carácter w en su nombre.
SELECT p.nombre, p.precio, f.nombre FROM producto p 
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre LIKE '%w%';


/**	Devuelve un listado con el nombre de producto, precio y nombre de fabricante, 
	de todos los productos que tengan un precio mayor o igual a 180€. 
	Ordene el resultado en primer lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden ascendente)
**/
SELECT p.nombre, p.precio, f.nombre AS 'Nombre Fabricante' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio >= 180
ORDER BY p.precio DESC, p.nombre;

-- Devuelve un listado con el identificador y el nombre de fabricante,
-- solamente de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT f.id, f.nombre FROM fabricante f
INNER JOIN producto p ON f.id = p.id_fabricante;

/**1.1.5 Consultas multitabla (Composición externa)
Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
-- Devuelve un listado de todos los fabricantes que existen en la base de datos, 
   junto con los productos que tiene cada uno de ellos. 	
   El listado deberá mostrar también aquellos fabricantes que no tienen productos asociados.
**/
SELECT 	f.id,
		f.nombre AS 'Fabricante',
		p.nombre AS 'Producto', 
		p.precio 
	FROM fabricante f
LEFT JOIN producto p ON f.id = p.id_fabricante;

-- Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT f.nombre FROM producto p
RIGHT JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.id_fabricante IS NULL;

-- ¿Pueden existir productos que no estén relacionados con un fabricante? Justifique su respuesta.
-- si puede haber productos sin fabricante ya que pueden ser fabricados por empresas chicas, esto seria productos genericos
-- que no tienen una marca asociada o fabricante especifico.

/**
1.1.6 Consultas resumen
Calcula el número total de productos que hay en la tabla productos.
**/
SELECT COUNT(*) AS 'Total Productos' FROM producto;

-- Calcula el número total de fabricantes que hay en la tabla fabricante.
SELECT COUNT(*) AS 'Total Fabricantes'FROM fabricante;

-- Calcula el número de valores distintos de identificador de fabricante aparecen en la tabla productos.
SELECT COUNT(DISTINCT id_fabricante) AS 'Fabricantes/Producto' FROM producto;

-- Calcula la media del precio de todos los productos.(promedio)
SELECT (SUM(precio)/COUNT(precio)) AS 'Precio Medio'FROM producto;
SELECT AVG(precio) AS 'Precio Medio' FROM producto; -- funcion avg calcula promedio

-- Calcula el precio más barato de todos los productos.
SELECT MIN(precio) AS 'Menor Precio' FROM producto;

-- Calcula el precio más caro de todos los productos.
SELECT MAX(precio) AS 'Mayor Precio' FROM producto;

-- Lista el nombre y el precio del producto más barato.
SELECT nombre AS 'Producto', MIN(precio) AS 'Menor Precio' FROM producto
GROUP BY nombre 
ORDER BY MIN(precio)
LIMIT 1;

-- Lista el nombre y el precio del producto más caro.
SELECT nombre AS 'Producto', MAX(precio) AS 'Mayor Precio' FROM producto 
GROUP BY nombre
ORDER BY MAX(precio) DESC
LIMIT 1;

-- Calcula la suma de los precios de todos los productos.
SELECT SUM(precio) 'Total Precio' FROM producto;

-- Calcula el número de productos que tiene el fabricante Asus.
SELECT COUNT(p.nombre) AS 'Total Producto Asus'
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus';

-- Calcula la media del precio de todos los productos del fabricante Asus.
SELECT AVG(precio) AS 'Precio Promedio Asus' 
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus';

-- Calcula el precio más barato de todos los productos del fabricante Asus.
SELECT p.nombre AS 'Producto Asus',
	   MIN(p.precio) AS 'Menor Precio'
  FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus'
GROUP BY p.nombre
ORDER BY MIN(p.precio)
LIMIT 1;

-- Calcula el precio más caro de todos los productos del fabricante Asus.
SELECT p.nombre AS 'Producto/Fabricante Asus', 
	   MAX(p.precio) AS 'Mayor Precio' 
	FROM producto p 
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus'
GROUP BY p.nombre
ORDER BY MAX(p.precio) DESC
LIMIT 1;

-- Calcula la suma de todos los productos del fabricante Asus.
SELECT SUM(precio) AS 'Precio Total Fabricante Asus' 
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Asus';

-- Muestra el precio máximo, precio mínimo, precio medio y el número total de productos que tiene el fabricante Crucial.
SELECT f.nombre AS 'Fabricante',
	   MAX(p.precio) AS 'Mayor Precio',
	   MIN(p.precio) AS 'Menor Precio',
       AVG(p.precio) AS 'Precio Promedio',
       SUM(p.precio) AS 'Total Precio'
FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Crucial'
GROUP BY f.nombre;

/**
 Muestra el número total de productos que tiene cada uno de los fabricantes. 
 El listado también debe incluir los fabricantes que no tienen ningún producto. 
 El resultado mostrará dos columnas, una con el nombre del fabricante y 
 otra con el número de productos que tiene. Ordene el resultado descendentemente por el número de productos.
**/
SELECT f.nombre AS 'Fabricante',
       COUNT(p.precio) AS 'Cantidad Producto' 
	FROM producto p
RIGHT JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre
ORDER BY COUNT(p.precio) DESC;

-- Muestra el precio máximo, precio mínimo y precio medio de los productos de cada uno de los fabricantes.
--  El resultado mostrará el nombre del fabricante junto con los datos que se solicitan.
SELECT f.nombre AS 'Fabricantes',
	   MAX(precio) AS 'Precio Máximo',
	   MIN(precio) AS 'Precio Mínimo',
	   ROUND(AVG(precio),2) AS 'Precio Medio'
	FROM producto p
INNER JOIN fabricante f ON p.id_Fabricante = f.id
GROUP BY f.nombre;

/** Muestra el precio máximo, precio mínimo, precio medio y el número total de productos de los fabricantes
	que tienen un precio medio superior a 200€. No es necesario mostrar el nombre del fabricante, 
	con el identificador del fabricante es suficiente.
**/
SELECT p.id_fabricante AS 'id_Fabricante',
	   MAX(p.precio) AS 'Precio Máximo',
	   MIN(p.precio) AS 'Precio Mínimo',
       AVG(p.precio) AS 'Precio Medio',
       COUNT(p.precio) AS 'Total Producto'
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY p.id_fabricante
HAVING AVG(p.precio) >= 200;

/**	
 Muestra el nombre de cada fabricante, junto con el precio máximo, precio mínimo, precio medio y
 el número total de productos de los fabricantes que tienen un precio medio superior a 200€. 
 Es necesario mostrar el nombre del fabricante.
**/
SELECT f.nombre AS 'Fabricantes',
	   MAX(precio) AS 'Precio Máximo',
	   MIN(precio) AS 'Precio Mínimo',
	   AVG(precio) AS 'Precio Medio',
	   COUNT(precio) AS 'Total Producto'
  FROM producto p  
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre
HAVING AVG(p.precio) >= 200;
  
-- Calcula el número de productos que tienen un precio mayor o igual a 180€.
SELECT COUNT(*) AS 'Total_Producto_Mayor_Precio_o_Igual_180' 
FROM producto 
WHERE precio >= 180;

-- Calcula el número de productos que tiene cada fabricante con un precio mayor o igual a 180€.
SELECT f.nombre AS 'Fabricante', COUNT(p.id) AS 'Números Productos' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio >= 180
GROUP BY f.nombre;

-- Lista el precio medio los productos de cada fabricante, mostrando solamente el identificador del fabricante.

SELECT p.id_fabricante, AVG(p.precio) AS 'Precio Medio' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY p.id_fabricante;

-- Lista el precio medio los productos de cada fabricante, mostrando solamente el nombre del fabricante.
SELECT f.nombre, AVG(p.precio) AS 'Precio Medio' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre;

-- Lista los nombres de los fabricantes cuyos productos tienen un precio medio mayor o igual a 150€.
SELECT f.nombre, AVG(precio) AS 'Precio Medio' FROM producto p
RIGHT JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre
HAVING AVG(precio) >= 150;

-- Devuelve un listado con los nombres de los fabricantes que tienen 2 o más productos.
SELECT f.nombre AS 'Fabricantes',
       COUNT(p.id) AS 'Total Producto'
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre
HAVING COUNT(p.id) >= 2;

/**
-- Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno con un 
  precio superior o igual a 220 €. No es necesario mostrar el nombre de los fabricantes que no tienen productos que cumplan la condición.
Ejemplo del resultado esperado:
nombre	total
Lenovo	2
Asus	1
Crucial	1 **/
SELECT f.nombre AS 'Fabricante', 
	   COUNT(p.id) AS 'Total Productos' FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio >= 220
GROUP BY f.nombre
ORDER BY COUNT(p.id) DESC, f.nombre;

/**
-- Devuelve un listado con los nombres de los fabricantes y el número de productos que tiene cada uno 
  con un precio superior o igual a 220 €. El listado debe mostrar el nombre de todos los fabricantes, es decir,
  si hay algún fabricante que no tiene productos con un precio superior o igual a 220€ deberá aparecer en 
  el listado con un valor igual a 0 en el número de productos.
Ejemplo del resultado esperado:
nombre	total
Lenovo	2
Crucial	1
Asus	1
Huawei	0
Samsung	0
Gigabyte 0
Hewlett-Packard	0
Xiaomi	0
Seagate	0 **/

SELECT f.nombre, COUNT(CASE WHEN p.precio >= 220 THEN p.id END) AS 'Total' FROM fabricante f
				-- agregacion condicional que cuenta todos los productos p.id condicionando que el precio sea mayor o igual a 220
				-- me devuelva el valor del producto cumpla o no la condicion, 
LEFT JOIN producto p ON f.id = p.id_fabricante -- garantizando con el left los productos q no tengan fabricante(devuelven null)
GROUP BY f.nombre
ORDER BY COUNT(CASE WHEN p.precio >= 220 THEN p.id END) DESC;

-- Devuelve un listado con los nombres de los fabricantes donde la suma del precio de todos sus productos es superior a 1000 €.
SELECT f.nombre AS 'Fabricante', 
	  SUM(p.precio) AS 'Mayor Productos'
	FROM fabricante f
RIGHT JOIN producto p ON f.id = p.id_fabricante
GROUP BY f.nombre
HAVING SUM(p.precio) > 1000;

/** Devuelve un listado con el nombre del producto más caro que tiene cada fabricante.
  El resultado debe tener tres columnas: nombre del producto, precio y nombre del fabricante.
  El resultado tiene que estar ordenado alfabéticamente de menor a mayor por el nombre del fabricante.
**/

SELECT p.nombre AS 'Producto',
       p.precio,
       f.nombre AS 'Fabricante' 
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE (p.id_fabricante, p.precio) IN (SELECT p.id_fabricante, 
									         MAX(p.precio)
									   FROM producto p 
									   GROUP BY p.id_fabricante)
ORDER BY f.nombre DESC;


/**
1.1.7 Subconsultas (En la cláusula WHERE)
1.1.7.1 Con operadores básicos de comparación
Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
**/

SELECT * FROM producto p 
WHERE p.id_fabricante IN (SELECT f.id
							FROM fabricante f 
						  WHERE f.nombre = 'Lenovo');


-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo.
-- (Sin utilizar INNER JOIN).

SELECT * FROM producto p
WHERE precio = (SELECT MAX(p.precio) FROM fabricante f, producto p 
				WHERE p.id_fabricante = f.id AND f.nombre = 'Lenovo');

-- op2
SELECT * FROM producto
WHERE precio = (
    SELECT MAX(p2.precio) FROM producto p2
    WHERE p2.id_fabricante = ( SELECT f.id
							   FROM fabricante f
							   WHERE f.nombre = 'Lenovo')
);

-- Lista el nombre del producto más caro del fabricante Lenovo.
SELECT p.nombre AS 'Productos' FROM producto p                       
WHERE (p.id_fabricante, p.precio) = (SELECT f.id, MAX(p.precio) FROM fabricante f 
									WHERE f.nombre = 'Lenovo'
                                    GROUP BY f.id
                                    )
LIMIT 1;

-- Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT p.nombre AS 'Producto' FROM producto p
WHERE (p.id_fabricante, p.precio) = (SELECT f.id, 
											MIN(p.precio) 
										FROM fabricante f 
									 WHERE f.nombre = 'Hewlett-Packard'
                                     GROUP BY f.id)
LIMIT 1;

-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT * FROM producto p
WHERE precio >= (SELECT MAX(p.precio) FROM fabricante f, producto p 
					WHERE f.id = p.id_fabricante AND f.nombre = 'Lenovo')
LIMIT 1;
	

-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT  p.id, 
        p.nombre, 
        p.precio, 
        f.nombre AS 'Fabricante'
	FROM producto p, fabricante f
WHERE p.id_fabricante = f.id AND f.nombre = 'Asus'
       AND p.precio > (SELECT AVG(p2.precio) FROM producto p2
						WHERE p2.id_fabricante = f.id);


/**
1.1.7.2 Subconsultas con los operadores ALL y ANY (ANY(ALGUNOS)/ALL(TODOS))
Devuelve el producto más caro que existe en la tabla producto sin hacer uso de MAX, ORDER BY ni LIMIT.
**/
SELECT nombre, precio FROM producto
WHERE precio >= ALL (SELECT precio FROM producto);
-- filtra el precio en la cual sea mayor o igual a todos los valores de la subconsulta con el operador ALL, 
-- retorna true ya que hay precios caros y cumple la condicion

-- Devuelve el producto más barato que existe en la tabla producto sin hacer uso de MIN, ORDER BY ni LIMIT.
SELECT nombre, precio FROM producto
WHERE precio <= ALL (SELECT precio FROM producto);


-- Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando ALL o ANY).
SELECT nombre FROM fabricante
WHERE id = ANY (SELECT id_fabricante FROM producto);


-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando ALL o ANY).
SELECT nombre FROM fabricante 
WHERE id <> ALL (SELECT id_fabricante FROM producto);

/**
1.1.7.3 Subconsultas con IN y NOT IN
Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando IN o NOT IN).
**/
SELECT nombre FROM fabricante 
WHERE id IN (SELECT id_fabricante FROM producto);

-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando IN o NOT IN).
SELECT nombre FROM fabricante
WHERE id NOT IN (SELECT id_fabricante FROM producto);

/**
1.1.7.4 Subconsultas con EXISTS y NOT EXISTS
Devuelve los nombres de los fabricantes que tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
**/
SELECT f.nombre FROM fabricante f
WHERE EXISTS (SELECT p.id_fabricante FROM producto p
				WHERE f.id = p.id_fabricante);


-- Devuelve los nombres de los fabricantes que no tienen productos asociados. (Utilizando EXISTS o NOT EXISTS).
SELECT nombre FROM fabricante f
WHERE NOT EXISTS (SELECT id_fabricante FROM producto p
					WHERE f.id = p.id_fabricante);

/**
1.1.7.5 Subconsultas correlacionadas
Lista el nombre de cada fabricante con el nombre y el precio de su producto más caro.
**/
SELECT f.nombre AS 'Fabricante',
       p.nombre AS 'Producto', 
	   p.precio AS 'Precio Mayor' 
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE p.precio = (SELECT MAX(p.precio) FROM producto p 
					WHERE p.id_fabricante = f.id);

-- Devuelve un listado de todos los productos que tienen un precio mayor o igual a la media de todos los productos de su mismo fabricante.
SELECT f.nombre AS 'Fabricante',
	   p.nombre AS 'Producto',
       p.precio AS 'Precio_Mayor_a_la_Media'
FROM producto p
INNER JOIN fabricante f ON p.id_Fabricante = f.id
WHERE  p.precio >= (SELECT AVG(p.precio) FROM producto p 
					 WHERE p.id_fabricante = f.id);

-- Lista el nombre del producto más caro del fabricante Lenovo.
SELECT p.nombre AS 'Nombre Producto',
	   p.precio AS 'Mayor Precio', 
       f.nombre AS 'Fabricante' 
	FROM producto p
INNER JOIN fabricante f ON p.id_fabricante = f.id
WHERE f.nombre = 'Lenovo' AND p.precio = (SELECT MAX(p.precio) FROM producto p
											WHERE p.id_Fabricante = f.id);


/**
1.1.8 Subconsultas (En la cláusula HAVING)
Devuelve un listado con todos los nombres de los fabricantes que tienen el mismo número de productos que el fabricante Lenovo.
**/
SELECT f.nombre AS 'Nombres Fabricantes'
  FROM producto p 
INNER JOIN fabricante f ON p.id_fabricante = f.id
GROUP BY f.nombre 
HAVING COUNT(p.id) = (SELECT COUNT(p2.id) FROM producto p2, fabricante f2 
						WHERE p2.id_fabricante = f2.id AND f2.nombre = 'Lenovo');






