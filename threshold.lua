DG1022 = require('DG1022')
lib = require('lib')

n = 20
f = 34
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
    vs = string.format("%.3f", v)
    local temp = results[vs] or {}
    if i == 'w' then
        table.insert(temp, 1)
    elseif i == 'x' then
        table.insert(temp, 0)
    end
    results[vs] = temp
end

gen:output(false)
gen:close()

print(lib.displayResults(results))
lib.writeResults(results, "threshold")

os.execute("beep")
