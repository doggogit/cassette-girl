local lights = {'LEFT', 'DOWN', 'UP', 'RIGHT'}
switchedCol = false

function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Vs Cassette Girl")
end

function onCreatePost() -- thing that appears every note hit (unfinished | im tired)
    makeLuaSprite('hbOverlay', 'cassette/hud/hbOverlay', 0, 0)
    setObjectCamera('hbOverlay', 'hud')
    setObjectOrder('hbOverlay', getObjectOrder('healthBar') + 1)
    setProperty('hbOverlay.alpha', 0.7)
    addLuaSprite('hbOverlay')

    for i = 1, 4 do
        makeLuaSprite('hitOverlay'..lights[i], 'cassette/hud/'..lights[i]..' LIGHT')
        screenCenter('hitOverlay'..lights[i])
        scaleObject('hitOverlay'..lights[i], 0.81, 0.81, false)
        setProperty('hitOverlay'..lights[i]..'.alpha', 0.0001)
        setObjectCamera('hitOverlay'..lights[i], 'hud')
        addLuaSprite('hitOverlay'..lights[i])
    end
end

function onUpdatePost()
    setProperty('hbOverlay.x', getProperty('healthBarBG.x'))
    setProperty('hbOverlay.y', getProperty('healthBarBG.y'))
end

function goodNoteHit(i, d, t, s)
    if not sus then
        runHaxeCode([=[
            var nums = [for (i in 1...4) game.members[game.members.indexOf(game.strumLineNotes) - i]];
            var all = [for (i in nums) i];
            var combo = game.members[game.members.indexOf(game.strumLineNotes) - 3];
            all.push(combo);
            var rating = game.members[game.members.indexOf(game.strumLineNotes) - 4];
            all.push(rating);
            // example on what you can do :)
            for (spr in all)
                spr.cameras = [game.camGame];
        ]=])
    end

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

function onBeatHit()
    setTimeBarColors((switchedCol and '4343af' or '31b0d1'), '000000');
    switchedCol = not switchedCol
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
end