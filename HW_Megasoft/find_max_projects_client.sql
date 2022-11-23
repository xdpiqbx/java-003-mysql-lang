SELECT client_id, COUNT(id) AS project_count
    FROM project
    GROUP BY client_id
-- in process