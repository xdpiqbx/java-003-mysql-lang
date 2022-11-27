SELECT
    CONCAT ('Project ', project_id) AS name,
        DATEDIFF(
                MONTH,
                CAST (start_date AS DATE),
                CAST(finish_date AS DATE)
            ) *
    SUM(salary) AS price
    FROM project_worker
    INNER JOIN project ON project_worker.project_id = project.id
    INNER JOIN worker ON project_worker.worker_id = worker.id
GROUP BY project_id
ORDER BY project_id