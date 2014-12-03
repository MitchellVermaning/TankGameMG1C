﻿package src {	import flash.display.Sprite;	import flash.events.Event;	import flash.geom.Point;		public class Main extends Sprite 	{		public static var tank:Tank;		private var ball:Ball;		private var balls:Vector.<Ball>;		private var enemies:Array;		private var chests:Vector.<Chest>;						public function Main():void 		{			if (stage) init();			else addEventListener(Event.ADDED_TO_STAGE, init);		}				private function init(e:Event = null):void 		{			removeEventListener(Event.ADDED_TO_STAGE, init);			// entry point			tank = new Tank();			enemies = new Array();			for (var i:int = 0; i < 3; i++)			{				var enemy:EnemyTank = new EnemyTank();				enemies.push(enemy);				addChild(enemy);				enemy.x = Math.random()*stage.stageWidth;				enemy.y = Math.random()*stage.stageHeight;				enemy.addEventListener("onShoot", createBullet);							}						this.addChild(tank);						tank.x = 300;			tank.y = 300;												tank.addEventListener("onShoot", createBullet);						balls = new Vector.<Ball>();						chests = new Vector.<Chest>();						createChests();						this.addEventListener(Event.ENTER_FRAME, loop);		}				private function createChests():void		{			for (var i:int = 0; i < 5; i++)			{				var chest:Chest = new Chest();				chests.push(chest);				addChild(chest);				chest.x = Math.random() * stage.stageWidth;				chest.y = Math.random() * stage.stageHeight;				chest.scaleX = chest.scaleY = tank.scaleX;			}		}				private function loop(e:Event):void		{			for (var i:int = 0; i < balls.length; i++)			{								var toRemove:Boolean = false;								balls[i].update();								for (var j:int = 0; j < chests.length; j++)				{					if (chests[j].hitTestPoint(balls[i].x, balls[i].y, true))					{						toRemove = true;												chests[j].lives--;						if (chests[j].lives <= 0) 						{							removeChild(chests[j]);							chests.splice(j, 1);						}					}				}								if (balls[i].x > stage.stageWidth || balls[i].x < 0 || balls[i].y > stage.stageHeight || balls[i].y < 0)				{					toRemove = true;				}								if (toRemove)				{					removeChild(balls[i]);					balls.splice(i, 1);				}			}		}				private function createBullet(e:ShootEvent):void		{						var r:Number = e.shooter.turretAngle + e.shooter.rotation;			var tPos:Point = new Point(e.shooter.x, e.shooter.y);			var b:Ball = new Ball(r, tPos);			balls.push(b);			//b.x = tank.x;			//b.y = tank.y;			addChild(b);			//balls[balls.length - 1].x = tank.x;			//balls[balls.length - 1].y = tank.y;			//b.rotation = tank.turretAngle + tank.rotation; 					}			}	}