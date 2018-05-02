DG1022 = require("DG1022")
lib = require("lib")

local fs = {2096, 2319, 2594, 2880, 3209, 3409, 3627, 3931}

gen = DG1022:new()
gen:sinusoid()
gen:offset(2.5)
gen:voltage(4.990)
gen:phase(89)

for _, f in ipairs(fs) do
    gen:frequency(f/1000000)
    gen:output(true)
    lib.sleep(10)
end

gen:output(false)
gen:close()

os.execute("beep")
