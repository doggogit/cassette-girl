local endedSong = false
local canEnd = false
local leFakeBpm = 0
local leLastBeat = 0
local leFakeBeat = 0

function onCreatePost()
	runHaxeCode([[
        game.gf.x -= 100;
        game.gf.y += 20;
        game.dad.x -= 110;
        game.dad.y += 180;
        game.boyfriend.y += 140;
    ]])

    if isStoryMode and songPath == 'earworm' then 
        makeAnimatedLuaSprite('casFake', 'characters/cassettegirl-chill', getProperty('dad.x') - 1, getProperty('dad.y')) -- for the end song cutscene
        addAnimationByPrefix('casFake', 'swap', 'cassettegirl-chill', 24, false)
        setObjectOrder('casFake', getObjectOrder('dadGroup') + 1)
        setProperty('casFake.alpha', 0.0001)    

        -- "caching" attempts | ill figure it out probably --
        addHaxeLibrary('SoundFrontEnd', 'flixel.system.frontEnds')
        --[[addCharacterToList('bf', 'boyfriend')
        addCharacterToList('gf', 'gf')
        addCharacterToList('cg', 'dad')]]

        runHaxeCode([[
            FlxG.sound.cache(Paths.inst('machina'));
  		    FlxG.sound.cache(Paths.voices('machina'));
        ]])
    end
end

function onStartCountdown()
    if isStoryMode and songPath == 'machina' then
        setProperty('skipCountdown', true)
    end
end

local hideStuff = {'iconP1', 'iconP2', 'healthBar', 'healthBarBG', 'scoreTxt'}
function onEndSong()
    if --[[isStoryMode and]] songPath == 'earworm' and not canEnd then
        endedSong = true
        leFakeBpm = curBpm
        setProperty('updateTime', false)

        setProperty('timeBar.visible', true)
        setProperty('timeBarBG.visible', true)
        setProperty('timeTxt.visible', true)
        
        playMusic('breakfast', 0, true) -- 

        for i = 1, #hideStuff do
            doTweenAlpha('hide'..i, hideStuff[i], 0, stepCrochet * 16 / 1000, 'quadInOut') 
        end
        for i = 0, 7 do
            noteTweenAlpha('awayWithYou'..i, i, 0, 1, 'quadInOut') 
        end

        runTimer('setBack', 0.8)

        return Function_Stop
    end
    return Function_Continue
end

function onTimerCompleted(t)
    if t == 'setBack' then
        setProperty('dad.visible', false)
        playAnim('casFake', 'swap')
        setProperty('casFake.alpha', 1)
        playSound('rewind')

        runHaxeCode([[
            curPos = 0;
            
            FlxTween.num(0, 122000, 1.65, {
                ease: FlxEase.linear, 
                onUpdate: function(tween:FlxTween){
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

function onMoveCamera(char)
    if char == 'dad' then 
        runHaxeCode([[
            game.camFollow.set(game.dad.getMidpoint().x + 150, game.dad.getMidpoint().y - 100);
            game.camFollow.x += game.dad.cameraPosition[0];
            game.camFollow.y += game.dad.cameraPosition[1];
            game.camFollow.x = game.dad.getMidpoint().x + 200;
        ]])
    else
        runHaxeCode([[
            game.camFollow.set(game.boyfriend.getMidpoint().x - 100, game.boyfriend.getMidpoint().y - 100);
            game.camFollow.y = game.boyfriend.getMidpoint().y - 230;

            game.camFollow.x -= game.boyfriend.cameraPosition[0];
            game.camFollow.y += game.boyfriend.cameraPosition[1];
        ]])
    end
end

function format(time)
    local s = math.floor(time/1000);
    return string.format('%01d:%02d', (s/60)%60, s%60);
end

function fakeBeatHit()
    characterDance('gf')
    if leFakeBeat % 2 == 0 then
        characterDance('boyfriend')
        characterDance('dad')
    end
end