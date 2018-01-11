DG1022 = require('DG1022')
lib = require('lib')


function sleep(n)
    t0 = os.clock()
    while os.clock() - t0 < n do end
end

--frequencies = {45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55}
local frequencies = {   0.001, 0.002, 0.003, 0.004, 0.005, 0.006, 0.007, 0.008, 0.009, 
                        0.01, 0.011, 0.012, 0.013, 0.014, 0.015}

local pause = 60
local ampl = 10

local comments
if #arg == 1 and arg[1] == "shuffle" then
    comments = "shuffled\n"
    lib.shuffle(frequencies)
    print("Shuffling frequencies")
--    for _, f in ipairs(frequencies) do
--        print(f)
--    end
end

comments = (comments or "") .. "ampl = " .. tostring(ampl)


gen = DG1022:new()
gen:sinusoid()
gen:frequency(frequencies[1])
gen:pos_voltage(ampl)
gen:output(true)

local results = {}

for _, f in ipairs(frequencies) do
    gen:frequency(f)
    sleep(pause)
    os.execute("beep")
    i = lib.input_answer()
    os.execute("beep")
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
lib.writeResults(results, "low_freq", comments)

os.execute("beep")
