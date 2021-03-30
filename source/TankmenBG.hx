package;

import flixel.FlxG;
import flixel.FlxSprite;
import haxe.display.Display.Package;

class TankmenBG extends FlxSprite
{
	public static var animationNotes:Array<Dynamic> = [];

	public var strumTime:Float = 0;
	public var goingRight:Bool = false;
	public var tankSpeed:Float = 0.7;

	public var endingOffset:Float;

	public function new(x:Float, y:Float, isGoingRight:Bool)
	{
		super(x, y);

		// makeGraphic(200, 200);

		frames = Paths.getSparrowAtlas('tankmanKilled1');
		antialiasing = true;
		animation.addByPrefix('run', 'tankman running', 24, true);
		animation.addByPrefix('shot', 'John', 24, false);

		animation.play('run');

		goingRight = isGoingRight;
		endingOffset = FlxG.random.float(50, 200);

		tankSpeed = FlxG.random.float(0.6, 1);

		if (goingRight)
			flipX = true;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (animation.curAnim.name == 'run')
		{
			var endDirection:Float = (FlxG.width * 0.74) + endingOffset;

			if (goingRight)
			{
				endDirection = (FlxG.width * 0.02) - endingOffset;

				x = (endDirection + (Conductor.songPosition - strumTime) * tankSpeed);
			}
			else
			{
				x = (endDirection - (Conductor.songPosition - strumTime) * tankSpeed);
			}
		}

		if (Conductor.songPosition > strumTime)
		{
			// kill();
			animation.play('shot');

			if (goingRight)
			{
				offset.y = 200;
				offset.x = 300;
			}
		}

		if (animation.curAnim.name == 'shot' && animation.curAnim.curFrame >= animation.curAnim.frames.length - 1)
		{
			kill();
		}
	}
}
