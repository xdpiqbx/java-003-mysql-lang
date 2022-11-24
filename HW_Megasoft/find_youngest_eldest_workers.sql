SELECT 'example' as TempField, name, birthday
    FROM worker
    WHERE CAST (birthday AS DATE) IN (
        SELECT
            MAX(CAST (birthday AS DATE))
        FROM worker
        UNION
        SELECT
            MIN(CAST (birthday AS DATE))
        FROM worker
    )


-- CAST (birthday AS DATE)