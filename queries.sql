SELECT COUNT(*) AS customers_count
FROM customers;
--запрос возвращает количество строк в таблице customers и присваивает псевдоним customers_count

SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    COUNT(s.sales_id) AS operations,
    ROUND(SUM(p.price * s.quantity), 0) AS income
FROM
    employees e
JOIN
    sales s ON e.employee_id = s.sales_person_id
JOIN
    products p ON s.product_id = p.product_id
GROUP BY
    e.employee_id
ORDER BY
    income DESC
LIMIT 10;
--запрос возвращает количество строк в таблице sales и суммарную выручку продавца, округленную до целого числа, заджойнили, сгруппировали и отсортировали.

SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    ROUND(AVG(p.price * s.quantity), 0) AS average_income
FROM
    employees e
JOIN
    sales s ON e.employee_id = s.sales_person_id
JOIN
    products p ON s.product_id = p.product_id
GROUP BY
    e.employee_id
HAVING
    AVG(p.price * s.quantity) < (SELECT AVG(p.price * s.quantity) FROM sales s JOIN products p ON s.product_id = p.product_id)
ORDER BY
    average_income;
--запрос возвращает среднюю выручку продавцов, округленную до целого числа, заджойнили, сгруппировали, добавили условия.

SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS name,
    TO_CHAR(s.sale_date, 'Day') AS weekday,
    ROUND(SUM(p.price * s.quantity)) AS income
FROM
    employees e
JOIN
    sales s ON e.employee_id = s.sales_person_id
JOIN
    products p ON s.product_id = p.product_id
GROUP BY
    e.employee_id, weekday
ORDER BY
    MIN(EXTRACT(DOW FROM s.sale_date)), -- Порядковый номер дня недели
    name;
-- Запрос возвращает день недели, выручку продавцов, округленную до целого числа,заджойнили таблицы, сгруппировали результаты, отсортировали результаты.

SELECT
    CASE
        WHEN age BETWEEN 16 AND 25 THEN '16-25'
        WHEN age BETWEEN 26 AND 40 THEN '26-40'
        ELSE '40+'
    END AS age_category,
    COUNT(*) AS count
FROM
    customers
GROUP BY
    age_category
ORDER BY
    age_category;
-- Запрос делит покупателей по возрастным категориям.

SELECT
    to_char(s.sale_date, 'YYYY-MM') AS date,
    COUNT(DISTINCT s.customer_id) AS total_customers,
    SUM(p.price * s.quantity) AS income
FROM
    sales s
JOIN
    products p ON s.product_id = p.product_id
GROUP BY
    date
ORDER BY
    date;
-- Запрос возвращает данные по количеству уникальных покупателей в месяц и выручке которую они принесли.

SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    s.sale_date AS sale_date,
    CONCAT(e.first_name, ' ', e.last_name) AS seller
FROM
    sales s
JOIN
    customers c ON s.customer_id = c.customer_id
JOIN
    employees e ON s.sales_person_id = e.employee_id
JOIN
    products p ON s.product_id = p.product_id
WHERE
    p.price = 0
ORDER BY
    c.customer_id;
-- Запрос возвращает данные о покупателях, которые совершили покупку во время акции.