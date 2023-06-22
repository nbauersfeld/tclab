import "join"

tstart = -90d
tevery = 5m

server1 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server1")))
|> drop(columns: ["Device","Location","Sensor","topic","host"])

left = server1
|> aggregateWindow(every: tevery, fn: mean)

server2 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server2")))
|> drop(columns: ["Device","Location","Sensor","topic","host"])

right = server2
|> aggregateWindow(every: tevery, fn: mean)

join.time(method: "left", left: left, right: right, as: (l, r) => ({l with "_value": l._value + r._value}))
|> sort(columns: ["_time"])
|> keep(columns: ["_value","_time"])
|> yield()
