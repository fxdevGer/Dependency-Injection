/**
 * Copyright 11.08.2011 Christian Sobolewski
 * 
 * Usage :	var input : Input = new Input();
 * 			input.dispatchMouse = true | false;
 * 			input.dispatchClick = true | false;
 * 			input.mouseHide = true | false;
 * 			input.registerKeyEvent = Num_0 example
			input.stage = stage;
			input.configureListener();
 * 			
 * Parameters:
 * 	
 * Description:
 * 			
 * 			- creates a new Input Control. 
 * 
 * Author:
 * 		 	Christian Sobolewski
 * 			11.08.2011
 *
 * Version: - 1.3 Added AutoFireDelay functionality 
 *
 * History:
 * 			- 1.2 Fixed setting _keyStatus before InputEvent will fired
 * 			- 1.1 Moved into Dependency Injection utils package
 * 			- 1.0
 */
package com.cs.utils.input {
	import flash.events.Event;

	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.mvc.FrontController;

	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class Input {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(Input));
		private var _stage : Stage;
		private var _key : KeyObject;
		private var _autoFireKeyDelay : AutoFireKeyDelay;
		private var _keyStatus : Dictionary;
		private var _keyAutoFire : Dictionary;
		private var _keyEvents : Dictionary;
		private var _dispatchMouse : Boolean;
		private var _dispatchClick : Boolean;
		private var _oef : Sprite;

		public function Input() {
			_keyStatus = new Dictionary();
			_keyEvents = new Dictionary();
			_keyAutoFire = new Dictionary();
			_dispatchMouse = false;
			_dispatchClick = false;
		}

		/**
		 * 	configureListener adds Listener to Stage Object
		 */
		public function configureListener() : void {
			for each (var key : Object in KeyCommand.ALL_COMMANDS) {
				_keyStatus[key] = false;
			}

			for each (var keyInt : uint in KeyCommand.MAPPING_COMMANDS) {
				if (autoFireKeyDelay.autoFireKeyDelayDic[keyInt] != null) {
					_keyAutoFire[keyInt] = autoFireKeyDelay.autoFireKeyDelayDic[keyInt];
				} else _keyAutoFire[keyInt] = 0;
			}

			stage.addEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, handleMouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleMouseEvent);
			stage.addEventListener(MouseEvent.CLICK, handleMouseEvent);

			_key = new KeyObject(stage);
			_oef = new Sprite();
			_oef.addEventListener(Event.ENTER_FRAME, handleKeyDetection);
		}

		/**
		 * 	removeListener removes Listener from Stage Object
		 */
		public function removeListener() : void {
			if (_key) _key.deconstruct();
			if (_oef) if (_oef.hasEventListener(Event.ENTER_FRAME)) _oef.removeEventListener(Event.ENTER_FRAME, handleKeyDetection);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, handleMouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_DOWN, handleMouseEvent);
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleMouseEvent);
			stage.removeEventListener(MouseEvent.CLICK, handleMouseEvent);
		}

		/**
		 * 	handleMouseEvent on stage : Fires MouseEvent.CLICK 
		 */
		private function handleMouseEvent(event : MouseEvent) : void {
			if (dispatchClick) {
				var inputData : InputData = new InputData();
				inputData.cursorX = event.stageX;
				inputData.cursorY = event.stageY;
				inputData.eventType = event.type;
				FrontController.root().dispatchEvent(new InputEvent(InputEvent.CLICK, inputData));
			}
		}

		/**
		 * 	handleMouseMove : dispatches new InputEvent 
		 */
		private function handleMouseMove(event : MouseEvent) : void {
			if (dispatchMouse) {
				var inputData : InputData = new InputData();
				inputData.cursorX = event.stageX;
				inputData.cursorY = event.stageY;
				FrontController.root().dispatchEvent(new InputEvent(InputEvent.MOUSE, inputData));
			}
		}

		/**
		 * 	handleKeyDection : used if any key has a key delay
		 */
		private function handleKeyDetection(event : Event) : void {
			for each (var keyCode : uint in KeyCommand.MAPPING_COMMANDS) {
				var command : String = KeyCommand.ALL_COMMANDS[keyCode];
				var inputData : InputData;

				if (_key.isDown(keyCode) && _keyAutoFire[keyCode] >= 0) {
					if (_keyAutoFire[keyCode] == 0) {
						_keyStatus[command] = true;

						if (_keyEvents[keyCode] != null) {
							inputData = new InputData();
							inputData.keyCommand = command;
							inputData.eventType = KeyboardEvent.KEY_DOWN;
							// log.info('InpuData fired: ' + (inputData) + " with delay " + autoFireKeyDelay);

							FrontController.root().dispatchEvent(new InputEvent(InputEvent.KEY, inputData));
						}

						_keyAutoFire[keyCode] = (autoFireKeyDelay.autoFireKeyDelayDic[keyCode] != null) ? autoFireKeyDelay.autoFireKeyDelayDic[keyCode] : 0;
					} else {
						_keyStatus[command] = false;
						_keyAutoFire[keyCode]--;
					}
				} else {
					_keyStatus[command] = false;
					
//					inputData = new InputData();
//					inputData.keyCommand = command;
//					inputData.eventType = KeyboardEvent.KEY_UP;
//					FrontController.root().dispatchEvent(new InputEvent(InputEvent.KEY, inputData));
					
					_keyAutoFire[keyCode] = (autoFireKeyDelay.autoFireKeyDelayDic[keyCode] != null) ? autoFireKeyDelay.autoFireKeyDelayDic[keyCode] : 0;
				}
			}
			// log.warn("-------------------------------------------------------");
		}

		/**
		 * 	mouseHide : activates Mouse Cursor or hides it
		 */
		public function set mouseHide(value : Boolean) : void {
			if (value) Mouse.hide();
			else Mouse.show();
		}

		/**
		 * 	keyStatus : return Dictionary that maps to KeyCommand.COMMANDS
		 */
		public function get keyStatus() : Dictionary {
			return _keyStatus;
		}

		/**
		 * 	registerKeyEvent : triggers a single key Event
		 */
		public function set registerKeyEvent(key : String) : void {
			_keyEvents[KeyCommand.getKeyByString(key)] = key;
		}

		/**
		 * 	dispatchMouse : if true <code>FrontController.root()</code> dispatches InputEvent.MOUSE default = false
		 */
		public function get dispatchMouse() : Boolean {
			return _dispatchMouse;
		}

		/**
		 * 	dispatchMouse : if true <code>FrontController.root()</code> dispatches InputEvent.CLICK default = false
		 */
		public function set dispatchMouse(dispatchMouse : Boolean) : void {
			_dispatchMouse = dispatchMouse;
		}

		public function get dispatchClick() : Boolean {
			return _dispatchClick;
		}

		public function set dispatchClick(dispatchClick : Boolean) : void {
			_dispatchClick = dispatchClick;
		}

		/**
		 * 	stage : sets and returns Stage 
		 */
		public function get stage() : Stage {
			return _stage;
		}

		public function set stage(stage : Stage) : void {
			_stage = stage;
		}

		public function get autoFireKeyDelay() : AutoFireKeyDelay {
			return _autoFireKeyDelay;
		}

		public function set autoFireKeyDelay(autoFireKeyDelay : AutoFireKeyDelay) : void {
			_autoFireKeyDelay = autoFireKeyDelay;
		}
	}
}
