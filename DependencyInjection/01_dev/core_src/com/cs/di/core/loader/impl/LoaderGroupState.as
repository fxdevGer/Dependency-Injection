/**
 * Copyright 09.11.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : The LoaderGroupState Class defines states of each LoaderGroup.
 * 				 Only used internaly by the Framework.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.impl {
	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderGroupState {
		
		public static const ACTIVE : LoaderGroupState = new LoaderGroupState("ACTIVE");
		public static const FINISHED : LoaderGroupState = new LoaderGroupState("FINISHED");
		public static const SUSPEND : LoaderGroupState = new LoaderGroupState("SUSPEND");
		
		private var _state : String;

		public function LoaderGroupState(state : String) {
			_state = state;
		}

		public function toString() : String {
			return _state;
		}
	}
}
