function onCreate()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Vs Cassette Girl")
end

function onCreatePost() 
    makeLuaSprite('hbOverlay', 'cassette/hud/hbOverlay', 0, 0)
    setObjectCamera('hbOverlay', 'hud')
    setObjectOrder('hbOverlay', getObjectOrder('healthBar') + 1)
    setProperty('hbOverlay.alpha', 0.7)
    addLuaSprite('hbOverlay')

    if flashingLights then
		makeLuaSprite('cgLightsB', 'cassette/hud/NOTE_LIGHT', 0, 0)
		--setObjectCamera('cgLightsB', 'hud')
        screenCenter('cgLightsB')
        scaleObject('cgLightsB', 0.81, 0.81, false)
		setProperty('cgLightsB.alpha', 0.0001)
		addLuaSprite('cgLightsB', true)

        makeLuaSprite('cgLightsD', 'cassette/hud/NOTE_LIGHT', 0, 0)
		--setObjectCamera('cgLightsD', 'hud')
        screenCenter('cgLightsD')
        scaleObject('cgLightsD', 0.81, 0.81, false)
		setProperty('cgLightsD.alpha', 0.0001)
		addLuaSprite('cgLightsD', true)
	end

    addHaxeLibrary('FlxCamera', 'flixel')
    runHaxeCode([[
        lightsCam = new FlxCamera();
        lightsCam.bgColor = 0x00;
        FlxG.cameras.add(lightsCam, false);

        cams = [game.camHUD, game.camOther];
        for (cam in cams)
        {
            FlxG.cameras.remove(cam, false);
            FlxG.cameras.add(cam, false);
        }
        
        game.getLuaObject('cgLightsB', false).cameras = [lightsCam];
        game.getLuaObject('cgLightsD', false).cameras = [lightsCam];
        game.getLuaObject('bgLayer', false).cameras = [lightsCam];
    ]])
end

function onUpdatePost()
    setProperty('hbOverlay.x', getProperty('healthBarBG.x'))
    setProperty('hbOverlay.y', getProperty('healthBarBG.y'))
    setProperty('hbOverlay.alpha', math.max(getProperty('healthBarBG.alpha') - 0.3, math.min(0.7, getProperty('healthBarBG.alpha'))))
end

local colors = {
	[0] = 'c24b99', [1] = '00ffff',
	[2] = '12fa05',	[3] = 'f9393f'
}

function goodNoteHit(i, d, t, s)
    if not s then
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
        
        cancelTimer('fadeB') cancelTween('blehB')
        cancelTween('growXB') cancelTween('growYB')

        scaleObject('cgLightsB', 0.81, 0.81, false)
        setProperty('cgLightsB.color', getColorFromHex(colors[d]))
        setProperty('cgLightsB.alpha', 1)
        runTimer('hitB', 0.1)
    end
end

function opponentNoteHit(i, d, t, s) -- only when she sings with alt anims
    if getProperty('dad.animation.curAnim.name'):find('-alt') and not s then
        cancelTimer('fadeD') cancelTween('blehD')
        cancelTween('growXD') cancelTween('growYD')

        scaleObject('cgLightsD', 0.81, 0.81, false)
		setProperty('cgLightsD.color', getColorFromHex(colors[d]))
		setProperty('cgLightsD.alpha', 1)
        runTimer('hitD', 0.1)
    end
end

function onTimerCompleted(t)
    if t:find('hit') then
        t = t:gsub('hit', '')

        doTweenX('growX'..t, 'cgLights'..t..'.scale', 1, 0.8, 'cubeOut')
        doTweenX('growY'..t, 'cgLights'..t..'.scale', 1, 0.8, 'cubeOut')
        runTimer('fade'..t, 0.1)
    end
    if t:find('fade') then
        t = t:gsub('fade', '')
        doTweenAlpha('bleh'..t, 'cgLights'..t, 0, 4, 'cubeOut')
    end
end

switchedCol = false
function onBeatHit()
    setTimeBarColors((switchedCol and '4343af' or '31b0d1'), '000000')
    switchedCol = not switchedCol
end

function onDestroy()
    setPropertyFromClass("openfl.Lib", "application.window.title", "Friday Night Funkin': Psych Engine")
end