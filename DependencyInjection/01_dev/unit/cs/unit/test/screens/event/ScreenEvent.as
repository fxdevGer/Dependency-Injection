/**
 * Copyright 15.10.2010 Christian Sobolewski
 * 
 * usage : screens.event
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.event.ScreenEvent
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.event {
	import com.cs.di.core.mvc.ApplicationEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public class ScreenEvent extends ApplicationEvent {
		public static const PERFORM_CHANGE : String = "PERFORM_CHANGE";		public static const REQUEST_CHANGE : String = "REQUEST_CHANGE";
				public static const PERFORM_LANGUAGE_CHANGE : String = "PERFORM_LANGUAGE_CHANGE";		public static const REQUEST_LANGUAGE_CHANGE : String = "REQUEST_LANGUAGE_CHANGE";
		
		private var _newScreenId : String;
		private var _lang : String;
		private var _screenNr : Number;

		public function ScreenEvent(name : String, newScreenId : String = "", lang : String = "") {
			super(name);
			_newScreenId = newScreenId;
			_lang = lang;
			_screenNr = screenNr;
		}
		
		public function get newScreenId() : String {
			return _newScreenId;
		}
		
		public function get lang() : String {
			return _lang;
		}

		public function get screenNr() : Number {
			return _screenNr;
		}
	}
}
