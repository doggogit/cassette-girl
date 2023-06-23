function onStartCountdown() -- i dont know i dont like using camFollowPos since it doesnt exist in 0.7b | i need to figure out something better
    if isStoryMode then
        setProperty('camFollowPos.x', getMidpointX('dad') + 200)

        setProperty('camFollowPos.y', getMidpointY('dad') - 100)
        setProperty('camFollowPos.y', getProperty('camFollowPos.y') + getProperty('dad.cameraPosition[1]')) 
        
        setProperty('skipCountdown', true)
    end
end

local doHitZoom = false
function goodNoteHit(i, d, t, s)
	if not s and doHitZoom then
		setProperty('camHUD.zoom', 1.035)
		doTweenZoom('backOut', 'camHUD', 1, 0.2)
	end
end

local things = {'iconP1', 'iconP2', 'scoreTxt', 'healthBar', 'healthBarBG'}
function onStepHit()
	setProperty('camZooming', not doHitZoom)
	if curStep == 639 then
		doHitZoom = true
		setProperty('defaultCamZoom', 0.79)
		doTweenZoom('alting', 'camGame', 0.79, stepCrochet * 16 / 1000, 'quadInOut')
		for _,thing in pairs(things) do
			doTweenAlpha('fadeOut'..thing, thing, 0, stepCrochet * 16 / 1000, 'quadInOut')
		end
	elseif curStep == 968 then
		doHitZoom = false
		setProperty('defaultCamZoom', 0.7)
		for _,thing in pairs(things) do
			doTweenAlpha('fadeIn'..thing, thing, 1, stepCrochet * 16 / 1000, 'quadInOut')
		end
	end
end