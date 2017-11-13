DG1022 = require('DG1022')
lib = require('lib')

frequencies = { 121, 120, 119, 118, 117, 116, 115, 114, 113, 112, 111,
                101, 91, 81, 71, 61, 51, 41, 31, 21, 11, 1}

gen = DG1022:new()
gen:sinusoid()
gen:frequency(frequencies[1])
gen:pos_voltage(10)
gen:output(true)

local results = {}

for _, f in ipairs(frequencies) do
    gen:frequency(f)
    i = lib.input_answer()
    local temp = results[f] or {}
    if i == 'w' then
        table.insert(temp, 1)
    elseif i == 'x' then
        table.insert(temp, 0)
    end 
    results[f] = temp
end

gen:output(false)
gen:close()

print(lib.displayResults(results))
lib.writeResults(results, "low_freq")
