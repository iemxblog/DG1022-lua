DG1022 = require("DG1022")
lib = require("lib")

local fs = {50, 41, 49, 42, 48, 43, 47, 44, 46, 45}

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
