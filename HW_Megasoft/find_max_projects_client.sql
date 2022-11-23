SELECT name, COUNT(project.client_id) AS project_count
    FROM client INNER JOIN project
        ON client.id = project.client_id
        GROUP BY name
        HAVING COUNT(project.client_id) IN (
            SELECT
                COUNT(client_id),
                FROM project
                GROUP BY client_id
                LIMIT 1
        )