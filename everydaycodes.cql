// multiple relationships in one query
MATCH (n)-[r:DIRECTED|ACTED_IN]-(p)
RETURN n,p

// return shortest two paths with duplicates
MATCH (n: Person {name: 'Oliver Platt'})-[r*2]-(nearest)
RETURN nearest

// return shortest two paths withOUT duplicates
MATCH (n: Person {name: 'Oliver Platt'})-[r*2]-(nearest)
RETURN DISTINCT nearest

// find zeroth secondth shortest path to Oliver
MATCH (n: Person {name: 'Oliver Platt'})-[*0..2]-(nearest)
RETURN nearest

// outer join on the Person node
MATCH (n: Person)
OPTIONAL MATCH (n)<-[f: FOLLOWS]-(b: Person)
OPTIONAL MATCH (n)-[:DIRECTED]->(m: Movie)
RETURN n.name, b.name, m.title

// character search
MATCH (n:Person)
WHERE n.name =~ $regex
RETURN n.name

// return similar shortest path  between two nodes
MATCH (m: Movie {title: "The Green Mile"}), (n: Movie {title: "Apollo 13"})
RETURN allshortestpaths((m)-[*]-(n))

// return the shortest path  between two nodes
MATCH (m: Movie {title: "The Green Mile"}), (n: Movie {title: "Apollo 13"})
RETURN shortestpath((m)-[*]-(n))

// shortest path between nodes identified with IDs
MATCH (a) WHERE ID(a) = 130
MATCH (b) WHERE ID(b) = 144
MATCH (c) WHERE ID(c) = 157
RETURN shortestpath((a)-[*]-(c))