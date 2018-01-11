DG1022 = require("DG1022")
lib = require('lib')

local v1 = 0.0
local v2 = 10.0
local f = 121

gen = DG1022:new()
gen:sinusoid()
gen:frequency(f)
gen:output(true)

while v2-v1 > 0.001 do
    local v = (v1+v2)/2
    gen:pos_voltage(v)
    i = lib.input_answer()
    if i == 'w' then
        v2 = v
    elseif i == 'x' then
        v1 = v
    end
end

gen:output(false)
gen:close()
print(string.format("threshold = %.3f", (v1+v2)/2))

os.execute("beep")
