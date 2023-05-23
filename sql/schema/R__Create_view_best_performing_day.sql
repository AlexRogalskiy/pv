CREATE OR REPLACE VIEW best_performing_day AS (
    WITH top_1 AS (
        SELECT date_trunc('day', measured_on) AS value,
               rank() OVER (ORDER BY round(sum(production) / 4 / 1000, 2) DESC)
        FROM measurements
        GROUP BY value LIMIT 1
    )
    SELECT measured_on, production
    FROM measurements
    WHERE date_trunc('day', measured_on) = '2023-05-23'
    ORDER BY measured_on ASC
);