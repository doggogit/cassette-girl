function onCreate()
    makeLuaSprite('cgbg', nil, 0, 0)
    screenCenter('cgbg')
    scaleObject('cgbg', 1.25, 1.25, false)
    loadFrames('cgbg', 'cassette/stage/CGBG', 'sparrow')
    addAnimationByPrefix('cgbg', 'idle', 'new', 24, false)
    setProperty('cgbg.x', getProperty('cgbg.x') - 1250)
    setProperty('cgbg.y', getProperty('cgbg.y') - 980)
    addLuaSprite('cgbg')

    if songName == 'Soda Groove' then
        makeLuaSprite('coolboppersSG1', nil, 0, 0)
        scaleObject('coolboppersSG1', 1.45, 1.45, false)
        screenCenter('coolboppersSG1')
        loadFrames('coolboppersSG1', 'cassette/stage/crowd/alt/crowd-free', 'sparrow')
        addAnimationByPrefix('coolboppersSG1', 'idle', 'crowd-van', 24, false)
        setProperty('coolboppersSG1.x', getProperty('coolboppersSG1.x') - 660)
        setProperty('coolboppersSG1.y', getProperty('coolboppersSG1.y') - 40)
        addLuaSprite('coolboppersSG1')

        makeLuaSprite('coolboppersSG2', nil, 0, 0)
        screenCenter('coolboppersSG2')
        scaleObject('coolboppersSG2', 1.45, 1.45, false)
        loadFrames('coolboppersSG2', 'cassette/stage/crowd/alt/crowd-free2', 'sparrow')
        addAnimationByPrefix('coolboppersSG2', 'idle', 'crowd-van', 24, false)
        setProperty('coolboppersSG2.x', getProperty('coolboppersSG2.x') - 640)
        setProperty('coolboppersSG2.y', getProperty('coolboppersSG2.y') - 30)
        setObjectOrder('coolboppersSG2', getObjectOrder('gfGroup') + 1)
        addLuaSprite('coolboppersSG2')
    else
        makeLuaSprite('coolboppers1', nil, 0, 0)
        scaleObject('coolboppers1', 1.3, 1.3)
        screenCenter('coolboppers1')
        loadFrames('coolboppers1', 'cassette/stage/crowd/boppers1', 'sparrow')
        addAnimationByPrefix('coolboppers1', 'idle', 'crowd', 24, false)
        setProperty('coolboppers1.x', getProperty('coolboppers1.x') - 650)
        setProperty('coolboppers1.y', getProperty('coolboppers1.y') - 80)
        setObjectOrder('coolboppers1', getObjectOrder('gfGroup') + 1)
        addLuaSprite('coolboppers1')

        makeLuaSprite('coolboppers2', nil, 0, 0)
        screenCenter('coolboppers2')
        scaleObject('coolboppers2', 1.3, 1.3)
        loadFrames('coolboppers2', 'cassette/stage/crowd/boppers2', 'sparrow')
        addAnimationByPrefix('coolboppers2', 'idle', 'crowd', 24, false)
        setProperty('coolboppers2.x', getProperty('coolboppers2.x') - 700)
        setProperty('coolboppers2.y', getProperty('coolboppers2.y') - 110)
        addLuaSprite('coolboppers2')
    end

    makeLuaSprite('bgLayer', 'cassette/stage/BGLAYER')
    setProperty('bgLayer.alpha', (songName == 'Machina' and 1 or 0.001))
    screenCenter('bgLayer')
    scaleObject('bgLayer', 5, 5, false)
    setProperty('bgLayer.y', getProperty('bgLayer.y') - 10)
    setBlendMode('bgLayer', 'overlay')
    addLuaSprite('bgLayer')
end

function onStartCountdown()
    doTweenAlpha('l', 'bgLayer', 1, 1)
end

function onBeatHit()
    playAnim('cgbg', 'idle')

    if songName == 'Soda Groove' then
        playAnim('coolboppersSG1', 'idle')
        playAnim('coolboppersSG2', 'idle')
    else
        playAnim('coolboppers1', 'idle')
        playAnim('coolboppers2', 'idle')
    end
end