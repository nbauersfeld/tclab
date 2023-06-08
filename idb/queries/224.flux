import "join"
import "math"

tstart = -60d
tevery = 30m
toffset = 0m
tduration = 1s

vmax = 175.
vcor = 25.

server1 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server1")))
|> drop(columns: ["Device","Location","Sensor","topic","host"])
|> map(fn: (r) => ({r with "_value": if r._value > vmax then r._value - vcor else r._value  }))

left = server1
|> aggregateWindow(every: tevery, fn: mean, offset: toffset)

server2 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server2")))
|> drop(columns: ["Device","Location","Sensor","topic","host"])
|> map(fn: (r) => ({r with "_value": if r._value > vmax then r._value - vcor else r._value  }))

right = server2
|> aggregateWindow(every: tevery, fn: mean, offset: toffset)

server = join.time(method: "left", left: left, right: right, as: (l, r) => ({l with "_target": l._value + r._value}))
|> sort(columns: ["_time"])

data = server
|> derivative(columns: ["_target"], nonNegative: true, unit: tduration)

data
|> yield()
