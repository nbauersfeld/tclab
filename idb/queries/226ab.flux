import "date"

data = from(bucket: "power")
|> range(start: -60d)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r.Device == "server1")))
|> keep(columns: ["_value", "_time"])
// mark outlier to correct
|> map(fn: (r) => ({r with "_corrected": if r._value > 175 then 1 else 0 }))
// correct outlier
|> map(fn: (r) => ({r with _value: if r._value > 175 then r._value - 25. else r._value }))
// mark retaining outliers
|> map(fn: (r) => ({r with "_outlier": if r._value > 175 then 1 else 0 }))
|> map(fn: (r) => ({r with "_hour": date.hour(t: r._time)}))

data
|> filter(fn: (r) => (r._corrected == 1))
|> filter(fn: (r) => (r._outlier == 1))
// suppose outliers at day from 3 to 22
|> filter(fn: (r) => (r._hour > 3 and r._hour < 22))
|> yield()
