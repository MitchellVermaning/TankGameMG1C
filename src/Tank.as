﻿package src {	import flash.events.KeyboardEvent;	import flash.display.MovieClip;	import flash.events.Event;	import flash.geom.Point;	import flash.ui.Keyboard;	import flash.events.MouseEvent;	public class Tank extends TankBase	{		/*		private var tankBodyArt:MovieClip;		private var tankTurretArt:TankTurretArt;		VERPLAATST NAAR TANKBASE		*/		private var controlDir:Point;		private var speed:Number = 0;				/*		public var turretAngle:Number = 0;		VERPLAATST		*/		public function Tank() 		{			this.addEventListener(Event.ADDED_TO_STAGE, init);						/*			tankBody = new TankBodyArt(); //instantieren van de class			this.addChild(tankBody); //class op het scherm zetten binnen Tank.as						tankTurretArt = new TankTurretArt();			this.addChild(tankTurretArt);			VERPLAATST			*/						controlDir = new Point(0,0);			//this.scaleX = this.scaleY = 0.2;		}				private function init(e:Event):void 		{			removeEventListener(Event.ADDED_TO_STAGE, init);			stage.addEventListener(KeyboardEvent.KEY_DOWN, Down);			stage.addEventListener(KeyboardEvent.KEY_UP, Up);			//this.addEventListener(Event.ENTER_FRAME, loop); //verplaatsen naar tankbase			stage.addEventListener(MouseEvent.CLICK, onClick);		}				private function onClick(e:MouseEvent):void		{			var se:ShootEvent = new ShootEvent("onShoot");			se.shooter = this;			dispatchEvent(se);		}				override public function loop(e:Event):void 		{			//this.x += controlDir.x * 5;			//this.y += controlDir.y * 5;			speed = controlDir.y * -5;						this.rotation += controlDir.x * 3;			var radian:Number = this.rotation * Math.PI / 180;										// van graden naar radians			var xMove:Number = Math.cos(radian);			var yMove:Number = Math.sin(radian);			this.x += xMove * speed;			this.y += yMove * speed;						targetPosition.x = mouseX;			targetPosition.y = mouseY;			super.loop(e);						if (Main.tank.x >= stage.stageWidth) 				{					//controlDir.y = 0;					//controlDir.x = 0;					//trace("ff");				}		}														private function Up(e:KeyboardEvent):void 		{			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W)			{				controlDir.y = 0;			}			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)			{				controlDir.y = 0;			}			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)			{				controlDir.x = 0;			}			if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)			{				controlDir.x = 0;			}		}				private function Down(e:KeyboardEvent):void 		{			if (e.keyCode == Keyboard.UP || e.keyCode == Keyboard.W) 			{				controlDir.y = -1;			}			if (e.keyCode == Keyboard.DOWN || e.keyCode == Keyboard.S)			{				controlDir.y = 1;			}			if (e.keyCode == Keyboard.LEFT || e.keyCode == Keyboard.A)			{				controlDir.x = -1;			}			if (e.keyCode == Keyboard.RIGHT || e.keyCode == Keyboard.D)			{				controlDir.x = 1;							}		}				override public function destroy():void		{			stage.removeEventListener(KeyboardEvent.KEY_DOWN, Down);			stage.removeEventListener(KeyboardEvent.KEY_UP, Up);			stage.removeEventListener(MouseEvent.CLICK, onClick);			super.destroy();		}			}}