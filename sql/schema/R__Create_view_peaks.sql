CREATE OR REPLACE VIEW peaks AS (
    WITH mm AS (
        SELECT min(production) AS _min, max(production) AS _max
        FROM measurements
        WHERE production <> 0.0
    )
    SELECT production AS 'Power (W)',
           list(measured_on) AS 'Measured on'
    FROM mm JOIN measurements ON (production = mm._min OR production = mm._max)
    GROUP BY production
);