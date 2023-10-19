import flixel.util.FlxTimer;
var cgLightB;
var cgLightD;
var lightsCam;
function onCreatePost(){
    lightsCam = new FlxCamera();
	lightsCam.bgColor = 0x00;
	FlxG.cameras.add(lightsCam, false);
    game.modchartSprites['bgLayer'].camera = lightsCam;

	for (cam in [game.camHUD, game.camOther])
	{
		FlxG.cameras.remove(cam, false);
		FlxG.cameras.add(cam, false);
	}

    if(ClientPrefs.data.flashing)
    {
    	cgLightB = new FlxSprite();
	    cgLightD = new FlxSprite();
	    for (spr in [cgLightB, cgLightD])
        {
        	spr.loadGraphic(Paths.image('cassette/hud/NOTE_LIGHT'));
        	spr.screenCenter();
        	spr.scale.set(0.81, 0.81);
        	spr.alpha = 0.001;
        	spr.camera = lightsCam;
        	add(spr);
        }
    }
    return;
}

function goodNoteHit(note){
    if(!note.isSustainNote){
        
        noteLight(true, note.noteData);
    }
    return;
}

function opponentNoteHit(note){
    if(!note.isSustainNote && StringTools.endsWith(game.dad.animation.curAnim.name, '-alt'))
        noteLight(false, note.noteData);
    return;
}

var colors = [0xFFc24b99, 0xFF00ffff, 0xFF12fa05, 0xFFf9393f];
var tmrB;
var tmrD;
function noteLight(isPlayer, direct)
{
    var spr = (isPlayer ? cgLightB : cgLightD);
    var timer = (isPlayer ? tmrB : tmrD);

    if(spr == null) return;
    if(timer != null)
        timer.cancel();
   
    FlxTween.cancelTweensOf(spr);
    FlxTween.cancelTweensOf(spr.scale); // i swear :pensive:
    
    spr.alpha = 1;
    spr.scale.set(0.81, 0.81);
    spr.color = colors[direct];
   
    timer = new FlxTimer().start(0.1, function()
    {
        timer = null;
        FlxTween.tween(spr.scale, {x: 1, y: 1}, 0.8, {ease: FlxEase.cubeOut});
        FlxTween.tween(spr, {alpha: 0}, 4, {ease: FlxEase.cubeOut});
    });
}