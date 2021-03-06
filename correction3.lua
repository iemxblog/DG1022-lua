DG1022 = require("DG1022")
lib = require("lib")

local fs = {4, 11, 20, 36, 52, 72, 96, 130, 21, 38, 68, 94, 151, 204} 

gen = DG1022:new()
gen:sinusoid()
gen:offset(2.5)
gen:voltage(5.0)
gen:phase(89)

for _, f in ipairs(fs) do
    gen:frequency(f/1000000)
    gen:output(true)
    lib.sleep(10)
end

gen:output(false)
gen:close()

os.execute("beep")
