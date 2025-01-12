CREATE OR REPLACE VIEW v_average_production_per_month_and_hour AS (
    WITH production_per_month_and_hour AS (
        SELECT any_value(date_part('month', measured_on))AS month,
               any_value(date_part('hour', measured_on)) AS hour,
               avg(production) / 1000                    AS production
          FROM measurements
         GROUP BY date_trunc('hour', measured_on)
         ORDER BY Hour
    )
    PIVOT production_per_month_and_hour
    ON month IN (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)
    USING avg(production)
    GROUP BY hour
    ORDER BY hour
);
