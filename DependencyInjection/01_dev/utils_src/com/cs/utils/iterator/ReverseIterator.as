/**
 * Copyright 12.08.2009 Christian Sobolewski
 * 
 * Usage : _rI = new ReverseIterator(collection);
 * 
 * Parameters : collection as Array
 *
 * Description : The ReverseIterator Class is a Reverse Iterator.
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
	public class ReverseIterator implements IIterator {
		
		protected var _collection : Array;
		protected var _index:uint = 0;
		
		public function ReverseIterator(collection : Array) {
			_collection = collection;
			_index = _collection.length;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function reset() : void {
			_index = _collection.length;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get next() : Object {
			return _collection[(_index--)-1];
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get hasNext() : Boolean {
			return _index > 0;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get hasPrevious() : Boolean {
			return _index < _collection.length;
		}
		
		/**
		 * 	@inheritDoc
		 */
		
		public function get previous() : Object {
			return _collection[_index++];
		}
	}
}
