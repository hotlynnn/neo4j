// query first 3 rows results and order by a factor
MATCH (n :Student) RETURN n.location, n.name as name
ORDER BY COALESCE(name, 'NOT STATED') DESC // replaces null values with 'NOT STATED'
LIMIT 3