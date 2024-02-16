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