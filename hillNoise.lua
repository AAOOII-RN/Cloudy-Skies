Noise = Object:extend()

function Noise:new(n)
    self.randoms = n -- Acts like an ID
    self.offset = {} -- offset (-6, 6)
    self.amp = {} -- Amplitude (-0.75, 0.75)
    self.wlen = {} -- Wavelength (1, 2)
    self.do_once = false -- does operation once

    for j = 1, self.randoms do
        self.offset[j] = {}
        self.amp[j] = {}
        self.wlen[j] = {}
    end
end

function Noise:hillNoise(x, n)
    if not self.do_once then
        for j = 1, self.randoms do
            for i = 1, 6 do
                self.offset[j][i] = math.random(-6000, 6000)/1000
                self.amp[j][i] = math.random(1500)/1000-0.75
                self.wlen[j][i] = math.random()*2
            end
        end
        self.do_once = true
    end

    v = {}
    for i = 1, 6 do
        v[math.ceil(i/2)] = math.sin(x*self.amp[n][math.ceil(i/2)*2-1]+self.offset[n][math.ceil(i/2)*2-1]*self.wlen[n][math.ceil(i/2)*2-1])
    end

    return v[1] * v[2] * v[3]
end