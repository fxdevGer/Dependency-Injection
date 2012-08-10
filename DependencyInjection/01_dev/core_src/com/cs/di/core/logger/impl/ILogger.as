/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : ILogger Interface for the Logger Class
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
	public interface ILogger {

		function get name() : String;

		function get level() : LogLevel;

		function set level(level : LogLevel) : void;

		function isTraceEnabled() : Boolean;

		function isDebugEnabled() : Boolean;

		function isInfoEnabled() : Boolean;

		function isWarnEnabled() : Boolean;

		function isErrorEnabled() : Boolean;

		function isFatalEnabled() : Boolean;

		function debug(message : String, ...params) : void;

		function info(msg : String, ...params) : void;

		function warn(message : String, ...params) : void;

		function error(message : String, ...params) : void;

		function fatal(message : String, ...params) : void;

		function trace(message : String, ...params) : void;
	}
}
