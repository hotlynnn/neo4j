// match characters before and after a specific letter
MATCH (n :Course) where n.title =~ '.*A.*' RETURN n

