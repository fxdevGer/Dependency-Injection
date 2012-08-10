/**
 * Copyright 10.08.2011 Christian Sobolewski
 * 
 * Usage :	
 * 			
 * Parameters:
 * 	
 * Description:
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
	import com.cs.di.core.mvc.ApplicationEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public class InputEvent extends ApplicationEvent {
		
		public static const KEY : String = "KEY";
		public static const MOUSE : String = "MOUSE";
		public static const CLICK : String = "CLICK";
		
		private var _data : InputData;
		
		public function InputEvent(name : String, data : InputData = null) {
			super(name);
			_data = data;
		}

		public function get data() : InputData {
			return _data;
		}
	}
}
