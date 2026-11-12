using EphemerisSources
using GLMakie
using Dates

#structs
mutable struct Body
   id :: Int64

   #radius in AU
   radius :: Float64

   #name called by ephemeris
   ephemeris_name :: String

   #name of object
   name :: String

   #mass in solar masses
   m :: Float64

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
start_time = now()
#start_time = DateTime(2026, 10, 5, 0, 0, 0)

#masses in solar masses
const sun_mass_loss = 2.8657616892911014e-21
const initial_sun_mass = 1.0
const sun_mass = Ref(initial_sun_mass)
const mercury_mass = 1.6601e-7
const venus_mass = 2.4478e-6
const earth_mass = 3.0035e-6
const mars_mass = 3.2272e-7
const jupiter_mass = 9.5479e-4
const saturn_mass = 2.8589e-4
const uranus_mass = 4.3662e-5
const neptune_mass = 5.1514e-5

#accounting for solar mass loss, when i add dt for time control i will implement this loop
#while true
#   sun_mass[] = sun_mass[] - sun_mass_loss
#end

#SUN
#ephemeris fetch data
sun_data = ephemeris("sun", start_time)

#defining sun
sun = Body(
   1,
   0.0046504673,

   "sun",
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
   2,
   1.6306382e-5,

   "mercury",
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
   3,
   4.0453784e-5,

   "venus",
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
   4,
   4.2587561e-5,

   "earth",
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
   5,
   2.2657408e-5,

   "mars",
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
   6,
   0.00046732617,

   "jupiter",
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
   7,
   0.00038925688,

   "saturn",
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
   8,
   0.00016953450,

   "uranus",
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
   9,
   0.00016458790,

   "neptune",
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

function write_sql_for_database(bodies)

   for body in bodies
      println("INSERT INTO bodies (")
      println("   ", "body_id", ",")
      println("   ", "name", ",")
      println("  ", "ephemeris_name", ",")
      println("  ", "mass_solar", ",")
      println("  ", "radius_au", ",")
      println(")")
      println("VALUES (")
      println("  ", body.id, ",")
      println("  ", "'", body.name, "'", ",")
      println("  ", "'", body.ephemeris_name, "'", ",")
      println("  ", body.id, "," )
      println("  ", body.radius, ",")
      println(");")
      println()
   end
end

write_sql_for_database(bodies)