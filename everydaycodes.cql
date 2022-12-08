// multiple relationships in one query
MATCH (n)-[r:DIRECTED|ACTED_IN]-(p)
RETURN n,p

// return shortest two paths with duplicates
MATCH (n: Person {name: 'Oliver Platt'})-[r*2]-(nearest)
RETURN nearest

// return shortest two paths without duplicates
MATCH (n: Person {name: 'Oliver Platt'})-[r*2]-(nearest)
RETURN DISTINCT nearest

// find zeroth to secondth shortest path to Oliver
MATCH (n: Person {name: 'Oliver Platt'})-[*0..2]-(nearest)
RETURN nearest

// outer join on the Person node
MATCH (n: Person)
OPTIONAL MATCH (n)<-[f: FOLLOWS]-(b: Person)
OPTIONAL MATCH (n)-[:DIRECTED]->(m: Movie)
RETURN n.name, b.name, m.title

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

// character search for Lilly Wachowski
MATCH (p: Person)
WHERE p.name =~ "Li[sl]*y.*"
RETURN p

// search for Keanu Reaves or Kofi Okyere
MATCH (p: Person)
WHERE p.name =~ "K(ea|o).*"
RETURN p
-------------------------------------------------------------------
// search for names starting with vowels and order by names
MATCH (p: Person)
WHERE p.name =~ '[AEIOU].*'
RETURN p
ORDER BY p.name

********************************************************
// search for names starting with frist five letters of the alphabet(both upper and lower cases) and order by names
MATCH (p: Person)
WHERE p.name =~ '([A-E]|[a-e]).*'
RETURN p
ORDER BY p.name
//OR
MATCH (p: Person)
WHERE p.name =~ '(?i)[a-e].*'
RETURN p
ORDER BY p.name
--------------------------------------------------------------------
// predicates, and & or operators
MATCH (p: Person)
WHERE ALL(age in p.born WHERE age >= 1960 AND age < 1963)
AND NONE(age in p.born WHERE age = 1961)
RETURN p

// skip the first two results and print out the subsequent four results
MATCH (p: Person)
WHERE SINGLE(age in p.born WHERE age IN [1860, 1961])
RETURN p.name
SKIP 2 LIMIT 4


