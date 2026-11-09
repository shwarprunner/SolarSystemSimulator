const G = 2.959122082855911e-4

function jupiter_gravity_on_earth(earth::Body, jupiter::Body)

    #Jupiter from earth distance along x-axis

    dx = jupiter.x - earth.x


    # Same thing along the y-axis

    dy = jupiter.y - earth.y


    # Same thing along the z-axis

    dz = jupiter.z - earth.z
    
    # (dx, dy, dz) is the 3d direction vector
    
    # Disatance between eath and jupiter
    r_squared = dx^2 + dy^2 + dz^2

    r = sqrt(r_squared)

    # Earth accelaration towars jupiter

    # x axis direction
    ax = G * jupiter.m * dx / r^3


    # Same calculation for the y direction.

    ay = G * jupiter.m * dy / r^3


    # Same calculation for the z direction.

    az = G * jupiter.m * dz / r^3

    #return results

    return ax, ay, az
end

#test

earth_ax_from_jupiter,
earth_ay_from_jupiter,
earth_az_from_jupiter = jupiter_gravity_on_earth(earth, jupiter)


# print

println("Jupiter's gravitational acceleration on Earth:")

println("ax = ", earth_ax_from_jupiter, " AU/day²")
println("ay = ", earth_ay_from_jupiter, " AU/day²")
println("az = ", earth_az_from_jupiter, " AU/day²")