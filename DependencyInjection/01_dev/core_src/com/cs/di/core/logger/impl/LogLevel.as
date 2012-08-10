/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The LogLevel Class defines each LogLevel
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.impl {

	/**
	 * @author Christian Sobolewski
	 */
	public class LogLevel {

		public static const OFF : LogLevel = new LogLevel(7, "OFF");

		public static const FATAL : LogLevel = new LogLevel(6, "FATAL");

		public static const ERROR : LogLevel = new LogLevel(5, "ERROR");

		public static const WARN : LogLevel = new LogLevel(4, "WARN");

		public static const INFO : LogLevel = new LogLevel(3, "INFO");

		public static const DEBUG : LogLevel = new LogLevel(2, "DEBUG");

		public static const TRACE : LogLevel = new LogLevel(1, "TRACE");

		private var _value : uint;
		private var _string : String;

		public function LogLevel(value : uint, name : String) {
			_value = value;
			_string = name;
		}
		
		/**
		 * 	returns LogLevel as uint
		 */
		
		public function toValue() : uint {
			return _value;
		}
		
		/**
		 * 	returns LogLevel as String
		 */
		
		public function toString() : String {
			return _string;
		}
	}
}
