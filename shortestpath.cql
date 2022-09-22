// find one to four nodes path to Course
MATCH p=(:Student {name :"Jonathan"})-[:ENROLLED_IN*1..4]-(:Course) RETURN length(p)

// find shortest path to Course
MATCH p=shortestPath((s:Student {name :"Jonathan"})-[:ENROLLED_IN*1..4]-(c:Course)) RETURN length(p)
