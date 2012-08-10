/**
 * Copyright 05.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The ConfigurationError occurs if an error occured.
 * 				 Mostly it is dispatched via ContextParser.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context.impl {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	/**
	 * @author Christian Sobolewski
	 */
	public class ConfigurationError extends Error {
		private var _message : String;
		private var _cause : Error;

		private static var _logger : Logger;
		public function ConfigurationError(msg : * = "", cause : Error = null) {
			super((cause == null) ? msg : msg + " [cause: " + cause + "]");
			if (_logger == null) {
				_logger = LogContext.getLogger("com.cs.di.core.context.ConfigurationError");
			}
			_message = msg;
			_cause = cause;
			_logger.error(_message);
		}
	}
}
