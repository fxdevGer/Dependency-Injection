/**
 * Copyright 05.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The DefaultLogFactory is the Factory for the Logger Component.
 * 				 It creates Logger`s, ads LogLevel`s, returns each Logger. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.core {
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.logger.impl.LogLevel;
	import com.cs.di.core.logger.impl.LogUtils;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;

	/**
	 * @author Christian Sobolewski
	 */
	public class DefaultLogFactory implements ILogFactory {
		protected static var _loggers : Dictionary = new Dictionary();		protected static var _logLevels : Dictionary = new Dictionary();
		protected var rootLogLevel : LogLevel;

		public function DefaultLogFactory() {
			rootLogLevel = LogLevel.OFF; // set the default LogLevel so that at the start each Logger can log.
		}
		
		/**
		 * 	sets Root LogLevel just used for starting loggging.
		 * 	After refreshLoggerLevels() all <code>Loggers</code> have their own <code>LogLevels</code>
		 */
		
		public function setRootLogLevel(level : LogLevel) : void {
			rootLogLevel = level;
		}
		
		/**
		 *	creates the <code>LoggerSocket</code> used for sending messages over XMLSocket
		 */
		
		public function createObject(name : String, id : String) : LoggerSocket {
			var ClassReference : Class = getDefinitionByName(name) as Class;
			return new ClassReference();
		}
		
		/**
		 *	adds for each LoggerName that depends its <code>LogLevel</code>
		 */
		
		public function addLogLevel(loggerName : String, log : LogLevel) : void {
			_logLevels[loggerName] = log;
		}
		
		/**
		 *	returns the <code>Logger</code> if not created then created
		 */
		
		public function getLogger(name : Object) : Logger {
			var nameStr : String = LogUtils.getLogName(name);
			if (loggers[nameStr] != undefined) {
				return Logger(loggers[nameStr]);
			} else {
				return createLogger(nameStr);
			}
		}
		
		/**
		 *	returns the created <code>Logger</code>
		 */
		
		private function createLogger(name : String) : Logger {
			var level : LogLevel = findLevel(name);
			var log : Logger = new Logger(name, level);
			loggers[name] = log;
			return log;
		}
		
		/**
		 *	searches for a <code>LogLevel</code> by a given name
		 */
		
		private function findLevel(name : String) : LogLevel {
			if (_logLevels[name] != undefined) {
				return LogLevel(_logLevels[name]);
			}
			var parentNS : String = getParentNameSpace(name);
			if (parentNS != null) {
				return findLevel(parentNS);
			} else if (rootLogLevel != null) {
				return rootLogLevel;
			} else {
			 	throw new ConfigurationError("No configuration found for Logger - name = " + name);
			}
		}
		
		/**
		 *	searches for a <code>LogLevel</code> by a given package name
		 */
		
		private function getParentNameSpace(name : String) : String {
			var idx : int = name.lastIndexOf("::"); // needed for fully qualified class names
			if (idx == -1) {
				idx = name.lastIndexOf(".");
			}
			if (idx == -1) return null;
			else return name.substring(0, idx);
		}
		
		/**
		 *	returns all <code>Logger</code> as Dictionary
		 */
		
		public function get loggers() : Dictionary {
			return _loggers;
		}
		
		/**
		 *	refreshes each <code>Logger</code> with the new <code>LogLevel</code> found in log node
		 */
		
		public function refreshLoggerLevels() : void {
			for each (var log:Logger in loggers) {
				log.level = findLevel(log.name);
			}
		}
	}
}
