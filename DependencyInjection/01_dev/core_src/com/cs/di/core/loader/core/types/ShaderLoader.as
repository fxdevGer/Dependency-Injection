/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_shaderLoader = new ShaderLoader(monitor);
 * 			_shaderLoader.addBinaryData(ByteArray)
 *			_shaderLoader.addEventListener(FilLoaderEvent.COMPLETE, handleComplete);
 *			_shaderLoader.addEventListener(FilLoaderEvent.QUEUE_COMPLETE, handleComplete);
 *			_shaderLoader.altogetherLoading(); || _shaderLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The ShaderLoader Class loads a pbj file or more.
 * 				 This Class could be used in a QueueLoader implementation or Stand Alone.
 * 				 This Class has a queue in itself.
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

	import flash.display.Shader;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;

	/**	
	 * @author Christian Sobolewski
	 */
	public class ShaderLoader extends AbstractUrlLoader {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ShaderLoader));

		public function ShaderLoader(monitor : ProgressMonitor = null) {
			super();
			_monitor = monitor;
		}

		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		public override function altogetherLoading() : void {
			var shaderLoader : URLLoader;

			for (var i : int = maxLength - 1; i >= 0; i--) {
				shaderLoader = new URLLoader();
				shaderLoader.dataFormat = URLLoaderDataFormat.BINARY;
				configureListener(shaderLoader);
				_content.unshift(shaderLoader);
				shaderLoader.load(new URLRequest(_queue[i]));
			}
		}

		/**
		 * 	start loading each <code>IFileLoader</code> after the other
		 */
		public override function sequentialLoading() : void {
			var shaderLoader : URLLoader = new URLLoader();
			shaderLoader.dataFormat = URLLoaderDataFormat.BINARY;
			configureListener(shaderLoader);
			_content.unshift(shaderLoader);
			shaderLoader.load(new URLRequest(_queue[_maxLength - 1]));
		}

		/**
		 * called after each file has been succesfull loaded
		 */
		public override function completeHandler(event : Event) : void {
			var urlLoader : URLLoader = URLLoader(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;

			var shader : Shader = new Shader();
			shader.byteCode = urlLoader.data;

			if (hasEventListener(FileLoaderEvent.COMPLETE)) {
				var data : LoaderData = new LoaderData();
				data.fileName = _queue[index];
				data.shader = shader;

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
