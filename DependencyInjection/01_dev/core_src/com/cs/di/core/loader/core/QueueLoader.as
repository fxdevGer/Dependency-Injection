/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_queueLoader = new QueueLoader(monitor);
 *			_queueLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, queueComplete, false, 0, true);
 *			_queueLoader.addFileLoader(IFileLoader);
 *			_queueLoader.altogetherLoading(); || _queueLoader.sequentialLoading();
 * 
 * Parameters :	monitor as ProgressMonitor
 *
 * Description : The Base Class for loading files 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core {
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.interfaces.IFileLoader;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;
	import com.cs.di.core.loader.impl.LoaderGroupLoad;

	/**
	 * @author Christian Sobolewski
	 */
	public class QueueLoader extends AbstractLoader {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(QueueLoader));
		
		private var _groupMode : Boolean = false;
		
		public function QueueLoader(monitor : ProgressMonitor) {
			super();
			_monitor = monitor;
			_monitor.addEventListener(ProgressMonitorEvent.FILE_COMPLETE, nextFile, false, 0, true);
		}
		
		/**
		 * called after each <code>IFileLoader</code> 
		 * fires <code>ProgressMonitorEvent.COMPLETE</code>
		 */
		
		private function nextFile(event : ProgressMonitorEvent) : void {
			maxLength--;
			
			if (maxLength > 0) {
				if (!isQueue && !groupMode) {
					sequentialLoading();
				}
			} else if (maxLength == 0) {
				
				if (hasEventListener(FileLoaderEvent.QUEUE_COMPLETE)) {
					dispatchEvent(new FileLoaderEvent(FileLoaderEvent.QUEUE_COMPLETE));
				}
				
				if (_monitor.hasEventListener(FileLoaderEvent.QUEUE_COMPLETE)) {
					_monitor.dispatchEvent(new FileLoaderEvent(FileLoaderEvent.QUEUE_COMPLETE));
				}
				
				garbageCollection();
			}
		}
		
		/**
		 * 	adds each <code>IFileLoader</code> to the Queue
		 */
		
		public override function addFileLoader(fileLoader : IFileLoader) : void {
			_queue.unshift(fileLoader);
			maxLength = _queue.length;
		}
		
		/**
		 * 	start loading each <code>IFileLoader</code> at the same time
		 */
		
		public override function altogetherLoading() : void {
			isQueue = true;
			
			for each (var abLoader : AbstractFileLoader in _queue) {
				abLoader.isQueue = isQueue;
				abLoader.altogetherLoading();
			}
		}
		
		/**
		 * 	start loading each <code>IFileLoader</code> after the other
		 */
		
		public override function sequentialLoading() : void {
			isQueue = false;
			var l : AbstractFileLoader = AbstractFileLoader(_queue[_maxLength-1]);
			l.isQueue = isQueue;
			l.sequentialLoading();
		}
		
		/**
		 * 	start loading each <code>IFileLoader</code> after the other
		 */
		
		public function loadByGroupMode() : void {
			groupMode = true;
			isQueue = false;
			for each (var abLoader : AbstractFileLoader in _queue) {
//				log.info('abLoader.groupLoad: ' + (abLoader.groupLoad));
				if (abLoader.groupLoad == LoaderGroupLoad.ALTOGETHER.toString()) {
					abLoader.isQueue = true;
					abLoader.altogetherLoading();
				} else {
					abLoader.sequentialLoading();
				}
			}
		}
		
		/**
		 * 	frees memory and removes all listener
		 */
		
		public override function garbageCollection() : void {
			_monitor.removeEventListener(ProgressMonitorEvent.FILE_COMPLETE, nextFile, false);
			_monitor = null;
			_queue = null;
			_maxLength = undefined;
			delete this;
		}

		public function get groupMode() : Boolean {
			return _groupMode;
		}

		public function set groupMode(groupMode : Boolean) : void {
			_groupMode = groupMode;
		}
	}
}
