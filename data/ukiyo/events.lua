local things = {'iconP1', 'iconP2', 'scoreTxt', 'healthBar', 'healthBarBG'}
function onCreatePost()
    if isStoryMode and not seenCutscene then
        makeAnimatedLuaSprite('introCas', 'cassette/cutscenes/intro/cassettegirl-st', getProperty('dad.x'), getProperty('dad.y'))
        addAnimationByPrefix('introCas', 'start', 'cassettegirl cut', 22, false)
        setObjectOrder('introCas', getObjectOrder('dadGroup'))

        setProperty('camFollow.x', getMidpointX('dad') + 200)
        setProperty('camFollow.y', getMidpointY('dad') - 100)
        setProperty('camFollow.y', getProperty('camFollow.y') + getProperty('dad.cameraPosition[1]'))    
        
        for _,thing in pairs(things) do setProperty(thing..'.alpha', 0) end
    end
end

local didIntro = false
local lol = {false, false}
function onStartCountdown()
    if isStoryMode and not seenCutscene and not didIntro then
        didIntro = true
        playSound('city', 1, 'city')
        setProperty('dad.visible', false)
        playAnim('introCas', 'start')
        return Function_Stop
    end
    return Function_Continue
end

function onUpdate()
    if luaSpriteExists('introCas') then
        if getProperty('introCas.animation.curAnim.curFrame') == 34 and not lol[1] then
            lol[1] = true
            playSound('tapestuff')
        end
        if getProperty('introCas.animation.curAnim.curFrame') == 45 and not lol[2] then
            lol[2] = true
            playSound('dah')
            playAnim('boyfriend', 'singUP')
            setProperty('camFollow.x', getProperty('camFollow.x') + 150)
            soundFadeOut('city', 4, 0)
        end
        if getProperty('introCas.animation.curAnim.finished') and didIntro then
            removeLuaSprite('introCas', true)
            setProperty('dad.visible', true)
            startCountdown()
            for _,thing in pairs(things) do 
                doTweenAlpha('fade'..thing, thing, 1, stepCrochet * 16 / 1000, 'quadInOut')
            end
        end
    end
end