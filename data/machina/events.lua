function onCreatePost()
	if isStoryMode and not seenCutscene then
		setProperty('timeBar.alpha', 1)
		setProperty('timeBar.bg.alpha', 1)
		setProperty('timeTxt.alpha', 1)
	end
end

local things = {'iconP1', 'iconP2', 'scoreTxt', 'healthBar', 'healthBar.bg'}
function onStartCountdown()
    if isStoryMode and not seenCutscene then 
		setProperty('skipCountdown', true)

        setProperty('camFollow.x', 423)
        setProperty('camFollow.y', 640)
		setProperty('cameraSpeed', 50) -- I wont yield!!!

		doTweenX('leMoveX', 'camFollow', 483.5, stepCrochet * 16 / 1000, 'quadInOut')
        doTweenY('leMoveY', 'camFollow', 577.5, stepCrochet * 16 / 1000, 'quadInOut')
		
		setProperty('camGame.zoom', 0.85)
		doTweenZoom('bleh!!!', 'camGame', 0.7, stepCrochet * 16 / 1000, 'quadInOut')
		
		for _,thing in pairs(things) do
			setProperty(thing..'.alpha', 0)
			doTweenAlpha('in'..thing, thing, 1, stepCrochet * 16 / 1000, 'quadInOut')
		end
    end
end

function onSongStart()
	if isStoryMode and not seenCutscene then
		setProperty('cameraSpeed', 1)
		for i = 0, 7 do
			setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
			noteTweenAlpha('strumIn'..i, i, 1, 0.7, 'quadInOut')
		end
	end
end

local doHitZoom = false
function goodNoteHit(i, d, t, s)
	if not s and doHitZoom then
		setProperty('camHUD.zoom', 1.035)
		doTweenZoom('backOut', 'camHUD', 1, 0.2)
	end
end

local things = {'iconP1', 'iconP2', 'scoreTxt', 'healthBar', 'healthBar.bg'}
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