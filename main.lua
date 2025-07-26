Object = require "classic"
require "hillNoise"

function love.load()
    love.window.setMode(1200, 900)
    math.randomseed(os.clock())
    ww, wh = love.graphics.getDimensions()
    ticker = 0
    hn = Noise(3)
end

function love.update(dt)
    ticker = ticker + 1 * dt
end

function love.draw()
    love.graphics.setBackgroundColor(0, 194/255, 1)
    love.graphics.setColor(1, 1, 1)
    love.graphics.print(math.floor(ticker/60) .. ":" .. math.fmod(math.floor(ticker), 60))

    local transition = 128
    for i = 1, transition do
        love.graphics.setColor(0, 104/255, 1, i/transition/50)
        love.graphics.rectangle("fill", 0, (i-1)*wh/transition, ww, i*wh/transition)
    end
    love.graphics.setColor(1,0,0)

    love.graphics.setColor(1, 1, 117/255, 0.75)
    love.graphics.circle("fill", 3*ww/4 + (ww/4 - 3*ww/4) * (math.sin(ticker*(math.pi/1800) - math.pi/2)+1)/2, wh/4, 100)

    for i = 1, 32 do
        clouds = (hn:hillNoise(ticker+i, 1) + hn:hillNoise(ticker+i, 2) + hn:hillNoise(ticker+i, 3))/3
        if clouds >= 0 then
            love.graphics.setColor(1,1,1,clouds*3)
            love.graphics.circle("fill", i*ww/32, 2*wh/3 + clouds*-50, clouds*100)
        end
    end
end
