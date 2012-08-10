/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	-
 *
 * Description : The AbstractFileLoader Class that is implemented by all loading types
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core {
	import com.cs.di.core.loader.core.interfaces.IFileLoader;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;

	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.net.URLLoaderDataFormat;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	/**
	 * @author Christian Sobolewski
	 */
	public class AbstractFileLoader extends AbstractLoaderType implements IFileLoader {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(AbstractFileLoader));
		
		protected var _isQueue : Boolean = false;
		protected var _monitor : ProgressMonitor;
		protected var _ldrContext : LoaderContext;
		protected var _dataFormat : String = URLLoaderDataFormat.BINARY;

		public function AbstractFileLoader() {
			_ldrContext = new LoaderContext(false, ApplicationDomain.currentDomain);
		}
		
		/**
		 * addItem : adds an item to the queue
		 */
		public function addItem(path : String) : void {
			_queue.unshift(path);
//			log.info('_queue: ' + (_queue));
			maxLength = _queue.length;
		}
		
		public function set dataFormat(dataFormat : String) : void {
			_dataFormat = dataFormat;
		}
		
		/**
		 * return dataFormat (Plain Text or Binary Format)
		 */
		
		public function get dataFormat() : String {
			return _dataFormat;
		}
		
		/**
		 * return isQueue 
		 */
		public function get isQueue() : Boolean {
			return _isQueue;
		}

		public function set isQueue(isQueue : Boolean) : void {
			_isQueue = isQueue;
		}

		/**
		 * return BitmapData of loaded image
		 */
		public function getBitmapData(ld : Loader) : BitmapData {
			var bitmapData : BitmapData = new BitmapData(ld.content.width, ld.content.height, true, 0xffffff);
			bitmapData.draw(ld.content);
			return bitmapData;
		}

		public function addBinaryData(data : ByteArray) : void {
		}

		public function sequentialLoading() : void {
		}

		public function altogetherLoading() : void {
		}

		public function stopLoading() : void {
		}

		public function garbageCollection() : void {
		}
	}
}
