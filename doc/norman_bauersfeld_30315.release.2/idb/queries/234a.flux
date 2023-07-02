
tstart = -90d

// main data set by lories and their circle delays at KameraP/Packaging
data = from(bucket: "factory")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "AFB" and r.Signal == "KameraP" and r.Assembly == "Packaging" and r._value != 0))
|> keep(columns: ["_value","_time"])
// build tables
|> group(columns: ["_value"])
// sort in every table by time
|> sort(columns: ["_time"])
|> map(fn: (r) => ({ r with "_delay": uint(v: r._time) / uint(v: 1000000000) }))
|> difference(columns: ["_delay"], keepFirst: true)
// corrections: NaN and unrealistic (>100) to 0
|> fill(column: "_delay", value: 0)
|> map(fn: (r) => ({ r with "_delay": if r._delay > 100 then 0 else r._delay }))
|> filter(fn: (r) => (r._delay != 0))

// mean of cycle times
dataMean = data
|> filter(fn: (r) => (r._value != 0))
|> mean(column: "_delay")
|> set(key: "_field", value: "_mean")

// deviation of cycle times
dataStddev = data
|> filter(fn: (r) => (r._value != 0))
|> stddev(column: "_delay")
|> set(key: "_field", value: "_stddev")

// union and pivot
union(tables: [dataMean,dataStddev])
|> pivot(columnKey: ["_field"], rowKey: ["_value"], valueColumn: "_delay")
|> rename(columns: {"_value": "lorry", "_mean": "cycle_mean", "_stddev": "cycle_stddev"})
|> yield()
