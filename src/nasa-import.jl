using EphemerisSources
using Dates
using DuckDB
using DBInterface

#making a struct with id
mutable struct Name
    id :: Int64
    name :: Symbol
end

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

#function that runs inside loop
function data_import(objects, start_time, stop_time, start_year, stop_year)
    for body in objects
        data = ephemeris(body.name, start_time, stop_time, Hour(1); units = "AU-D")

        db = DBInterface.connect(DuckDB.DB, "data/solar_system.duckdb")

        DBInterface.execute(db, """     
            CREATE TEMP TABLE import_states (
                body_id INTEGER,
                epoch_julian DOUBLE,
                epoch_display VARCHAR,
                x DOUBLE,
                y DOUBLE,
                z DOUBLE,
                vx DOUBLE,
                vy DOUBLE,
                vz DOUBLE
        );
            """)
        appender = DuckDB.Appender(db, "import_states")

        for i in eachindex(data.t)
        
            DuckDB.append(appender, body.id)
        
            DuckDB.append(appender, data.t[i])
            DuckDB.append(appender, data.cal[i])
        
            DuckDB.append(appender, data.x[i])
            DuckDB.append(appender, data.y[i])
            DuckDB.append(appender, data.z[i])

            DuckDB.append(appender, data.ẋ[i])
            DuckDB.append(appender, data.ẏ[i])
            DuckDB.append(appender, data.ż[i])

            DuckDB.end_row(appender)
        end
        DuckDB.close(appender)

        DBInterface.execute(db, """
            INSERT INTO nasa_states
            SELECT *
            FROM import_states
            ON CONFLICT (body_id, epoch_julian) DO NOTHING;
        """)
        DBInterface.close(db)

        println("finished with", " ", body.name, "for", " ", start_year, " ", "to", " ", stop_year)
    end
end



#function for the loop
function run_import(objects)

    #start year
    start_year = 1499
    stop_year = start_year

    #loop that automates the process, 64 times in chunks of 16 years
    while start_year < 2523

        #test range
        start_time = DateTime(start_year, 2, 2, 0, 0, 0)
        stop_year = min(start_year + 16, 2523)
        stop_time = DateTime(stop_year, 2, 2, 0, 0, 0)

        data_import(objects, start_time, stop_time, start_year, stop_year)

        start_year = stop_year
    end

    println("done")
end

run_import(objects)