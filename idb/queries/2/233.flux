
tstart = -90d

data = from(bucket: "factory2")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "DS_SS23_TrayStates_B" and r.Signal == "KameraP" and r.Assembly == "Packaging" and r._value != 0))
|> keep(columns: ["_value","_time"])
|> group(columns: ["_value"])
|> map(fn: (r) => ({ r with "_count": r._value }))
|> count(column: "_count")
|> rename(columns: {"_value": "_lorry"})

data
|> yield()