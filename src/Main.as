﻿package src {	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Point;		public class Main extends Sprite 	{		private var tank:Tank;		private var ball:Ball;		private var balls:Vector.<Ball>;		private var enemies:Array;				public function Main():void 		{			if (stage) init();			else addEventListener(Event.ADDED_TO_STAGE, init);		}				private function init(e:Event = null):void 		{			removeEventListener(Event.ADDED_TO_STAGE, init);			// entry point			enemies = new Array();			for (var i:int = 0; i < 3; i++)			{				var enemy:EnemyTank = new EnemyTank();				enemies.push(enemy);				addChild(enemy);				enemy.x = Math.random()*stage.stageWidth;				enemy.y = Math.random()*stage.stageHeight;							}						tank = new Tank();			this.addChild(tank);						tank.x = 300;			tank.y = 300;												tank.addEventListener("onShoot", createBullet);						balls = new Vector.<Ball>();						this.addEventListener(Event.ENTER_FRAME, loop);		}				private function loop(e:Event):void		{			for (var i:int = 0; i < balls.length; i++)			{								balls[i].update();								if (balls[i].x > stage.stageWidth || balls[i].x < 0 || balls[i].y > stage.stageHeight || balls[i].y < 0)				{					removeChild(balls[i]);					balls.splice(i, 1);				}			}		}				private function createBullet(e:Event):void		{						var r:Number = tank.turretAngle + tank.rotation;			var tPos:Point = new Point(tank.x, tank.y);			var b:Ball = new Ball(r, tPos);			balls.push(b);			//b.x = tank.x;			//b.y = tank.y;			addChild(b);			//balls[balls.length - 1].x = tank.x;			//balls[balls.length - 1].y = tank.y;			//b.rotation = tank.turretAngle + tank.rotation; 					}			}	}