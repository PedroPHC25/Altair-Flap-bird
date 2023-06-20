W,H = love.graphics.getDimensions()

-- A tela é 800x600

function love.load()
    bird = {width = 50, height = 50}
    bird.x = W/2 - bird.width/2
    bird.y = bird.height/2
    bird.speed = 300
    pipeup1 = {width = 50, x = 900, y = 0, height = love.math.random(0,450)}
    pipedown1 = {width = 50, x = 900, height = H - pipeup1.height - 150}
    pipedown1.y = H - pipedown1.height
    pipeup2 = {width = 50, x = 1400, y = 0, height = love.math.random(0,450)}
    pipedown2 = {width = 50, x = 1400, height = H - pipeup2.height - 150}
    pipedown2.y = H - pipedown2.height
    counter = 0
    fcounter = {}
    space = 1
    stop = 1
    point = ""
    press = ""
end

function love.update(dt)
    
    -- Gravidade

    if bird.y < H - bird.height then
        bird.y = bird.y + bird.speed * dt
    end

    -- Controle do pulo

    if love.keyboard.isDown('space') and bird.y > 0 and space == 1 then
        bird.speed = -300
    end
    if bird.speed < 600 then
        bird.speed = bird.speed + 1000 * dt
    end

    -- Movimento dos canos

    if pipeup1.x > -50 then
        pipeup1.x = pipeup1.x - 250 * dt
    end
    if pipedown1.x > -50 then
        pipedown1.x = pipedown1.x - 250 * dt
        pipedown1.y = H - pipedown1.height
    end
    if pipeup2.x > -50 then
        pipeup2.x = pipeup2.x - 250 * dt
    end
    if pipedown2.x > -50 then
        pipedown2.x = pipedown2.x - 250 * dt
        pipedown2.y = H - pipedown2.height
    end

    -- Reaparecimento dos canos

    if pipeup1.x < -50 then
        pipeup1.x = 900
        pipeup1.height = love.math.random(0,450)
    end
    if pipeup2.x < -50 then
        pipeup2.x = 900
        pipeup2.height = love.math.random(0,450)
    end
    if pipedown1.x < -50 then
        pipedown1.x = 900
        pipedown1.height = H - pipeup1.height - 150
    end
    if pipedown2.x < -50 then
        pipedown2.x = 900
        pipedown2.height = H - pipeup2.height - 150
    end

    -- Contador

    if bird.x > pipeup1.x - 2 and bird.x < pipeup1.x + 2 and space == 1 then
        counter = counter + 1
    end

    if bird.x > pipeup2.x - 2 and bird.x < pipeup2.x + 2 and space == 1 then
        counter = counter + 1
    end

    -- Colisão e tela de game over

    if bird.x + bird.width > pipeup1.x and bird.x < pipeup1.x + pipeup1.width and bird.y < pipeup1.height then
        space = 0
        if stop == 1 then
           fcounter = counter 
        end
        stop = 0
        point = "Parabéns! Sua pontuação foi:"
        press = "Para recomeçar, pressione g."
        print(fcounter, point, press)
    end
    if bird.x + bird.width > pipeup2.x and bird.x < pipeup2.x + pipeup2.width and bird.y < pipeup2.height then
        space = 0
        if stop == 1 then
            fcounter = counter 
        end
        stop = 0
        point = "Parabéns! Sua pontuação foi:"
        press = "Para recomeçar, pressione g."
        print(fcounter, point, press)
    end
    if bird.x + bird.width > pipedown1.x and bird.x < pipedown1.x + pipedown1.width and bird.y + bird.height > pipedown1.y then
        space = 0
        if stop == 1 then
            fcounter = counter 
        end
        stop = 0
        point = "Parabéns! Sua pontuação foi:"
        press = "Para recomeçar, pressione g."
        print(fcounter, point, press)
    end
    if bird.x + bird.width > pipedown2.x and bird.x < pipedown2.x + pipedown2.width and bird.y + bird.height > pipedown2.y then
        space = 0
        if stop == 1 then
            fcounter = counter 
        end
        stop = 0
        point = "Parabéns! Sua pontuação foi:"
        press = "Para recomeçar, pressione g."
        print(fcounter, point, press)
    end
    if bird.y < 0 or bird.y > H - bird.height then
        space = 0
        if stop == 1 then
            fcounter = counter 
        end
        stop = 0
        point = "Parabéns! Sua pontuação foi:"
        press = "Para recomeçar, pressione g."
        print(fcounter, point, press)
    end

    -- Restart

    if love.keyboard.isDown('g') then
        bird.x = W/2 - bird.width/2
        bird.y = bird.height/2
        pipeup1.x = 900
        pipedown1.x = 900
        pipeup2.x = 1400
        pipedown2.x = 1400
        counter = 0
        fcounter = {}
        space = 1
        stop = 1
        point = ""
        press = ""
    end
end

function love.draw()
    love.graphics.setColor(0,1,0)
    love.graphics.rectangle('fill', bird.x, bird.y, bird.width, bird.height)
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle('fill', pipeup1.x, pipeup1.y, pipeup1.width, pipeup1.height)
    love.graphics.rectangle('fill', pipedown1.x, pipedown1.y, pipedown1.width, pipedown1.height)
    love.graphics.rectangle('fill', pipeup2.x, pipeup2.y, pipeup2.width, pipeup2.height)
    love.graphics.rectangle('fill', pipedown2.x, pipedown2.y, pipedown2.width, pipedown2.height)
    love.graphics.setColor(1,1,1)
    love.graphics.print(counter, W/2, 50)
    love.graphics.print(fcounter, W/2, H/2)
    love.graphics.print(point, W/2-85, H/2-20)
    love.graphics.print(press, W/2-84, H/2+20)
end