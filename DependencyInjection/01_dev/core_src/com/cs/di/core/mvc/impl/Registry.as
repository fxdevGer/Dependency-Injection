/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The Registry
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc.impl {
	import com.cs.utils.ArrayUtil;
	import flash.utils.Dictionary;


	/**
	 * @author Christian Sobolewski
	 */
	public class Registry {

		protected var _dictionary : Dictionary = new Dictionary();
		
		/**
		 * adds the specified item to the list of items
		 */

		public function registerItem(key : String, item : Object) : void {
			var items : Array = _dictionary[key];
			if (items == null) {
				items = new Array();
				_dictionary[key] = items;
			}
			items.push(item);
		}

		/**
		 * delets the given object with the given key
		 */

		public function unregisterItem(key : String, item : Object) : void {
			var items : Array = _dictionary[key];
			if (items != null) {
				removeItem(items, item);
				if (items.length == 0) {
					delete _dictionary[key];
				}
			}
		}
		
		/**
		 * removes the given item from given Array
		 */
		
		protected function removeItem(items : Array, item : Object) : void {
			ArrayUtil.remove(items, item);
		}

		/**
		 * 	returns the object from the given key
		 */

		public function getItems(key : String) : Array {
			var items : Array = _dictionary[key];
			return (items == null) ? [] : items;
		}
	}
}
