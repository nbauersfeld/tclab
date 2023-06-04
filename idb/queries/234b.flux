import "join"

// lorry number with pack signal
pack = from(bucket: "factory")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "AFB" and (r.Signal == "KameraP" and r.Assembly == "Packaging") and (r._value != 0)))
|> keep(columns: ["_time","_value"])
|> toInt()
|> set(key: "_label", value: "lorry")

// batch signal
batch = from(bucket: "factory")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "AFB" and (r.Signal == "10B3" and r.Assembly == "Conveyor")))
|> keep(columns: ["_time","_value"])
|> toInt()
|> set(key: "_label", value: "batch")

// working stream sorted
work = join.tables(
    method: "full",
    left: pack,
    right: batch,
    // on time, that does no match respectively
    on: (l, r) => l._time == r._time,
    as: (l, r) => {        
        time = if exists l._time then l._time else r._time
        label = if exists l._label then l._label else r._label
        value = if exists r._value then r._value else 0
        lorry = if exists l._value then l._value else 0
        return {_time: time, label: label, batch: value, lorry: lorry}
    },
)
|> sort(columns: ["_time"])

// loaded, cumulative intermediate
data = work
|> sort(columns: ["_time"], desc: true)
|> cumulativeSum(columns: ["batch"])
|> filter(fn: (r) => (r.label == "lorry"))
|> difference(columns: ["batch"], keepFirst: true)
|> sort(columns: ["_time"], desc: false)

// loadings
data
|> keep(columns: ["_time","batch","lorry"])
// outlier fill
|> fill(column: "batch", value: -1)
// flag loading
|> map(fn: (r) => ({ r with "loading": if r.batch == 4 then 1 else 0 }))
// build tables
|> group(columns: ["lorry"])
// !4 loadings
//|> filter(fn: (r) => (r.loading != 1))
|> yield()
