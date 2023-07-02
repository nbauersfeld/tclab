// given by 225a
tstart = -90d
tevent = 2023-04-11T11:40:00Z

tBefore = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r._time < tevent)))
|> keep(columns: ["_value","_measurement"])
|> mean(column: "_value")
|> set(key: "_field", value: "before")

tPast = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r._time >= tevent)))
|> keep(columns: ["_value","_measurement"])
|> mean(column: "_value")
|> set(key: "_field", value: "past")

union(tables: [tBefore,tPast])
|> pivot(columnKey: ["_field"], rowKey: ["_measurement"], valueColumn: "_value")
