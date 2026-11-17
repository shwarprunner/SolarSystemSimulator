using EphemerisSources
using GLMakie
using Dates
using DuckDB
using DBInterface

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
now_time = now()

#taking user input for date
println("1: current date | 2: set date")
date_type_choice = parse(Int64, readline())
if date_type_choice == 2
   println("chose date within range: 02/02/1499 | 02/02/2523")

   println("day")
   day = parse(Int64, readline())
   println("month")
   month = parse(Int64, readline())
   println("year")
   year = parse(Int64, readline())
   println("hour")
   hour = parse(Int64, readline())
else
end
#defining date time
if date_type_choice == 1
   start_time = DateTime(now_time)
else
   start_time = DateTime(year, month, day, hour, 0, 0)
end

#converting to julian time
julian_date = datetime2julian(start_time)

#masses in solar masses of each planet's systems, meaning them and their moons.
const sun_mass_loss = 2.8657616892911014e-21
const initial_sun_mass = 1.0
const sun_mass = 1.0
#const sun_mass = Ref(initial_sun_mass)
const mercury_mass = 1.6601208255e-7
const venus_mass = 2.4478382878e-6
const earth_mass = 3.0404326489e-6
const mars_mass = 3.2271560829e-7
const jupiter_mass = 9.5479190994e-4
const saturn_mass = 2.8588567002e-4
const uranus_mass = 4.3662496132e-5
const neptune_mass = 5.1513837727e-5

#accounting for solar mass loss, when i add dt for time control i will implement this loop
#while true
#   sun_mass[] = sun_mass[] - sun_mass_loss
#end

println("1: database | 2: live call")
mode = parse(Int64, readline())
#option for database vs live call
if mode == 2
   #SUN
   #ephemeris fetch data
   sun_data = ephemeris(10, start_time)

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
   mercury_data = ephemeris(1, start_time)

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
   venus_data = ephemeris(2, start_time)

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
   earth_data = ephemeris(3, start_time)

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
   mars_data = ephemeris(4, start_time)

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
else
      db = DBInterface.connect(
      DuckDB.DB,
      "data/solar_system.duckdb"
   )

   #making julian time correspond to that in the database
   closest_result = DBInterface.execute(
      db,
      """
      SELECT epoch_julian
      FROM nasa_states
      WHERE body_id = 1
      ORDER BY ABS(epoch_julian - ?)
      LIMIT 1
      """,
      (julian_date,)
   )
   julian_date = first(closest_result).epoch_julian

   #defining the bodies
   sunDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 1
      """,
      (julian_date,)
   )

   for row in sunDB
      global sun = Body(
         row.body_id,
         0.0046504673,

         "sun",
         "Sun",

         sun_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   mercuryDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 2
      """,
      (julian_date,)
   )
   for row in mercuryDB
      global mercury = Body(
         row.body_id,
         1.6306382e-5,

         "mercury",
         "Mercury",

         mercury_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   venusDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 3
      """,
      (julian_date,)
   )

   for row in venusDB
      global venus = Body(
         row.body_id,
         4.0453784e-5,

         "venus",
         "Venus",

         venus_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   earthDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 4
      """,
      (julian_date,)
   )

   for row in earthDB
      global earth = Body(
         row.body_id,
         4.2587561e-5,

         "earth",
         "Earth",

         earth_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   marsDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 5
      """,
      (julian_date,)
   )

   for row in marsDB
      global mars = Body(
         row.body_id,
         2.2657408e-5,

         "mars",
         "Mars",

         mars_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   jupiterDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 6
      """,
      (julian_date,)
   )

   for row in jupiterDB
      global jupiter = Body(
         row.body_id,
         0.00046732617,

         "jupiter",
         "Jupiter",

         jupiter_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   saturnDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 7
      """,
      (julian_date,)
   )

   for row in saturnDB
      global saturn = Body(
         row.body_id,
         0.00038925688,

         "saturn",
         "Saturn",

         saturn_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   uranusDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 8
      """,
      (julian_date,)
   )

   for row in uranusDB
      global uranus = Body(
         row.body_id,
         0.00016953450,

         "uranus",
         "Uranus",

         uranus_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end

   neptuneDB = DBInterface.execute(
      db,
      """
      SELECT *
      FROM nasa_states
      WHERE epoch_julian = ? AND body_id = 9
      """,
      (julian_date,)
   )

   for row in neptuneDB
      global neptune = Body(
         row.body_id,
         0.00016458790,

         "neptune",
         "Neptune",

         neptune_mass,

         row.x,
         row.y,
         row.z,

         row.vx,
         row.vy,
         row.vz
      )
   end
   DBInterface.close(db)
end


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

#Gravity
const G = 2.959122082855911e-4

function calculate_gravity(bodies)

    for body in bodies

        total_ax = 0.0
        total_ay = 0.0
        total_az = 0.0
        for accelerator_body in bodies

         if body === accelerator_body
            continue
         end

         #calculation

         dx = accelerator_body.x - body.x
         dy = accelerator_body.y - body.y
         dz = accelerator_body.z - body.z

         r_squared = dx^2 + dy^2 + dz^2
         r = sqrt(r_squared)

         az = G * accelerator_body.m * dz / r^3
         ax = G * accelerator_body.m * dx / r^3
         ay = G * accelerator_body.m * dy / r^3

         total_ax += ax
         total_ay += ay
         total_az += az

         println(
         accelerator_body.name,
          ": ",
          ax, ", ",
          ay, ", ",
          az
         )
      end
   end
end

calculate_gravity(bodies)