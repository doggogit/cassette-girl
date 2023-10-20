import flixel.addons.transition.FlxTransitionableState as FlxTrans;
import flixel.util.FlxStringUtil as StrUtil;

var casFake;

function onCreatePost()
{
	if (PlayState.isStoryMode)
	{
		casFake = new FlxSprite(game.dad.x - 1, game.dad.y);
		casFake.frames = Paths.getSparrowAtlas('cassette/cutscenes/transition/cassettegirl-chill');
		casFake.animation.addByPrefix('swap', 'cassettegirl-chill', 24, false);
		insert(game.members.indexOf(game.dadGroup) + 1, casFake);
		casFake.alpha = 0.001;
		casFake.antialiasing = true;
		
		Paths.inst('machina');
		Paths.voices('machina');
	}
	return;
}

var endedSong = false;
var canEnd = false;
var curPos = 0;
var fakeBeat = var lastBeat = 0;
var fakeBpm = 0;

function onEndSong()
{
	if (PlayState.isStoryMode && !canEnd)
	{
		FlxTrans.skipNextTransIn = FlxTrans.skipNextTransOut = true;
		
		endedSong = true;
		fakeBpm = Conductor.bpm;
		game.updateTime = false;
		
		FlxG.sound.playMusic(Paths.music('breakfast', 0));
		
		game.dad.visible = false;
		casFake.alpha = 1;
		casFake.animation.play('swap');
		casFake.animation.finishCallback = function()
		{
			new FlxTimer().start(0.3, function()
			{
				canEnd = true;
				game.endSong();
			});
			casFake.destroy();
			game.dad.visible = true;
		}
		
		FlxG.sound.playMusic(Paths.sound('rewind'));
		
		game.camHUD.zoom = 1; // just incase
		
		game.defaultCamZoom = 0.85;
		FlxTween.tween(game.camGame, {zoom: 0.85}, (Conductor.stepCrochet * 16) / 1000, {ease: FlxEase.quadInOut});
		
		for (item in [game.iconP1, game.iconP2, game.healthBar, game.healthBar.bg, game.scoreTxt])
			FlxTween.tween(item, {alpha: 0}, (Conductor.stepCrochet * 16) / 1000, {ease: FlxEase.quadInOut});
			
		for (strum in game.strumLineNotes)
			FlxTween.tween(strum, {alpha: 0}, 1, {ease: FlxEase.quadInOut});
			
		FlxTween.tween(game.camFollow, {x: 423, y: 640}, (Conductor.stepCrochet * 16) / 1000, {ease: FlxEase.quadInOut});
		
		new FlxTimer().start(0.8, function()
		{
			FlxTween.num(0, 122000, 2, {
				onUpdate: function(tween:FlxTween)
				{
					curPos = tween.value;
				},
				onComplete: function()
				{
					curPos = 121000; // should prevent it from stopping at 2:00 maybe
				}
			});
		});
		return Function_Stop;
	}
	return Function_Continue;
}

var usePos = 0;
var nextSongLength = 121000;

function onUpdatePost()
{
	if (endedSong)
	{
		game.timeBar.visible = true;
		game.timeBar.bg.visible = true;
		game.timeTxt.visible = true;
		
		usePos = (curPos != null ? curPos : 0);
		
		game.timeTxt.text = StrUtil.formatTime(usePos / 1000);
		game.timeBar.percent = Math.abs(((usePos / nextSongLength) * 100) - 100);
		
		var fakePos = FlxG.sound.music.time;
		fakeBeat = (Math.ceil((fakePos / 5000) * (fakeBpm / 12)) - 1); // fake beat hits??? fuck!!!!
		if (fakeBeat != lastBeat)
		{
			lastBeat = fakeBeat;
			fakeBeatHit();
		}
	}
}

function fakeBeatHit()
{
	game.modchartSprites['coolboppers1'].animation.play('idle');
	game.modchartSprites['coolboppers2'].animation.play('idle');
	
	if (fakeBeat == 0)
		game.gf.danced = true;
		
	game.gf.dance();
	if (fakeBeat % 2 == 0)
	{
		game.boyfriend.dance();
		game.dad.dance();
	}
}
