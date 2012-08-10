/**
 * Copyright 12.08.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : IIterator Interface for each Iterator Type
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.iterator {

	/**
	 * @author Christian Sobolewski
	 */
	public interface IIterator {
		
		/**
		 * 	resets the Iterator index
		 */
		
		function reset() : void;
		
		/**
		 * 	return next Object
		 */
		
		function get next() : Object; 
		
		/**
		 * 	returns if hasNext 
		 */
		
		function get hasNext() : Boolean;
		
		/**
		 * 	returns if hasPrevious 
		 */
		
		function get hasPrevious() : Boolean; 
		
		/**
		 * 	returns if previous Object 
		 */
		
		function get previous() : Object;
	}
}
