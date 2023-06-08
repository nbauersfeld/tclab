import "join"

tstart = 2023-04-12T07:28:48Z
tstop = 2023-04-12T10:00:00Z

// lorry number with pack signal
pack = from(bucket: "factory")
|> range(start: tstart, stop: tstop)
|> filter(fn: (r) => (r._measurement == "AFB" and (r.Signal == "KameraP" and r.Assembly == "Packaging") and (r._value != 0)))
|> keep(columns: ["_time","_value"])
|> toInt()
|> set(key: "_field", value: "lorry")

// batch signal
batch = from(bucket: "factory")
|> range(start: tstart, stop: tstop)
|> filter(fn: (r) => (r._measurement == "AFB" and (r.Signal == "10B3" and r.Assembly == "Conveyor")))
|> keep(columns: ["_time","_value"])
|> toInt()
|> set(key: "_field", value: "batch")

// working stream sorted
work = join.full(
    left: pack,
    right: batch,
    // on time, that does no match respectively
    on: (l, r) => l._time == r._time,
    as: (l, r) => {        
        time = if exists l._time then l._time else r._time
        field = if exists l._field then l._field else r._field
        value = if exists r._value then r._value else l._value        
        return {_time: time, _field: field, _value: value, _lorry: l._value, _batch: r._value}
    },
)
|> sort(columns: ["_time"])

// loaded, cumulative intermediate
loadings = work
|> sort(columns: ["_time"], desc: true)
|> cumulativeSum(columns: ["_batch"])
|> filter(fn: (r) => (r._field == "lorry"))
|> difference(columns: ["_batch"], keepFirst: true)
|> sort(columns: ["_time"], desc: false)

// loadings
loadings
|> keep(columns: ["_time","_batch","_lorry"])
// outlier fill
|> fill(column: "_batch", value: -1)
// flag loading
|> map(fn: (r) => ({ r with "_loading": if r._batch != 4 then 1 else 0 }))
// build tables
|> group(columns: ["_lorry"])
// !4 loadings
|> filter(fn: (r) => (r._loading == 1))
