package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;
import box2D.collision.shapes.B2Shape;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class SceneEvents_0 extends SceneScript
{
	public var _Startingtext:Bool;
	public var _Points:Float;
	public var _Gameover:Bool;
	public var _LevelWin:Bool;
	
	
	public function new(dummy:Int, dummy2:Engine)
	{
		super();
		nameMap.set("Starting text", "_Startingtext");
		_Startingtext = false;
		nameMap.set("Points", "_Points");
		_Points = 0.0;
		nameMap.set("Game over", "_Gameover");
		_Gameover = false;
		nameMap.set("Level Win", "_LevelWin");
		_LevelWin = false;
		
	}
	
	override public function init()
	{
		
		/* ======================== Specific Actor ======================== */
		addWhenKilledListener(getActor(3), function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				createRecycledActor(getActorType(23), 300, 240, Script.FRONT);
				recycleActor(getActor(17));
				recycleActor(getActor(16));
				recycleActor(getActor(15));
				recycleActor(getActor(14));
				_Gameover = true;
				propertyChanged("_Gameover", _Gameover);
			}
		});
		
		/* ======================== Sound is done ========================= */
		addSoundListener(getSound(35), function(list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				for(index0 in 0...Std.int(9999))
				{
					
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(getFont(31));
				g.drawString("" + Engine.engine.getGameAttribute("Enemies Killed"), 120, 15);
				g.setFont(getFont(31));
				g.drawString("" + "Score:", 10, 10);
				g.setFont(getFont(31));
				g.drawString("" + "Press Spacebar to shoot!", 210, 390);
				if(_Gameover)
				{
					g.drawString("" + "Game Over, Press 'enter' to try again", 0, 170);
				}
			}
		});
		
		/* =========================== Keyboard =========================== */
		addKeyStateListener("enter", function(pressed:Bool, released:Bool, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && pressed)
			{
				if(_Gameover)
				{
					reloadCurrentScene(createFadeOut(.5, Utils.getColorRGB(0,0,0)), createFadeIn(.5, Utils.getColorRGB(0,0,0)));
					_Gameover = false;
					propertyChanged("_Gameover", _Gameover);
				}
			}
		});
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((Engine.engine.getGameAttribute("Enemies Killed") == 2))
				{
					_LevelWin = true;
					propertyChanged("_LevelWin", _LevelWin);
				}
				if(_LevelWin)
				{
					g.drawString("" + "Level 1 completed! Good Job!", 100, 170);
					recycleActor(getActor(17));
					recycleActor(getActor(16));
					recycleActor(getActor(15));
					recycleActor(getActor(14));
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}