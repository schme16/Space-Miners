
function love.conf(t)
    t.title             = "Space Miner"
    t.identity          = "spaceMiner"
    t.author            = "Shane Gadsby [schme16]"
    t.version           = 071
    t.console           = true
    t.screen.width      = 800
    t.screen.height     = 600
    t.screen.fsaa     	= 2
    t.screen.fullscreen = false
    t.screen.vsync      = true
    t.modules.joystick  = false
    t.modules.audio     = true
    t.modules.keyboard  = true
    t.modules.event     = true
    t.modules.image     = true
    t.modules.graphics  = true
    t.modules.timer     = true
    t.modules.mouse     = true
    t.modules.sound     = true
    t.modules.physics   = false
    t.modules.thread    = false
end
