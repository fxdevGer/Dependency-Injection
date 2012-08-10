/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens.models
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.models.ScreenModel
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.models {
	import cs.unit.test.screens.Screen;
	/**
	 * @author Christian Sobolewski
	 */
	public class ScreenModel {
		
		private var _screenId : String;
		private var _screens : Array = [];
		
		public function set screenId(screenId : String) : void {			
			_screenId = screenId;
		}

		public function get screenId() : String {
			return _screenId;
		}
		
		public function set registerScreen(screen : Screen) : void {
			_screens.push(screen);
		}
		
		public function getScreenByName(name : String) : Screen {
			for each (var s : Screen in screen) {
				if (name == s.id) return s;
			}
			return null;
		}
		
		public function get screen() : Array {
			return _screens;
		}
		
	}
}
