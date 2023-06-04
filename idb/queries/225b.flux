
t1 = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r.Device == "xair") and (r._value != 0)))
|> min(column: "_time")
|> keep(columns: ["_time"])
|> set(key: "tag", value: "x")

t2 = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => ((r._measurement == "shellies")))
|> keep(columns: ["_value","_time","_measurement"])
|> set(key: "tag", value: "x")

tt = join(
tables: {t1: t1, t2: t2}, 
on: ["tag"]
)
|> keep(columns: ["_value","_time_t1","_time_t2","_measurement"])
|> rename(columns: {_time_t2: "_time", _time_t1: "_criteria"})

ttBefore = tt
|> filter(fn: (r) => ((r._time < r._criteria)))
|> mean()    
|> set(key: "_field", value: "before")

ttAfter = tt
|> filter(fn: (r) => ((r._time >= r._criteria)))
|> mean()
|> set(key: "_field", value: "past")

union(tables: [ttBefore,ttAfter])
|> pivot(columnKey: ["_field"], rowKey: ["_measurement"], valueColumn: "_value")
