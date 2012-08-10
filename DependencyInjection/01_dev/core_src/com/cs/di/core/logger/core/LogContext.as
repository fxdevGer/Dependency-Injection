/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage :	private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ClassName));
 * 
 * Parameters :	
 *
 * Description : The LogContext is the base Class for Logging.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.core {
	import com.cs.di.core.logger.impl.LogUtils;
	import com.cs.di.core.logger.impl.Logger;

	/**
	 * @author Christian Sobolewski
	 */
	public class LogContext {
		protected static var _logger : LoggerSocket;
		protected static var _factory : ILogFactory;

		/**
		 * 	returns the <code>Logger</code> specified by param name
		 */

		public static function getLogger(name : String) : Logger {
			var nameStr : String = LogUtils.getLogName(name);
			if (factory.loggers[nameStr] != null) {
				return factory.loggers[nameStr];
			}
			var log : Logger = factory.getLogger(nameStr);
			factory.loggers[nameStr] = log;
			return log;
		}

		/**
		 * 	called after the context.xml is parsed to refresh <code>Logger</code> <code>LogLevel</code> 
		 */

		public static function refreshLoggerLevels() : void {
			factory.refreshLoggerLevels();
		}
		
		/**
		 * 	getter for <code>ILogFactory</code>
		 */
		
		public static function get factory() : ILogFactory {
			if (_factory == null) {
				createDefaultFactory();
			}
			return _factory;
		}
		
		/**
		 * 	setter for <code>ILogFactory</code>
		 */
		
		public static function set factory(factory : ILogFactory) : void {
			_factory = factory;
			/**
			 * called here to refresh each LogLevel for each Logger after parsing logger log node
			 */
			refreshLoggerLevels();
		}
		
		/**
		 * 	creates the <code>DefaultLogFactory</code>
		 */
		
		private static function createDefaultFactory() : void {
			_factory = new DefaultLogFactory();
			if (logger == null) logger = factory.createObject("com.cs.di.core.logger.core.LoggerSocket", "logger");
		}

		/**
		 * returns the <code>LoggerSocket</code> Class that is used for an XMLSocket Connection
		 */
		 
		public static function get logger() : LoggerSocket {
			return _logger;
		}

		/**
		 * logger
		 * set the <code>LoggerSocket</code> Class that is used for an XMLSocket Connection
		 */

		public static function set logger(logger : LoggerSocket) : void {
			_logger = logger;
		}
	}
}
