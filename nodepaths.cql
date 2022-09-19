// one node path
MATCH (a :Provider)<-[*1]-(b :Instructor) RETURN a,b

// two node paths(one and two paths)
MATCH (a :Course)<-[*1..2]-(b :Student) RETURN a,b
//MATCH (a :Course)<-[*1..3]-(b :Student) RETURN a,b