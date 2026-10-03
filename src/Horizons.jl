#julia packages i will use
using EphemerisSources
using GLMakie
using Dates

#structs
#mutable struct Body
   # name :: string

  #  x :: Float64
 #   y :: Float64
 #   z :: Float64
#end

#Using HorizonsAPI
earth_data_HorizonsAPI = fetch_vectors(399; format="text")
println(earth_data_HorizonsAPI)

#Using ephemeris
earth_data_ephemeris = ephemeris("earth", now())
println(earth_data_ephemeris)