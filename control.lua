DG1022 = require("DG1022")
lib = require("lib")

local results = {}
local file = io.open(os.date("results/control-%Y-%m-%d-%H:%M:%S.txt", os.time()), "w")

function doFrequency(f)
    gen:frequency(f)
    print(f)
    local i = lib.input_answer()
    if i == 'x' then
        file:write(tostring(f) .. "     x\n")
    else
        file:write(tostring(f) .. "\n")
    end
end

gen = DG1022:new()
gen:sinusoid()
gen:offset(2.5)
gen:voltage(4.996)
gen:phase(30)
gen:output(true)


for f = 52.1, (57.0 + 0.1), 0.1 do
    doFrequency(f)
end

for _, f in ipairs{21.4, 31.4, 50.4, 73.4} do
    doFrequency(f)
end

for f = 1.5, 120.5, 1 do
    doFrequency(f)
end
for f = 0.6, 120.6, 1 do
    doFrequency(f)
end
for f = 0.7, 119.7, 1 do
    doFrequency(f)
end
for f = 0.8, 119.8, 1 do
    doFrequency(f)
end

gen:output(false)
gen:close()

os.execute("beep")
