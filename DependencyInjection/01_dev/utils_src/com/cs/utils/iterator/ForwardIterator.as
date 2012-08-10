/**
 * Copyright 12.08.2009 Christian Sobolewski
 * 
 * Usage : _fI = new ForwardIterator(collection);
 * 
 * Parameters : collection as Array
 *
 * Description : The ForwardIterator Class is a Forward Iterator.
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
	public class ForwardIterator implements IIterator {
		
		protected var _collection : Array;
		protected var _index : int = 0;
		
		public function ForwardIterator(collection : Array) {
			_collection = collection;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function reset() : void {
			_index = 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get next() : Object {
			return _collection[_index++]; 
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get hasNext() : Boolean {
			return _index < _collection.length;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get hasPrevious() : Boolean {
			return _index > 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get previous() : Object {
			_index--;
			return _collection[_index];
		}
	}
}
