local endedSong = false
local canEnd = false
local leFakeBpm = 0
local leLastBeat = 0
local leFakeBeat = 0

function onCreatePost()
    if isStoryMode then 
        makeAnimatedLuaSprite('casFake', 'cassette/cutscenes/transition/cassettegirl-chill', getProperty('dad.x') - 1, getProperty('dad.y')) -- for the end song cutscene
        addAnimationByPrefix('casFake', 'swap', 'cassettegirl-chill', 24, false)
        setObjectOrder('casFake', getObjectOrder('dadGroup') + 1)
        setProperty('casFake.alpha', 0.0001)    
    end
end

function onStartCountdown()
    if isStoryMode then
        addHaxeLibrary('FlxTransitionableState', 'flixel.addons.transition')
        addHaxeLibrary('SoundFrontEnd', 'flixel.system.frontEnds')
        runHaxeCode([[
            FlxTransitionableState.skipNextTransIn = true;
    	    FlxTransitionableState.skipNextTransOut = true;
            FlxG.sound.cache(Paths.inst('machina'));
            FlxG.sound.cache(Paths.voices('machina'));
        ]])
    end
end

local hideStuff = {'iconP1', 'iconP2', 'healthBar', 'healthBarBG', 'scoreTxt'}
function onEndSong()
    if isStoryMode and not canEnd then
        endedSong = true
        leFakeBpm = curBpm
        setProperty('updateTime', false)
        
        playMusic('breakfast', 0, true) 

        setProperty('dad.visible', false)
        playAnim('casFake', 'swap')
        setProperty('casFake.alpha', 1)
        playSound('rewind')
        
        setProperty('camHUD.zoom', 1) -- just incase

        setProperty('defaultCamZoom', 0.85)
        doTweenZoom('cutscen', 'camGame', 0.85, stepCrochet * 16 / 1000, 'quadInOut')

        for i = 1, #hideStuff do
            doTweenAlpha('hide'..i, hideStuff[i], 0, stepCrochet * 16 / 1000, 'quadInOut') 
        end
        for i = 0, 7 do
            noteTweenAlpha('awayWithYou'..i, i, 0, 1, 'quadInOut') 
        end

        doTweenX('leMoveX', 'camFollow', 423, stepCrochet * 16 / 1000, 'quadInOut')
        doTweenY('leMoveY', 'camFollow', 640, stepCrochet * 16 / 1000, 'quadInOut')

        runTimer('setBack', 0.8)

        return Function_Stop
    end
    return Function_Continue
end

function onTimerCompleted(t)
    if t == 'setBack' then
        runHaxeCode([[
            curPos = 0;

            FlxTween.num(0, 122000, 2, {
                ease: FlxEase.linear,
                onUpdate: function(tween:FlxTween)
                {
                    curPos = tween.value;
                    game.setOnLuas('curPos', curPos);
                }
            });
        ]])
    end
    if t == 'endThatSong!!!!' then
        canEnd = true
        endSong()
    end
end

local usePos = 0
local nextSongLength = 121000 
function onUpdatePost()
    if endedSong then
        setProperty('timeBar.visible', true)
        setProperty('timeBarBG.visible', true)
        setProperty('timeTxt.visible', true)

        usePos = curPos or 0

        if getProperty('casFake.animation.curAnim.finished') and not getProperty('dad.visible') then
            runTimer('endThatSong!!!!', 0.3)
            setProperty('casFake.visible', false)
            setProperty('dad.visible', true)
        end

        setTextString('timeTxt', format(usePos))
        setProperty('timeBar.percent', math.abs(((usePos / nextSongLength) * 100) - 100))

        fakePos = getPropertyFromClass('flixel.FlxG', 'sound.music.time')
	    leFakeBeat = (math.ceil((fakePos/5000) * (leFakeBpm/12)) - 1)  -- fake beat hits??? fuck!!!!
	    if leFakeBeat ~= leLastBeat then
	    	leLastBeat = leFakeBeat
	    	fakeBeatHit() 
	    end
    end
end

function format(time)
    local s = math.floor(time/1000);
    return string.format('%01d:%02d', (s/60)%60, s%60);
end

function fakeBeatHit()
    playAnim('coolboppers1', 'idle')
    playAnim('coolboppers2', 'idle')
    
    if leFakeBeat == 1 then setProperty('gf.danced', true) end
    characterDance('gf')
    if leFakeBeat % 2 == 0 then
        characterDance('boyfriend')
        characterDance('dad')
    end
end