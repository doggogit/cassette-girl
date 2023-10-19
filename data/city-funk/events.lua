local bopped = false
function onBeatHit()
    bopped = not bopped
    setProperty('iconP1.angle', bopped and 10 or -10)
    setProperty('iconP2.angle', bopped and 10 or -10)

    setProperty('camHUD.zoom', 1.077)
    doTweenZoom('bop', 'camHUD', 1, 0.2)

    setProperty('camHUD.y', 20)
    doTweenY('back', 'camHUD', 0, 0.2, 'quadOut')
end

function onStepHit()
    setProperty('camZooming', false)
end
