DG1022 = require("DG1022")
lib = require("lib")

fs = 0.001983 -- start
fe = 0.001998 -- end
t = 2         -- time for each frequency
n = 8         -- number of repetitions

gen = DG1022:new()
gen:sinusoid()
gen:offset(2.5)
gen:voltage(5.0)
gen:phase(89)
gen:frequency(fs)
gen:output(true)

for i = 0, fe-fs, 0.000002 do
    for j = 1, n do
        local f1 = fs+i
        local f2 = fs+i+0.000001
        print(f1)
        gen:frequency(f1)
        lib.sleep(t)
        print(f2)
        gen:frequency(f2)
        lib.sleep(t)
    end
end 

gen:output(false)
gen:close()

os.execute("beep")
