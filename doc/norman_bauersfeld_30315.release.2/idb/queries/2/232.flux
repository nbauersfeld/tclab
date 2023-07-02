
tstart = -90d

data = from(bucket: "factory2")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "DS_SS23_TrayStates_B"))
|> keep(columns: ["Assembly","Signal","topic"])
|> distinct(column: "topic")
|> group(columns: ["Assembly"])
|> count(column: "Signal")

dataSum = data
|> keep(columns: ["Signal"])
|> sum(column: "Signal")
|> set(key: "Assembly", value: "_all_")

union(tables: [dataSum, data])
|> sort(columns: ["Signal"])
|> rename(columns: {"Signal":"count","Assembly":"assembly"})
|> yield()