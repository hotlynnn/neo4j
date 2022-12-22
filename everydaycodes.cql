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

// sort in descending after replacing all null values of p.year by -5000
MATCH (b:Book)
OPTIONAL MATCH (b) -[p:PublishedBy]-> (c)
RETURN b.title, p.year
ORDER BY COALESCE(p.year, -5000) DESC
LIMIT 5

// aggreagation
1. count    = COUNT()
2. sum      = SUM()
3. average  = AVG()
4. maximum  = MAX()
5. minimum  = MIN()
6. std      = STDEV()
7. createlist = COLLECT()

// get years of all persons and place in a list
MATCH (m: Movie {title: "A Few Good Men"})<--(p)
RETURN COLLECT(p.born)

// CASE WHEN for different conditions and different outputs - Type 1
MATCH (b:Book)<-[r:Votes]-(:User)
OPTIONAL MATCH (b) -[p:PublishedBy]-> (c)
RETURN
CASE 
    WHEN p.year >= 2010 THEN 'Recent'
    WHEN p.year >= 2005 and p.year < 2010 THEN 'Earlier' 
    ELSE 'Old' 
END as category, 
AVG(r.score)

// CASE WHEN for one condition and different outputs - Type 2
MATCH (b:Book)<-[r:Votes]-(:User)
OPTIONAL MATCH (b) -[p:PublishedBy]-> (c)
RETURN
CASE COALESCE(p.year % 2, -1)
    WHEN 0 THEN 'Even'
    WHEN 1 THEN 'Odd'
ELSE 'Unknown' END as parity,
AVG(r.score)

// get highest score after setting condition of scores greater than 4 using WITH
MATCH (b:Book) <-[r:Votes]- (:User)
WITH b, AVG(r.score) as avgScore
WHERE avgScore >=4
RETURN b, avgScore
ORDER BY avgScore DESC

// Union and Union All
Union is the same as concatenation in Pandas
UNION removes duplicates and threfore it iss slower
UNION ALL keep duplicates

// set properties after creating new node or when the node already exists
MERGE (b:User {name: "Jack", surname: "Smith"})
ON CREATE SET b.place = "London"
ON MATCH SET b.age = 34

// remove node with multiple labels 
MERGE (b:User {name: "Jack", surname: "Smith"})
REMOVE b:Inactive:MustConfirmEmail

// remove properties
MERGE (b:User {name: "Jack", surname: "Smith"})
REMOVE b.age
OR
MERGE (b:User {name: "Jack", surname: "Smith"})
SET b.age = NULL

-- REMOVE and  SET are IDEMPOTENT

// delete specific nodes nodes from the database
-- you must delete existing relationships with other nodes before you can delete the node, else you will get an error
MATCH (c:User {name: "Jack", surname: "Smith"})
OPTIONAL MATCH (c)-[r]- ()
DELETE r, c

// delete the whole database
-- you must delete existing relationships with other nodes before you can delete the node, else you will get an error
MATCH (a)
OPTIONAL MATCH (a)-[r]- ()
DELETE r, a

// stages of writing CQL 
MATCH (a:User {name: "Jack", surname: "Roe"})   --Read
MERGE (b:User {name: "Jack", surname: "Smith"}) --Write
WITH a,b                                        --With can be used to replace Return to start Read and write again
MERGE (a) -[rn:Knows]-> (b)                     --Merge after With
RETURN a,rn,b                                   --Return
