/**
 * Copyright 05.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : ILogFactory for DefaultLogFactory
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.logger.core {
	import com.cs.di.core.logger.impl.LogLevel;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.Dictionary;

	/**
	 * @author Christian Sobolewski
	 */
	public interface ILogFactory {
		
		function addLogLevel(loggerName : String, level : LogLevel) : void;
		
		function createObject(name : String, id : String) : LoggerSocket;

		function getLogger(name : Object) : Logger;

		function get loggers() : Dictionary;

		function setRootLogLevel(level : LogLevel) : void;
				function refreshLoggerLevels() : void;
	}
}
