lib = require("lib")

local DG1022 = {}

function DG1022:new(o)
    o = o or {}
    o.device = o.device or "/dev/usbtmc0"
    o.file = assert(io.open(o.device, "r+"))
    setmetatable(o, self)
    self.__index = self
    return o 
end

function DG1022:write(line)
    self.file:write(line .. "\n")
    self.file:flush()
    lib.sleep(0.1)
end

function DG1022:close()
    self.file:close()
end

function DG1022:output(state)
    if state then 
        self:write("OUTP ON")
    else
        self:write("OUTP OFF")
    end
end

function DG1022:frequency(freq)
    self:write(string.format("FREQ %.6f", freq))
end

function DG1022:sinusoid()
    self:write("APPL:SIN")
end

function DG1022:voltage(vpp)
    self:write(string.format("VOLT %.3f", vpp))
end

function DG1022:offset(o)
    self:write(string.format("VOLT:OFFS %.3f", o))
end

function DG1022:phase(p)
    self:write(string.format("PHAS %.3f", p))
end

function DG1022:pos_voltage(vpp)
    self:voltage(vpp-0.001)
    self:offset(vpp/2)
end

return DG1022
