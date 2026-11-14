using EphemerisSources
using Dates
using DuckDB
using DBInterface

#test range
start_time = DateTime(2011, 2, 2, 0, 0, 0)
stop_time = DateTime(2021, 2, 2, 0, 0, 0)

data = ephemeris("earth", start_time, stop_time, Hour(1); units = "AU-D")

println(length(data.t))
println(data.t[1])
println(data.cal[1])

println(data.x[1])
println(data.y[1])
println(data.z[1])

println(data.ẋ[1])
println(data.ẏ[1])
println(data.ż[1])

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

    DuckDB.append(appender, 4)

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

println("finished")