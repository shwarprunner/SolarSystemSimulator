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
#println(mercury_data, "1")

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
#println(venus_data, "2")

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
#println(earth_data, "3")

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

#MARS
#ephemeris fetch data
mars_data = ephemeris("mars", start_time)
#println(mars_data, "4")

#defining mars
mars = Body(
   "Mars",
   mars_data.x[1],
   mars_data.y[1],
   mars_data.z[1],

   mars_data.ẋ[1],
   mars_data.ẏ[1],
   mars_data.ż[1]
)

#JUPITER
#ephemeris fetch data
jupiter_data = ephemeris("jupiter", start_time)
#println(jupiter_data, "5")

#defining jupiter
jupiter = Body(
   "Jupiter",
   jupiter_data.x[1],
   jupiter_data.y[1],
   jupiter_data.z[1],

   jupiter_data.ẋ[1],
   jupiter_data.ẏ[1],
   jupiter_data.ż[1]
)

#SATURN
#ephemeris fetch data
saturn_data = ephemeris("saturn", start_time)
#println(saturn_data, "6")

#defining saturn
saturn = Body(
   "Saturn",
   saturn_data.x[1],
   saturn_data.y[1],
   saturn_data.z[1],

   saturn_data.ẋ[1],
   saturn_data.ẏ[1],
   saturn_data.ż[1]
)

#URANUS
#ephemeris fetch data
uranus_data = ephemeris("uranus", start_time)
#println(uranus_data, "7")

#defining uranus
uranus = Body(
   "Uranus",
   uranus_data.x[1],
   uranus_data.y[1],
   uranus_data.z[1],

   uranus_data.ẋ[1],
   uranus_data.ẏ[1],
   uranus_data.ż[1]
)

#NEPTUNE
#ephemeris fetch data
neptune_data = ephemeris("neptune", start_time)
#println(neptune_data, "8")

#defining neptune
neptune = Body(
   "Neptune",
   neptune_data.x[1],
   neptune_data.y[1],
   neptune_data.z[1],

   neptune_data.ẋ[1],
   neptune_data.ẏ[1],
   neptune_data.ż[1]
)