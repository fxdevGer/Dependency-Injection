/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_soundLoader = new SoundLoader(monitor);
 * 			_soundLoader.addBinaryData(ByteArray)
 *			_soundLoader.addEventListener(FilLoaderEvent.COMPLETE, handleComplete);
 *			_soundLoader.addEventListener(FilLoaderEvent.QUEUE_COMPLETE, handleComplete);
 *			_soundLoader.altogetherLoading(); || _shaderLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The SoundLoader Class loads a sound file or more.
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
	import flash.media.Sound;
	import flash.net.URLRequest;

	/**	
	 * @author Christian Sobolewski
	 */
	public class SoundLoader extends AbstractUrlLoader {
		public function SoundLoader(monitor : ProgressMonitor = null) {
			super();
			_monitor = monitor;
		}

		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		public override function altogetherLoading() : void {
			var snd : Sound;
			for (var i : int = 0;i < maxLength; i++) {
				snd = new Sound();
				configureListener(snd);
				_content.unshift(snd);
				snd.load(new URLRequest(_queue[i]));
			}
		}

		/**
		 * 	start loading each <code>IFileLoader</code> after the other
		 */
		public override function sequentialLoading() : void {
			var snd : Sound = new Sound();
			configureListener(snd);
			_content.unshift(snd);
			snd.load(new URLRequest(_queue[_maxLength - 1]));
		}

		/**
		 * called after each file has been succesfull loaded
		 */
		public override function completeHandler(event : Event) : void {
			var urlLoader : Sound = Sound(event.currentTarget);
			var index : Number = (_content.length == _queue.length) ? _content.indexOf(urlLoader) : _maxLength - 1;

			if (hasEventListener(FileLoaderEvent.COMPLETE)) {
				var data : LoaderData = new LoaderData();
				data.fileName = _queue[index];
				data.sound = Sound(urlLoader);
				
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
		 * 	stops the current loading 
		 */
		public override function stopLoading() : void {
			for each (var snd : Sound in _content) {
				removeListener(snd);
				try {
					snd.close();
				} catch(e : Error) {
				}
			}
			garbageCollection();
		}

		/**
		 * 	frees memory and removes all listener
		 */
		public override function garbageCollection() : void {
			for each (var snd : Sound in _content) {
				removeListener(snd);
				try {
					snd.close();
				} catch(e : Error) {
				}
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

		/**
		 * 	monitors file loading
		 */
		public override function progressHandler(event : ProgressEvent) : void {
			var urlLoader : Sound = Sound(event.currentTarget);
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
