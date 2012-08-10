/**
 * Copyright 12.07.2011 Christian Sobolewski
 * 
 * Usage : LoaderStatus
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
 * History :
 * 
 */
package com.cs.di.core.loader.core.types {
	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderState {
		
		public static const PENDING : LoaderState = new LoaderState("PENDING");
		public static const FINISHED : LoaderState = new LoaderState("FINISHED");
		
		private var _status : String;
		
		public function LoaderState(status : String) {
			_status = status;
		}

		public function get status() : String {
			return _status;
		}
		
		public function toString() : String {
			return _status;
		}
	}
}
