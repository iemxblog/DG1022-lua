DG1022 = require('DG1022')
lib = require('lib')

n = 20
f = 2000000
v1 = 0
v2 = 10

math.randomseed(os.time())

local voltages = {}
for i=1, 20 do
   voltages[i] = v1 + math.random() * (v2 - v1)
end

local results = {}

gen = DG1022:new()
gen:sinusoid()
gen:frequency(f)
gen:output(true)

for _, v in ipairs(voltages) do
    gen:pos_voltage(v)
    i = lib.input_answer()
    local temp = results[v] or {}
    if i == 'w' then
        table.insert(temp, 1)
    elseif i == 'x' then
        table.insert(temp, 0)
    end
    results[v] = temp
end

gen:output(false)
gen:close()

print(lib.displayResults(results))
lib.writeResults(results, "threshold")
