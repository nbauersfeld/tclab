tstart = -60d

vmax = 175.
vcor = 25.

server1 = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies" and (r.Device == "server1")))
|> drop(columns: ["Device","Location","Sensor","topic","host"])
|> map(fn: (r) => ({r with "_value": if r._value > vmax then r._value - vcor else r._value  }))

server1
|> sort(columns: ["_time"])
|> keep(columns: ["_value","_time"])
|> yield()
