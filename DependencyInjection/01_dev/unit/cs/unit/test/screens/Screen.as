/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.Screen
 * @author Christian Sobolewski
 */
package cs.unit.test.screens {
	import flash.display.Sprite;

	/**
	 * @author Christian Sobolewski
	 */
	public class Screen extends Sprite implements IScreen {
		private var _id : String;
		private var _language : String = "de";
		
		public function activate() : void {
		}
		
		public function update() : void {
		}
		
		public function dispose() : void {
		}
		
		public function get id() : String {
			return _id;
		}
		
		public function set id(id : String) : void {
			_id = id;
		}
		
		public function get language() : String {
			return _language;
		}
		
		public function set language(language : String) : void {
			_language = language;
		}
	}
}
