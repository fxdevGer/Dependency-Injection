/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	-
 *
 * Description : The AbstractUrlLoader Class that is implemented by all URLLoader types
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core {
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/**
	 * @author Christian Sobolewski
	 */
	public class AbstractUrlLoader extends AbstractFileLoader {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(AbstractUrlLoader));

		public function AbstractUrlLoader() {
			super();
		}

		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		public override function altogetherLoading() : void {
			var urlLoader : URLLoader;
			
			for (var i : int = maxLength-1; i >= 0; i--) {
//				log.info('start altogetherLoading: ' + (_queue[i]));
				urlLoader = new URLLoader();
				configureListener(urlLoader);
				_content.unshift(urlLoader);
				urlLoader.load(new URLRequest(_queue[i]));
				
			}
		}

		/**
		 *	start loading each <code>IFileLoader</code> after the other
		 */
		public override function sequentialLoading() : void {
//			log.info('start sequentialLoading: ' + (_queue[_maxLength - 1]));
			var urlLoader : URLLoader = new URLLoader();
			configureListener(urlLoader);
			_content.unshift(urlLoader);
			urlLoader.load(new URLRequest(_queue[_maxLength - 1]));
		}

		/**
		 * 	stops the current loading 
		 */
		public override function stopLoading() : void {
			for each (var l : URLLoader in _content) {
				removeListener(l);
				l.close();
			}

			garbageCollection();
		}

		/**
		 * 	frees memory and removes all listener
		 */
		public override function garbageCollection() : void {
			for each (var l : URLLoader in _content) {
				removeListener(l);
				l.close();
			}

			if (_monitor != null) _monitor = null;

			if (_dispatcher != null) _dispatcher = null;

			_queue = null;
			_maxLength = undefined;
			_content = null;
			_isQueue = undefined;
			_ldrContext = null;
			_groupLoad = null;
			_state = null;

			delete this;
		}

		public override function addBinaryData(data : ByteArray) : void {
		}
	}
}
