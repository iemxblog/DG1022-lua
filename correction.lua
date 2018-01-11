DG1022 = require("DG1022")
lib = require("lib")

f = 0.002401

gen = DG1022:new()
gen:sinusoid()
gen:offset(2.5)
gen:voltage(4.990)
gen:phase(30)
gen:frequency(f)
gen:output(true)

for i = 0, 0.000019, 0.000002 do
    for j = 1, 9 do
        local f1 = f+i
        local f2 = f+i+0.000001
        print(f1)
        gen:frequency(f1)
        lib.sleep(1.1)
        print(f2)
        gen:frequency(f2)
        lib.sleep(1.1)
        --print(f1, f2)
    end
end 

gen:output(false)
gen:close()

os.execute("beep")
