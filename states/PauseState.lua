PauseState = Class { __includes = BaseState }

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

function PauseState:enter(params)
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.score = params.score
    self.lastY = params.lastY
    sounds['pause']:play()
    sounds['music']:pause()
end

function PauseState:update(dt)
    -- go back to play if p is pressed
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY
        })
    end
end

function PauseState:render()
    for _, pair in pairs(self.pipePairs) do
        pair:render()
    end
    love.graphics.setFont(flappyFont)
    love.graphics.print('Score: ' .. tostring(self.score), 8, 8)

    self.bird:render()
    love.graphics.draw(love.graphics.newImage("images/pause-icon.png"), VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 8)
end

function PauseState:exit()
    sounds['pause']:play()
    sounds['music']:play()
end
