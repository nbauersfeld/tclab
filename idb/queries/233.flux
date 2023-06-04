
data = from(bucket: "factory")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "AFB" and r.Signal == "KameraP" and r.Assembly == "Packaging" and r._value != 0))
|> keep(columns: ["_value","_time"])
|> group(columns: ["_value"])
|> map(fn: (r) => ({ r with "_count": r._value }))
|> count(column: "_count")
|> rename(columns: {"_value": "_lorry"})

data
|> yield()