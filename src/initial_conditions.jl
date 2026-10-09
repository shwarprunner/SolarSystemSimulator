#julia packages i will use
using EphemerisSources
using GLMakie
using Dates

#SUN
#ephemeris fetch data
sun_data = ephemeris("sun", start_time)

#defining sun
sun = Body(
   "Sun",

   initial_sun_mass,

   sun_data.x[1],
   sun_data.y[1],
   sun_data.z[1],

   sun_data.ẋ[1],
   sun_data.ẏ[1],
   sun_data.ż[1]
)

#MERCURY
#ephemeris fetch data
mercury_data = ephemeris("mercury", start_time)

#defining mercury
mercury = Body(
   "Mercury",

   mercury_mass,

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

#defining venus
venus = Body(
   "Venus",

   venus_mass,

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

#defining earth
earth = Body(
   "Earth",

   earth_mass,

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

#defining mars
mars = Body(
   "Mars",

   mars_mass,

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

#defining jupiter
jupiter = Body(
   "Jupiter",

   jupiter_mass,
   
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

#defining saturn
saturn = Body(
   "Saturn",

   saturn_mass,

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

#defining uranus
uranus = Body(
   "Uranus",

   uranus_mass,

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

#defining neptune
neptune = Body(
   "Neptune",

   neptune_mass,

   neptune_data.x[1],
   neptune_data.y[1],
   neptune_data.z[1],

   neptune_data.ẋ[1],
   neptune_data.ẏ[1],
   neptune_data.ż[1]
)

#combining bodies into array
bodies = [
   sun,
   mercury,
   venus,
   earth,
   mars,
   jupiter,
   saturn,
   uranus,
   neptune
]

for body in bodies
   println(body.name)

   println(body.m)
   
   println(body.x)
   println(body.y)
   println(body.z)
   
   println(body.vx)
   println(body.vy)
   println(body.vz)
end