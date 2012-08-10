/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage : IEventDispatch.dispatch(new LogEvent(LogEvent.*, logLevel, message, name));
 * 
 * Parameters :	
 *
 * Description : The LogEvent Class will be used if a Logger instance want to log a message.
 * 				 Only in use internal by the Framework.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.impl {
	import flash.events.Event;

	/**
	 * @author Christian Sobolewski
	 */
	public class LogEvent extends Event {
		public static const LOG : String = "log";
		private var _level : LogLevel;
		private var _message : String;
		private var _name : String;

		public function LogEvent(type : String, level : LogLevel, message : String, name : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			_level = level;
			_message = message;
			_name = name;
		}

		/**
		 * 	returns the <code>LogLevel</code> for this LogEvent
		 */
		 
		public function get level() : LogLevel {
			return _level;
		}
		
		/**
		 * 	returns the message for this <code>LogEvent</code>
		 */
		
		public function get message() : String {
			return _message;
		}
		
		/**
		 * 	returns the name for this <code>LogEvent</code>
		 */
		
		public function get name() : String {
			return _name;
		}
		
	}
}
