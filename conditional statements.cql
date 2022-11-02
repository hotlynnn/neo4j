
// creating a new column using conditions
MATCH (c :Course)<-[r :ENROLLED_IN]-(s :Student)
OPTIONAL MATCH (:Provider)-[pb:PUBLISHED]->(c)
RETURN 
CASE pb.year % 2
WHEN 0 THEN 'Great'
WHEN 1 THEN 'Hmm'
WHEN 2 THEN 'Hungry'
ELSE 'Unkwown'
END AS Parity, 
avg(s.age) as average_age