/**
 * Copyright 06.07.2011 Christian Sobolewski
 * 
 * Usage : LoaderGroupCache
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
	public class LoaderGroupCache {
		
		public static const CACHE_ON : LoaderGroupCache = new LoaderGroupCache("ON");
		public static const CACHE_OFF : LoaderGroupCache = new LoaderGroupCache("OFF");
		
		private var _cache : String;
		
		public function LoaderGroupCache(cache : String) {
			_cache = cache;
		}

		public function get cache() : String {
			return _cache;
		}
		
		public function toString() : String {
			return _cache;
		}
			
	}
}
