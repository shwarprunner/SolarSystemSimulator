

#structs
mutable struct Body
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
const initial_sun_mass = 1.0
const mercury_mass = 1.6601e-7
const venus_mass = 2.4478e-6
const earth_mass = 3.0035e-6
const mars_mass = 3.2272e-7
const jupiter_mass = 9.5479e-4
const saturn_mass = 2.8589e-4
const uranus_mass = 4.3662e-5
const neptune_mass = 5.1514e-5