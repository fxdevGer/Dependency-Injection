/**
 * Copyright 15.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : Some utils methods for the Logging Context
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.impl {
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class LogUtils {
		
		/**
		 * 	returns log message
		 */
		
		public static function buildLogMessage(message : String, params : Array) : String {
			if (params == null) return message;
			for (var i : int = 0;i < params.length;i++) {
				var param : * = params[i];
				if (param is Error) {
					var e : Error = param as Error;
					param = "\n" + e.getStackTrace();
				}
				message = message.replace(new RegExp("\\{" + i + "\\}", "g"), param);
			}
			return message;
		}
		
		/**
		 * 	returns log level for a specific given level
		 */
		
		public static function getLevelByName(level : String) : LogLevel {
			return LogLevel[level.toUpperCase()];
			
		}

		/**
		 * 	returns the qualified Class name from param object
		 */
		
		public static function getLogName(object : Object) : String {
			if (object is Class) {
				return getQualifiedClassName(object);
			} else {
				return object.toString();
			}
		}
		
	}
}
