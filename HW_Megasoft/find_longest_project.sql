SELECT
    CONCAT ('Project ', id) AS name,
    DATEDIFF(
        MONTH,
        CAST (start_date AS DATE),
        CAST(finish_date AS DATE)
    ) AS month_count
    FROM project
        WHERE DATEDIFF(
                  MONTH,
                  CAST (start_date AS DATE),
                  CAST(finish_date AS DATE)
              ) = (
                  SELECT
                      DATEDIFF(
                          MONTH,
                          CAST (start_date AS DATE),
                          CAST(finish_date AS DATE)
                      ) AS month_count
                  FROM project
                  ORDER BY month_count DESC
                  LIMIT 1
              )
