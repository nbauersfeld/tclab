
import "date"

tstart = -90d
vmax = 175.
vcor = 25.

data = from(bucket: "power")
|> range(start: tstart)
|> filter(fn: (r) => ((r._measurement == "shellies") and (r.Device == "server1")))
|> keep(columns: ["_value", "_time"])
// mark outlier to correct
|> map(fn: (r) => ({r with "corrected": if r._value > vmax then 1 else 0 }))
// correct outlier
|> map(fn: (r) => ({r with _value: if r._value > vmax then r._value - vcor else r._value }))
// mark retaining outliers
|> map(fn: (r) => ({r with "outlier": if r._value > vmax then 1 else 0 }))
|> map(fn: (r) => ({r with "hour": date.hour(t: r._time)}))

data
|> filter(fn: (r) => (r.corrected == 1))
|> filter(fn: (r) => (r.outlier == 1))
// suppose outliers at day from 3 to 22
|> filter(fn: (r) => ((r.hour > 3) and (r.hour < 22)))
|> yield()
