#julia packages i will use
using EphemerisSources
using GLMakie
using Dates

#structs
mutable struct Body
     name :: String

    #position in AU
    x :: Float64
    y :: Float64
    z :: Float64

    #velocity in AU/day
    vx :: Float64
    vy :: Float64
    vz :: Float64
end

#setting a fixed start time
start_time = DateTime(2026, 10, 5, 0, 0, 0)

#MERCURY
#ephemeris fetch data
mercury_data = ephemeris("mercury", start_time)

#defining mercury
mercury = Body(
   "Mercury",
   mercury_data.x[1],
   mercury_data.y[1],
   mercury_data.z[1],

   mercury_data.ẋ[1],
   mercury_data.ẏ[1],
   mercury_data.ż[1]
)

#VENUS
#ephemeris fetch data
venus_data = ephemeris("venus", start_time)
println(venus_data)

#defining venus
venus = Body(
   "Venus",
   venus_data.x[1],
   venus_data.y[1],
   venus_data.z[1],

   venus_data.ẋ[1],
   venus_data.ẏ[1],
   venus_data.ż[1]
)

#EARTH
#ephemeris fetch data
earth_data = ephemeris("earth", start_time)
println(earth_data)

#defining earth
earth = Body(
   "Earth",
   earth_data.x[1],
   earth_data.y[1],
   earth_data.z[1],

   earth_data.ẋ[1],
   earth_data.ẏ[1],
   earth_data.ż[1]
)

#printing set values for earth
println(earth_data.x[1])
println(earth_data.ẋ[1])

#MARS
#ephemeris fetch data
mars_data = ephemeris("mars", start_time)
println(mars_data)

#defining mars
mars = Body(
   mars_data.x[1],
   mars_data.y[1],
   mars_data.z[1],

   mars_data.ẋ[1],
   mars_data.ẏ[1],
   mars_data.ż[1]
)