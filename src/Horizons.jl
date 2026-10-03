#julia packages i will use
using EphemerisSources
using GLMakie
using Dates
using HorizonsAPI

#structs
#mutable struct Body
   # name :: string

  #  x :: Float64
 #   y :: Float64
 #   z :: Float64
#end

earth_data = fetch_vectors(399; format="text")
println(earth_data)