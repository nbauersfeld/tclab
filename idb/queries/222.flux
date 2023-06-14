import "date"

tstart = -90d

data = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => (r._measurement == "shellies"))
|> drop(columns: ["topic","host"])
|> set(key: "_hour", value: "")
|> map(fn: (r) => ({r with "_hour": date.hour(t: r._time)}))
|> drop(columns: ["_start","_stop","_field","_measurement","_time","Device","Location","Sensor","topic","host"])
|> group(columns: ["_hour"])
|> sum(column: "_value")

data 
|> rename(columns: {_value: "consumtion", _hour: "hour"})
|> yield()