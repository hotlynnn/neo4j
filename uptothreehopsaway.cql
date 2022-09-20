// return an indirect relationship between two nodes through other nodes
MATCH p=(a :Student)--()-->(b :Instructor) RETURN p // two connecting lines between each intermediate node
MATCH p=(a :Student)--()--()-->(b :Instructor) RETURN p // two connecting lines between each intermediate node


// get three node paths with relationships
MATCH p=(a :Student)-[*3]->(b :Instructor) RETURN p // one line between connecting line and relationship

// get three node paths without relationships
MATCH p=(a :Student)-[*3]-(b :Instructor) RETURN p

