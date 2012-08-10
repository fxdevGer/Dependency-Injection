/**
 * Copyright 06.07.2011 Christian Sobolewski
 * 
 * Usage : LoaderGroupLoad
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
package com.cs.di.core.loader.impl {
	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderGroupLoad {
		
		public static const SEQUENTIAL : LoaderGroupLoad = new LoaderGroupLoad("SEQUENTIAL");
		public static const ALTOGETHER : LoaderGroupLoad = new LoaderGroupLoad("ALTOGETHER");
		
		private var _load : String;
		
		public function LoaderGroupLoad(load : String) {
			_load = load;
		}

		public function get load() : String {
			return _load;
		}
		
		public function toString() : String {
			return _load;
		}

		
	}
}
