/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage : private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ClassName));
 * 
 * Parameters :	
 *
 * Description : The Logger Class could be used in each Class for logging purposes.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.impl {
	import com.cs.di.core.logger.core.LogContext;

	/**
	 * @author Christian Sobolewski
	 */
	public class Logger implements ILogger {

		protected var _name : String;
		protected var _level : LogLevel;

		public function Logger(name : String, level : LogLevel) {
			_name = name;
			_level = level;
		}
		
		/**
		 * 	logs the given message if <code>LogLevel</code> has permit
		 */
		
		private function log(tLevel : String, message : String, params : Array) : void {
			var s : String = LogUtils.buildLogMessage(message, params);
			LogContext.logger.handleLogEvent(new LogEvent(LogEvent.LOG, LogLevel[tLevel.split(":")[0]], s, name));
		}
		
		/**
		 * 	logs info Messages if permitted
		 */
		
		public function info(message : String, ...params : *) : void {
			if (!isInfoEnabled()) return;
			log("INFO:  ", message, params); 
		}
		
		/**
		 * 	logs debug Messages if permitted
		 */
		
		public function debug(message : String, ...params : *) : void {
			if (!isDebugEnabled()) return;
			log("DEBUG:  ", message, params); 
		}
		
		/**
		 * 	logs warn Messages if permitted
		 */
		
		public function warn(message : String, ...params : *) : void {
			if (!isWarnEnabled()) return;
			log("WARN:  ", message, params); 
		}
		
		/**
		 * 	logs error Messages if permitted
		 */
		
		public function error(message : String, ...params : *) : void {
			if (!isErrorEnabled()) return;
			log("ERROR:  ", message, params); 
		}
		
		/**
		 * 	logs fatal Messages if permitted
		 */
		
		public function fatal(message : String, ...params : *) : void {
			if (!isFatalEnabled()) return;
			log("FATAL:  ", message, params); 
		}
		
		/**
		 * 	logs trace Messages if permitted
		 */
		
		public function trace(message : String, ...params : *) : void {
			if (!isTraceEnabled()) return;
			log("TRACE:  ", message, params);
		}
		
		/**
		 * 	set <code>LogLevel</code> for each Logger instance
		 */
		
		public function set level(level : LogLevel) : void {
			_level = level;
		}
		
		/**
		 * 	level
		 * 	get <code>LogLevel</code> for each Logger instance
		 */
		
		public function get level() : LogLevel {
			return _level;
		}
		
		/**
		 * 	checks if <code>LogLevel.TRACE</code> is enabled
		 */
		
		public function isTraceEnabled() : Boolean {
			return (level.toValue() <= LogLevel.TRACE.toValue());
		}
		
		/**
		 * 	checks if <code>LogLevel.DEBUG</code> is enabled
		 */
		
		public function isDebugEnabled() : Boolean {
			return (level.toValue() <= LogLevel.DEBUG.toValue());
		}
		
		/**
		 * 	checks if <code>LogLevel.INFO</code> is enabled
		 */
		
		public function isInfoEnabled() : Boolean {
			return (level.toValue() <= LogLevel.INFO.toValue());
		}
		
		/**
		 * 	checks if <code>LogLevel.WARN</code> is enabled
		 */
		
		public function isWarnEnabled() : Boolean {
			return (level.toValue() <= LogLevel.WARN.toValue());
		}
		
		/**
		 * 	checks if <code>LogLevel.ERROR</code> is enabled
		 */
		
		public function isErrorEnabled() : Boolean {
			return (level.toValue() <= LogLevel.ERROR.toValue());
		}
		
		/**
		 * 	checks if <code>LogLevel.FATAL</code> is enabled
		 */
		
		public function isFatalEnabled() : Boolean {
			return (level.toValue() <= LogLevel.FATAL.toValue());
		}
		
		/**
		 * 	returns the <code>Logger</code> name
		 */
		
		public function get name() : String {
			return _name;
		}
	}
}
