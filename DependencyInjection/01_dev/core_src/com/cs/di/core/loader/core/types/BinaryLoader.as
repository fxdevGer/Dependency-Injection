/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_binaryLoader = new BinaryLoader(monitor);
 * 			_binaryLoader.addBinaryData(ByteArray)
 *			_binaryLoader.addEventListener(FilLoaderEvent.COMPLETE, handleComplete);
 *			_binaryLoader.addEventListener(FilLoaderEvent.QUEUE_COMPLETE, handleComplete);
 *			_binaryLoader.altogetherLoading(); || _binaryLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The BinaryLoader Class loads a binary File or more.
 * 				 This Class could be used in a QueueLoader implementation or Stand Alone.
 * 				 This Class has a queue in itself.
 * 				 Could be used to load a DAE or Collada File.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.types {
	import com.cs.di.core.loader.core.AbstractUrlLoader;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;
	import com.cs.di.core.loader.core.monitor.ProgressMonitorData;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class BinaryLoader extends AbstractUrlLoader {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(BinaryLoader));
		
		public function BinaryLoader(monitor : ProgressMonitor = null) {
			super();
			_monitor = monitor;
		}
		
		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		
		public override function altogetherLoading() : void {
			var binLoader : URLLoader;
			for (var i : int = 0;i < maxLength;i++) {
				binLoader = new URLLoader();
				binLoader.dataFormat = dataFormat;
				configureListener(binLoader);
				_content.unshift(binLoader);
				binLoader.load(new URLRequest(_queue[i]));
			}
		}
		
		/**
		 * 	start loading each <code>IFileLoader</code> after the other
		 */
		
		public override function sequentialLoading() : void {
			var binLoader : URLLoader = new URLLoader();
			binLoader.dataFormat = dataFormat;
			configureListener(binLoader);
			_content.unshift(binLoader);
			binLoader.load(new URLRequest(_queue[_maxLength-1]));
		}
		
		/**
		 * called after each file has been succesfull loaded
		 */
		
		public override function completeHandler(event : Event) : void {
			var urlLoader : URLLoader = URLLoader(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;
			
			if (hasEventListener(FileLoaderEvent.COMPLETE)) {
				var data : LoaderData = new LoaderData();
				data.fileName = _queue[index];

				if (dataFormat == "text") {
					data.bytesPlain = urlLoader.data;
				} else {
					data.bytes = ByteArray(urlLoader.data);
				}
				
				dispatchEvent(new FileLoaderEvent(FileLoaderEvent.COMPLETE, data));
			}
			
			removeListener(urlLoader);
			
			maxLength--;

			if (maxLength == 0) {
				if (hasEventListener(FileLoaderEvent.QUEUE_COMPLETE)) {
					state = LoaderState.FINISHED;
					dispatchEvent(new FileLoaderEvent(FileLoaderEvent.QUEUE_COMPLETE));
				}
				if (_monitor != null && _monitor.hasEventListener(ProgressMonitorEvent.FILE_COMPLETE)) {
					_monitor.dispatchEvent(new ProgressMonitorEvent(ProgressMonitorEvent.FILE_COMPLETE));
				}
				garbageCollection();
			} else {
				if (!isQueue) {
					sequentialLoading();
				} 
			}
		}
		
		/**
		 * 	monitors file loading
		 */
		
		public override function progressHandler(event : ProgressEvent) : void {
			var urlLoader : URLLoader = URLLoader(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;
			
			if (_monitor != null && _monitor.hasEventListener(ProgressMonitorEvent.PROGRESS)) {
				var progressData : ProgressMonitorData = new ProgressMonitorData();
				progressData.loadedBytes = event.bytesLoaded;
				progressData.totalBytes = event.bytesTotal;
				progressData.progress = Math.round(event.bytesLoaded / event.bytesTotal * 100);
				progressData.fileName = _queue[index];
				_monitor.dispatchEvent(new ProgressMonitorEvent(ProgressMonitorEvent.PROGRESS, progressData));
			}
		}
		
		/**
		 * 	handles if an IOErrorEvent occurs and dispatched an ErrorEvent to the _dispatcher
		 * 	must be overwritten to get the fileName
		 */
		
		public override function ioErrorHandler(event : IOErrorEvent) : void {
			if (_dispatcher) {
				var urlLoader : URLLoader = URLLoader(event.currentTarget);
				var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;
				var msg : String = "File " + _queue[index] + " not found!";
				_dispatcher.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, msg));
			}
		}
	}
}
