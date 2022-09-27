// get only one match
MATCH (n :Course) 
WHERE SINGLE(tag IN n.tags WHERE tag IN ['java', 'build tool'])
RETURN n

// get any match
MATCH (n :Course) 
WHERE ANY(tag IN n.tags WHERE tag IN ['java', 'programming language'])
RETURN n

// get all matches
MATCH (n :Course) 
WHERE ALL(tag IN n.tags WHERE tag IN ['python', 'build tool'])
RETURN n

// get none of the matches
MATCH (n :Course) 
WHERE NONE(tag IN n.tags WHERE tag IN ['neo4j', 'java'])
RETURN n