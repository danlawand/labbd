-----------------------------------
-- Exemplo extraído de: https://www.postgresqltutorial.com/postgresql-json/
-----------------------------------

CREATE TABLE orders (
id serial NOT NULL PRIMARY KEY,
info json NOT NULL
);

INSERT INTO orders (info)
VALUES('{ "customer": "Lily Bush", "items": {"product": "Diaper","qty": 24}}'),
      ('{ "customer": "Josh William", "items": {"product": "Toy Car","qty": 1}}'),
      ('{ "customer": "Mary Clark", "items": {"product": "Toy Train","qty": 2}}');

-----------------------------------
SELECT info FROM orders;

-----------------------------------
-- PostgreSQL provides two native operators -> and ->> to help you query JSON data.
-- The operator -> returns JSON object field by key.
-- The operator ->> returns JSON object field by text.


SELECT info -> 'customer' AS customer
FROM orders;

SELECT info ->> 'customer' AS customer
FROM orders;

-----------------------------------
SELECT info ->> 'customer' AS customer
FROM orders
WHERE info -> 'items' ->> 'product' = 'Diaper';

-----------------------------------
SELECT info ->> 'customer' AS customer,
	info -> 'items' ->> 'product' AS product
FROM orders
WHERE CAST ( info -> 'items' ->> 'qty' AS INTEGER) = 2

-----------------------------------
SELECT 
   MIN (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   MAX (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   SUM (CAST (info -> 'items' ->> 'qty' AS INTEGER)),
   AVG (CAST (info -> 'items' ->> 'qty' AS INTEGER))
FROM orders;
