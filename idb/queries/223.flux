import "date"

data = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => (r._measurement == "shellies"))
|> drop(columns: ["_start","_stop","_field","_measurement","Device","Sensor","topic","host"])
|> set(key: "_hour", value: "")
|> map(fn: (r) => ({r with "_hour": date.hour(t: r._time)}))
|> drop(columns: ["_time"])
|> group(columns: ["_hour","Location"])
|> sum(column: "_value")

data 
|> rename(columns: {_value: "consumption", _hour: "hour", Location: "location"})
|> sort(columns: ["location"])
|> yield()