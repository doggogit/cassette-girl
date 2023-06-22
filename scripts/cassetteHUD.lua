local lights = {'LEFT', 'DOWN', 'UP', 'RIGHT'}

function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Vs Cassette Girl")
end

function onCreatePost() -- thing that appears every note hit (unfinished | im tired)
    for i = 1, 4 do
        makeLuaSprite('hitOverlay'..lights[i], 'cassette/stage/'..lights[i]..' LIGHT')
        screenCenter('hitOverlay'..lights[i])
        scaleObject('hitOverlay'..lights[i], 0.81, 0.81, false)
        setProperty('hitOverlay'..lights[i]..'.alpha', 0.0001)
        setObjectCamera('hitOverlay'..lights[i], 'hud') -- these overlays are actually on their own camera, i'll probably do that later
        addLuaSprite('hitOverlay'..lights[i])
    end
end

function goodNoteHit(i, d, t, s)
    if not s then
        for i = 0, 3 do
            setProperty('hitOverlay'..lights[i+1]..'.alpha', i == d and 1 or 0)
            cancelTimer('fadeB'..lights[i+1])
            cancelTween('growX'..lights[i+1])
            cancelTween('growY'..lights[i+1])
            cancelTween('bleh'..lights[i+1])
        end
        scaleObject('hitOverlay'..lights[d+1], 0.81, 0.81, false)
        runTimer('hitB'..lights[d+1], 0.1)
    end
end

function opponentNoteHit(i, d, t, s) -- only when she sings with alt anims
    -- i love doggo so much he's so kind to me and he's given me something no one else has my feelings for him grow every day
end

function onTimerCompleted(t)
    if t:find('B') then
        if t:find('hit') then
            t = t:gsub('hitB', '')
            cancelTimer('fadeB'..t)
            cancelTween('growX'..t)
            cancelTween('growY'..t)
            cancelTween('bleh'..t)

            doTweenX('growX'..t, 'hitOverlay'..t..'.scale', 1, 0.8, 'cubeOut')
            doTweenX('growY'..t, 'hitOverlay'..t..'.scale', 1, 0.8, 'cubeOut')
            runTimer('fadeB'..t, 0.1)
        else
            t = t:gsub('fadeB', '')
            doTweenAlpha('bleh'..t, 'hitOverlay'..t, 0, 4, 'cubeOut')
        end
    end
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
end