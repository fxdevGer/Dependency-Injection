/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_cssLoader = new CSSLoader(monitor);
 * 			_cssLoader.addBinaryData(ByteArray)
 *			_cssLoader.addEventListener(FilLoaderEvent.COMPLETE, handleComplete);
 *			_cssLoader.addEventListener(FilLoaderEvent.QUEUE_COMPLETE, handleComplete);
 *			_cssLoader.altogetherLoading(); || _cssLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The CSSLoader Class loads a css file or more.
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

	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.net.URLLoader;
	import flash.text.StyleSheet;

	/**	
	 * @author Christian Sobolewski
	 */	
	public class CSSLoader extends AbstractUrlLoader {
		
		public function CSSLoader(monitor : ProgressMonitor = null) {
			super();
			_monitor = monitor;
		}

		/**
		 * called after each file has been succesfull loaded
		 */

		public override function completeHandler(event : Event) : void {
			var urlLoader : URLLoader = URLLoader(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;
			var css : StyleSheet = new StyleSheet();
			css.parseCSS(urlLoader.data);
			
			if (hasEventListener(FileLoaderEvent.COMPLETE)) {
				var data : LoaderData = new LoaderData();
				data.fileName = _queue[index];
				data.styles = css;
				
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
	}
}
