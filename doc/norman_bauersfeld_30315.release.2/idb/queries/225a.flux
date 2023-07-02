
import "join"
import "date"
import "math"
import "array"

tstart = -90d
tevery = 10m
tduration = 10s

vmax = 175.

d1 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server1")))
|> keep(columns: ["_time","_value"])
|> map(fn: (r) => ({r with "_hour": date.hour(t: r._time)}))

m1 = d1
|> mean()

m10 = m1
|> findRecord(fn: (key) => true, idx: 0)

a1 = d1
|> map(fn: (r) => ({r with "_mean": m10._value}))
|> map(fn: (r) => ({r with "_value": if r._value > vmax then r._mean else r._value  }))
|> aggregateWindow(every: tevery, fn: mean)

//array.from(rows: [{ _mean: display(v: s1._value)}])
//|> yield()

v1 = a1
|> derivative(columns: ["_value"], nonNegative: false, unit: tduration)

rc1 = join.time(method: "left", left: a1, right: v1, as: (l, r) => ({l with "bulge": math.abs(x: r._value)}))

rc1
|> filter(fn: (r) => (r.bulge > 0.2))
|> keep(columns: ["_time","_value","bulge"])
|> yield()
