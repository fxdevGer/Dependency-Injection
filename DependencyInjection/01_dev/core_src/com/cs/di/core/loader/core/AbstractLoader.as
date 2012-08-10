/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	-
 *
 * Description : The AbstractLoader Class that is implemented by all Loader types
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core {
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;

	/* 
	 * @author Christian Sobolewski
	 */
	public class AbstractLoader extends AbstractFileLoader {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(AbstractLoader));

		public function AbstractLoader() {
			super();
		}

		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		public override function altogetherLoading() : void {
			var ld : Loader;

			for (var i : int = maxLength - 1; i >= 0; i--) {
				// log.info('start altogetherLoading: ' + (_queue[i]));
				ld = new Loader();
				configureListener(ld.contentLoaderInfo);
				_content.unshift(ld);
				ld.load(new URLRequest(_queue[i]), _ldrContext);
			}
		}

		/**
		 *	start loading each <code>IFileLoader</code> after the other
		 */
		public override function sequentialLoading() : void {
			// log.info('start sequentialLoading: ' + (_queue[_maxLength - 1]));
			var ld : Loader = new Loader();
			configureListener(ld.contentLoaderInfo);
			_content.unshift(ld);
			ld.load(new URLRequest(_queue[_maxLength - 1]), _ldrContext);
		}

		/**
		 * 	stops the current loading 
		 */
		public override function stopLoading() : void {
			for each (var l : Loader in _content) {
				removeListener(l.contentLoaderInfo);
				l.unloadAndStop(true);
				l.close();
			}

			garbageCollection();
		}

		/**
		 * 	frees memory and removes all listener
		 */
		public override function garbageCollection() : void {
			for each (var l : Loader in _content) {
				removeListener(l.contentLoaderInfo);
				l.unload();
				l = null;
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
