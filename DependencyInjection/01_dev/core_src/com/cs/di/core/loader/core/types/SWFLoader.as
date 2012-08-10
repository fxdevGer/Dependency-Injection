﻿/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_swfLoader = new SWFLoader(monitor);
 * 			_swfLoader.addBinaryData(ByteArray)
 *			_swfLoader.addEventListener(FilLoaderEvent.COMPLETE, handleComplete);
 *			_swfLoader.addEventListener(FilLoaderEvent.QUEUE_COMPLETE, handleComplete);
 *			_swfLoader.altogetherLoading(); || _swfLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The SWFLoader Class loads a swf file or more.
 * 				 This Class could be used in a QueueLoader implementation or Stand Alone.
 * 				 This Class has a queue in itself.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.types {
	import com.cs.di.core.loader.core.AbstractLoader;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;
	import com.cs.di.core.loader.core.monitor.ProgressMonitorData;

	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.ProgressEvent;

	/**	
	 * @author Christian Sobolewski
	 */
	public class SWFLoader extends AbstractLoader {
		public function SWFLoader(monitor : ProgressMonitor = null) {
			super();
			_monitor = monitor;
		}

		/**
		 * called after each file has been succesfull loaded
		 */
		public override function completeHandler(event : Event) : void {
			var ld : Loader = Loader(event.currentTarget.loader);
			var ldInfo : LoaderInfo = LoaderInfo(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(ld) : _maxLength - 1;

			if (hasEventListener(FileLoaderEvent.COMPLETE)) {
				var data : LoaderData = new LoaderData();
				data.fileName = _queue[index];
				data.loader = ld;
				
				dispatchEvent(new FileLoaderEvent(FileLoaderEvent.COMPLETE, data));
			}

			removeListener(ldInfo);

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
			var ld : Loader = Loader(event.currentTarget.loader);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(ld) : _maxLength - 1;

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
