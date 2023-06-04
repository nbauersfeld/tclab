xair = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r.Device == "xair") and (r._value != 0)))

xair 
|> min(column: "_time")
|> drop(columns: ["_start","_stop","_field","_measurement","Sensor","topic","host","_value","Location"])
|> rename(columns: {_time: "installation", Device: "device"})
|> yield()