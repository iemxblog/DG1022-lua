local lib = {}

function lib.displayResults(results)
    local temp = {}
    for k, v in pairs(results) do
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
    return text
end

function lib.writeResults(results, name)
    file = io.open(os.date("results/" .. name .. "-%Y-%m-%d-%H:%M:%S.txt", os.time()), "w")
    file:write(lib.displayResults(results))
    file:close() 
end

function lib.input_answer() 
    print('x ou w ? (x -> bras égaux, w -> bras court)')
    local i = ''
    while i ~= 'x' and i ~= 'w' do
        i = io.read()
    end
    return i
end

function lib.shuffle(t)
    math.randomseed(os.time())
    for i=1, #t do
        local r = math.random(#t)
        t[i], t[r] = t[r], t[i]
    end
end

return lib
