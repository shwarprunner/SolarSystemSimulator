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

#test range
start_time = DateTime(2011, 2, 2, 0, 0, 0)
stop_time = DateTime(2021, 2, 2, 0, 0, 0)

function data_import(objects)
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

        println("finished with", " ", body.name)
    end
end

data_import(objects)

#not typo