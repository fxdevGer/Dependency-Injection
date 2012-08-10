/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage :	ArrayUtil.remove(arr, element);
 * 			ArrayUtil.contains(arr, element);
 * 
 * Parameters :	
 *
 * Description : An ArrayUtil Class 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils {
	import com.cs.utils.iterator.ReverseIterator;

	/**
	 * @author Christian Sobolewski
	 */
	public class ArrayUtil {

		
		/**
		 * removes the specified element from the Array.
		 */

		public static function remove(arr : Array, element : *) : Boolean {
			var reverse : ReverseIterator = new ReverseIterator(arr);
			var i : int = arr.length;
			while(reverse.hasNext) {
				if (reverse.next == element) {
					arr.splice(i, 1);
					return true;
				}
				i--;
			}
			return false;
		}

		/**
		 * checks whether the Array contains the specified element.
		 */

		public static function contains(arr : Array, element : *) : Boolean {
			return (arr.indexOf(element) != -1);
		}	
	}
}
