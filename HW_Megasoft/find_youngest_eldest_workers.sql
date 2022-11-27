SELECT 'YOUNGEST' AS TYPE, name, CAST (birthday AS DATE) AS birthday
    FROM worker
    WHERE CAST (birthday AS DATE) IN (
        SELECT
            MAX(CAST (birthday AS DATE))
        FROM worker
    )
UNION
SELECT 'ELDEST' AS TYPE, name, CAST (birthday AS DATE) AS birthday
    FROM worker
    WHERE CAST (birthday AS DATE) IN (
        SELECT
            MIN(CAST (birthday AS DATE))
        FROM worker
    )
ORDER BY birthday DESC
