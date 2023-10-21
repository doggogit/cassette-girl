function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Vs. Cassette Girl")
end

function onCreatePost()
    makeLuaSprite('hbOverlay', 'cassette/hud/hbOverlay', 0, 0)
    setObjectCamera('hbOverlay', 'hud')
    setObjectOrder('hbOverlay', getObjectOrder('healthBar') + 1)
    setProperty('hbOverlay.alpha', 0.7)
    addLuaSprite('hbOverlay')
end

function onUpdatePost()
    setProperty('hbOverlay.x', getProperty('healthBar.x'))
    setProperty('hbOverlay.y', getProperty('healthBar.y'))
    setProperty('hbOverlay.alpha', math.max(getProperty('healthBar.alpha') - 0.3, math.min(0.7, getProperty('healthBar.alpha'))))
end

switchedCol = false
function onBeatHit()
    setTimeBarColors((switchedCol and '4343af' or '31b0d1'), '000000')
    switchedCol = not switchedCol
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
end
