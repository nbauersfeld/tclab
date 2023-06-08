import "join"

server1 = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server1") ))
|> drop(columns: ["Device","Location","Sensor","topic","host"])
|> limit(n: 5000)

server2 = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server2") ))
|> drop(columns: ["Device","Location","Sensor","topic","host"])
|> limit(n: 5000)

join.time(method: "left", left: server1, right: server2, as: (l, r) => ({l with target: l._value + r._value}))