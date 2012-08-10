/**
 * Copyright 12.08.2011 Christian Sobolewski
 * 
 * Usage :	var inputData : InputData = new InputData();
 * 			inputData.cursorX = event.stageX;
 *			inputData.cursorY = event.stageY;
 *			FrontController.root().dispatchEvent(new InputEvent(InputEvent.MOUSE, inputData));
 * 			
 * Parameters:
 * 	
 * Description:
 * 			
 * 			- holds Input Data which will be dispatched thru FrontController. 
 * 
 * Author:
 * 		 	Christian Sobolewski
 * 			12.08.2011
 *
 * Version: - 1.1 Moved into Dependency Injection utils package
 * 			
 *
 * History:
 * 			- 1.0
 */
package com.cs.utils.input {
	/**
	 * @author Christian Sobolewski
	 */
	public class InputData {
		
		private var _cursorX : Number;
		private var _cursorY : Number;
		
		private var _keyCommand : String;
		private var _keyCommandValue : Boolean;
		private var _eventType : String;
		
		public function InputData() {
		}

		public function get cursorX() : Number {
			return _cursorX;
		}

		public function set cursorX(cursorX : Number) : void {
			_cursorX = cursorX;
		}

		public function get cursorY() : Number {
			return _cursorY;
		}

		public function set cursorY(cursorY : Number) : void {
			_cursorY = cursorY;
		}

		public function get keyCommand() : String {
			return _keyCommand;
		}

		public function set keyCommand(keyCommand : String) : void {
			_keyCommand = keyCommand;
		}

		public function get eventType() : String {
			return _eventType;
		}

		public function set eventType(eventType : String) : void {
			_eventType = eventType;
		}

		public function get keyCommandValue() : Boolean {
			return _keyCommandValue;
		}

		public function set keyCommandValue(keyCommandValue : Boolean) : void {
			_keyCommandValue = keyCommandValue;
		}
		
	}
}
