#making a struct with id
mutable struct Name
    id :: Int64
    name :: Symbol
end

#defining id
id = 1

#making an array to automate assigning structs
objects = [
    Name(1, :sun),
    Name(2, :mercury),
    Name(3, :venus),
    Name(4, :earth),
    Name(5, :mars),
    Name(6, :jupiter),
    Name(7, :saturn),
    Name(8, :uranus),
    Name(9, :neptune)
]

for object in objects
    println(object.id)
    println(object.name)
end