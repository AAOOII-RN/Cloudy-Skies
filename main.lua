Object = require "classic"
require "hillNoise"

function love.load()
    love.window.setMode(1200, 900)
    math.randomseed(os.clock())
    ww, wh = love.graphics.getDimensions()
    ticker = 0
    hn = Noise(2)
end

function love.update(dt)
    ticker = ticker + 4 * dt
end

function love.draw()
    love.graphics.setBackgroundColor(0, 194/255, 1)
    love.graphics.print(love.timer.getFPS())

    for i = 1, 64 do
        love.graphics.setColor(0, 104/255, 1, 0.02*i/16)
        love.graphics.rectangle("fill", 0, i*(wh/64), ww, i*(wh/64))
    end

    love.graphics.setColor(1, 1, 117/255)
    love.graphics.circle("fill", 3*ww/4, wh/4, 100)

    for i = 1, 32 do
        clouds = (hn:hillNoise(ticker/2+i, 1) + hn:hillNoise(ticker/2+i, 2))/2
        if clouds >= 0.1 then
            love.graphics.setColor(1,1,1)
            love.graphics.circle("fill", i*ww/32, 2*wh/3 + clouds*-50, clouds*100)
        end
    end
end
