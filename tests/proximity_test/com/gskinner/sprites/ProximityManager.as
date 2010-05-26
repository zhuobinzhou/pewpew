﻿/*** ProximityManager (AS3 Version) by Grant Skinner. Jan 4, 2008* Visit www.gskinner.com/blog for documentation, updates and more free code.** You may distribute and modify this class freely, provided that you leave this header intact,* and add appropriate headers to indicate your changes. Credit is appreciated in applications* that use this code, but is not required.** Please contact info@gskinner.com for more information.**	Modified by Mike Chambers.** You can find Grant's AS3 version (better than this) at:* http://www.gskinner.com/blog/archives/2008/01/proximitymanage.html*/package com.gskinner.sprites {		import flash.utils.Dictionary;	import __AS3__.vec.Vector;	import flash.display.DisplayObject;		//import com.mikechambers.pewpew.engine.gameobjects.DisplayObject;			public class ProximityManager	{			// public properties:		private var gridSize:uint;		private var off:uint;			// private properties:		private var positions:Dictionary = new Dictionary();		private var cachedResults:Dictionary = new Dictionary();			// initialization:		public function ProximityManager(gridSize:uint=25)		{			this.gridSize = gridSize;			off = gridSize*1024;		}				private function concatVectors(a:Vector.<DisplayObject>, b:Vector.<DisplayObject>):Vector.<DisplayObject>		{			for each(var dobj:DisplayObject in b)			{				a.push(dobj);			}						return a;		}					// public methods:	private var counter:int = 0;		public function getNeighbors(mc:DisplayObject):Vector.<DisplayObject>		{			var index:uint = ((mc.x+off)/gridSize)<<11|((mc.y+off)/gridSize); // max of +/- 2^10 (1024) rows and columns.						//vector of display object			if (cachedResults[index])			{				return cachedResults[index];			}						//r is vector of display objects			var r:Vector.<DisplayObject> = positions[index];			if (r == null)			{				r = new Vector.<DisplayObject>();			}						if (positions[index-2048-1]) { concatVectors(r,positions[index-2048-1]); }			if (positions[index-1]) { concatVectors(r,positions[index-1]); }			if (positions[index+2048-1]) { concatVectors(r,positions[index+2048-1]); }						if (positions[index-2048]) { concatVectors(r,positions[index-2048]); }			if (positions[index+2048]) { concatVectors(r,positions[index+2048]); }						if (positions[index-2048+1]) { concatVectors(r,positions[index-2048+1]); }			if (positions[index+1]) { concatVectors(r,positions[index+1]); }			if (positions[index+2048+1]) { concatVectors(r,positions[index+2048+1]); }						//r is a vector of display objects			cachedResults[index] = r;						return r;		}						private function resetDictionary(d:Dictionary):Dictionary		{						for each(var v:Vector.<DisplayObject> in d)			{				v.length = 0;			}						return d;		}				public function refresh(enemies:Vector.<DisplayObject>):void		{			// calculate grid positions:			//var p:Dictionary = new Dictionary();						var p:Dictionary = resetDictionary(positions);						//loopthrough and set vector length to 0;						for each(var mc:DisplayObject in enemies)			{				var index:uint = ((mc.x+off)/gridSize)<<11|((mc.y+off)/gridSize); // max of +/- 2^10 (1024) rows and columns.								if (p[index] == null)				{ 										var v:Vector.<DisplayObject> = new Vector.<DisplayObject>();					v.push(mc);					p[index] = v; 					continue;				}								p[index].push(mc);			}						//reset this			cachedResults = new Dictionary();			positions = p;		}	}}