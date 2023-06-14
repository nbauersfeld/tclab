
tstart = -90d

data = from(bucket: "factory2")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "DS_SS23_TrayStates_B"))

minTime = data
|> lowestMin(column: "_time", n:1)
|> keep(columns: ["_field", "_time", "_measurement"])
|> set(key: "_field", value: "minimum")

maxTime = data
|> highestMax(column: "_time", n:1)
|> keep(columns: ["_field", "_time", "_measurement"])
|> set(key: "_field", value: "maximum")

result = union(tables: [minTime,maxTime])
|> pivot(columnKey: ["_field"], rowKey: ["_measurement"], valueColumn: "_time")

result
|> map(fn: (r) => ({r with "delay": (uint(v: r.maximum) - uint(v: r.minimum)) / uint(v: 1000000000) }))
|> yield()
