/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : _fI = new ReverseIterator(collection);
 * 
 * Parameters : collection as XMLList
 *
 * Description : The ForwardXMLIterator Class is a Forward Iterator.
 * 				 It uses an XML as collection.
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
	public class ForwardXMLIterator implements IIterator {
		protected var _collection : XMLList;
		protected var _index : uint = 0;
		
		public function ForwardXMLIterator(collection : XMLList) {
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
			return _index < _collection.length();
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
