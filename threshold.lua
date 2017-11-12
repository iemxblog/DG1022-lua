require('DG1022')

n = 20
f = 2000000
v1 = 0
v2 = 10

math.randomseed(os.time())

local voltages = {}
for i=1, 20 do
   voltages[i] = v1 + math.random() * (v2 - v1)
end

local result = {}

gen = DG1022:new()
gen:sinusoid()
gen:frequency(f)
gen:output(true)

for _, v in ipairs(voltages) do
    gen:pos_voltage(v)
    print('x ou w ? (x -> bras égaux, w -> bras court)')
    local i = ''
    while i ~= 'x' and i ~= 'w' do
        i = io.read(1)
    end
    local temp = result[v] or {}
    if i == 'w' then
        table.insert(temp, 1)
    elseif i == 'x' then
        table.insert(temp, 0)
    end
    result[v] = temp
end

gen:output(false)
gen:close()


function manageResult(r)
    local temp = {}
    for k, v in pairs(r) do
        table.insert(temp, {k, v})
    end
    table.sort(temp, function (t1, t2) return t1[1] < t2[1] end)

    local text = ""
    for _, v in ipairs(temp) do
        text = text .. v[1] .. ' -> {'
        local sep = ''
        for _, v2 in ipairs(v[2]) do
            text = text .. sep .. v2
            sep = ', '
        end
        text = text .. '}\n'
    end
    print(text)
    file = io.open(os.date("results/threshold-%Y-%m-%d-%H:%M:%S.txt", os.time()), "w")
    file:write(text)
    file:close() 
end

manageResult(result)
