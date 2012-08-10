/**
 * Copyright 2012 Christian Sobolewski
 * 
 * usage : com.cs.utils.input
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.utils.input.AutoFireKeyDelay.as
 * @author Christian Sobolewski
 */
package com.cs.utils.input {
	import flash.utils.Dictionary;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class AutoFireKeyDelay {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(AutoFireKeyDelay));
		
		private var _autoFireKeyDelayDic : Dictionary;
		
		public function AutoFireKeyDelay() {
			_autoFireKeyDelayDic = new Dictionary();
		}

		public function autoFireKeyDelay(key : String, delay : int) : void {
			_autoFireKeyDelayDic[KeyCommand.getKeyByString(key)] = delay;
			log.trace(KeyCommand.getKeyByString(key) + " delay : " + _autoFireKeyDelayDic[KeyCommand.getKeyByString(key)]);
		}

		public function get autoFireKeyDelayDic() : Dictionary {
			return _autoFireKeyDelayDic;
		}

		public function set autoFireKeyDelayDic(autoFireKeyDelayDic : Dictionary) : void {
			_autoFireKeyDelayDic = autoFireKeyDelayDic;
		}
	}
}
