/**
 * Copyright 12.07.2007 Christian Sobolewski
 *
 * Usage:	var fps : FPS = new FPS({bg:0x000033, textColor:0xffcc00});
 *			addChild(fps);
 *			
 *			fps.garbageCollection();
 *
 * Parameters : themeObject as Object
 *
 * Description : Frames per second, Memory usage and the flash plugin version
 *
 * Version : 	1.6 Refactored : benchmark() Method no longer used.
 * 				added min / max Memory
 * 				added GC Free
 * 				added VM Version
 * 		
 * History : 1.5 Refactored obj argument in benchmark removed
 * 			 1.4 Refactored to a none Singleton Class
 * 			 1.3 Added Plugin Detection
 *			 1.2 Added Memory Usage
 * 			 1.1 Added deconstructor method
 *  		 1.0  
 */
package com.cs.utils.fps {
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.Capabilities;
	import flash.system.System;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getTimer;

	public class FPS extends Sprite {
		private var _fpsText : TextField;
		private var _fpsLabel : TextField;
		private var _time : uint;
		private var _theme : Object = {bg:0x000033, textColor:0xffcc00};
		private var _mem_max : Number;
		private var _mem : Number;
		private var _fps : uint;
		private var _ms_prev : uint;
		private var _mem_free : Number;
		private var _gpuDriver : String = "n/a";

		public function FPS(theme : Object = null) {
			if (theme) {
				if (theme.bg != null) _theme.bg = theme.bg;
				if (theme.textColor != null) _theme.textColor = theme.textColor;
			}

			initFPS();
		}

		private function initFPS() : void {
			_time = 0;

			_fpsText = new TextField();
			_fpsText.autoSize = TextFieldAutoSize.LEFT;
			_fpsText.textColor = _theme.textColor;
			_fpsText.antiAliasType = AntiAliasType.ADVANCED;

			_fpsText.background = true;
			_fpsText.backgroundColor = _theme.bg;
			
			_fpsLabel = new TextField();
			_fpsLabel.autoSize = TextFieldAutoSize.LEFT;
			_fpsLabel.textColor = _theme.textColor;
			_fpsLabel.antiAliasType = AntiAliasType.ADVANCED;

			_fpsLabel.background = true;
			_fpsLabel.backgroundColor = _theme.bg;
			_fpsLabel.text = "FPS:"+"\nRAM:"+ "\nPLUGIN:"+ "\nVM Version:"+"\nGPU Driver: ";
			
			_fpsText.x = _fpsLabel.width;

			addChild(_fpsText);
			addChild(_fpsLabel);

			addEventListener(Event.ENTER_FRAME, benching, false, 0, true);
		}

		/**
		 * 	benches actually fps 
		 */
		private function benching(event : Event) : void {
			_time = getTimer();

			if (_time - 1000 > _ms_prev ) {
				_ms_prev = _time;
				_mem = Number((System.totalMemory * 0.000000954).toFixed(0));
				_mem_max = _mem_max > _mem ? _mem_max : _mem;
				
//				_mem_free = Number((System.freeMemory * 0.000000954).toFixed(0));
				
				_fpsText.text = _fps + " / " + stage.frameRate + "\n" + _mem + " / " + _mem_max +" MB" + "\n" + Capabilities.version + "\n"+System.vmVersion+ "\n"+gpuDriver;

				_fps = 0;
			}

			_fps++;
		}

		/**
		 * 	frees memory and removes all listener
		 */
		public function garbageCollection() : void {
			if (hasEventListener(Event.ENTER_FRAME)) removeEventListener(Event.ENTER_FRAME, benching, false);

			_time = undefined;
			_mem = undefined;
			_mem_max = undefined;
			_ms_prev = undefined;
			_fps = undefined;
			_mem_free = undefined;
			_gpuDriver = undefined;

			if (contains(_fpsText)) removeChild(_fpsText);
			if (contains(_fpsLabel)) removeChild(_fpsLabel);

			_fpsText = null;
			_fpsLabel = null;

			delete this;
		}

		public function get gpuDriver() : String {
			return _gpuDriver;
		}

		public function set gpuDriver(gpuDriver : String) : void {
			_gpuDriver = gpuDriver;
		}
	}
}
