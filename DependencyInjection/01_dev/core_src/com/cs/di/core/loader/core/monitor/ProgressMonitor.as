/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	_monitor = new ProgressMonitor();
 *			_monitor.addEventListener(ProgressMonitorEvent.PROGRESS, monitorProgress, false, 0, true);
 * 
 * Parameters :
 *
 * Description : The Base Class for monitoring files 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.monitor {
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.interfaces.IProgressMonitor;

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	/**	
	 * @author Christian Sobolewski
	 */

	public class ProgressMonitor extends EventDispatcher implements IProgressMonitor {
		
		private var _queue : Dictionary = new Dictionary(true);
		private var _loadedBytes : uint = 0;
		private var _totalBytes : uint = 0;
		
		public function ProgressMonitor() {
			super(this);
			addEventListener(FileLoaderEvent.QUEUE_COMPLETE, queueOnComplete);
			addEventListener(ProgressMonitorEvent.PROGRESS, fileMonitoring);
		}
		
		/**
		 * 	called if each file fires its own <code>ProgressMonitorEvent</code>
		 * 	this method sets all loadedBytes and totalBytes until now
		 */
		
		private function fileMonitoring(event : ProgressMonitorEvent) : void {
			var progressData : ProgressMonitorData = event.progressData;
			
			var s : String = (progressData.totalBytes > 0) ? progressData.fileName + "_" + progressData.totalBytes : ""; 
			
			if (s != "" && _queue[s] == null) {
				_queue[s] = {t : progressData.totalBytes, l : progressData.loadedBytes};
			} else {
				_queue[s] = {t : _queue[s].t, l : progressData.loadedBytes};
			}
			
			var lBytes : Number = 0;
			var tBytes : Number = 0;
			
			for each (var o : Object in _queue) {
				lBytes = lBytes + o.l;
				tBytes = tBytes + o.t;	
			}
			
			loadedBytes = lBytes;
			totalBytes = tBytes;
			
		}
	
		private function queueOnComplete(event : FileLoaderEvent) : void {
			garbageCollection();
		}
		
		/**
		 * 	frees memory and removes all listener
		 */
		
		public function garbageCollection() : void {
			if (hasEventListener(FileLoaderEvent.QUEUE_COMPLETE)) {
				removeEventListener(FileLoaderEvent.QUEUE_COMPLETE, queueOnComplete);
			}
			
			if (hasEventListener(ProgressMonitorEvent.PROGRESS)) {
				removeEventListener(ProgressMonitorEvent.PROGRESS, fileMonitoring);
			}
			
			_loadedBytes = undefined;
			_totalBytes = undefined;
			_queue = null;
			
			delete this;
		}
		
		/**
		 *  returns <code>ProgressMonitorData</code> Object
		 */
		
		public function get progressData():ProgressMonitorData {
			var progressData : ProgressMonitorData = new ProgressMonitorData();
			progressData.loadedBytes = loadedBytes;
			progressData.totalBytes = totalBytes;
			progressData.progress = loadedBytes / totalBytes * 100;
			return progressData;
		}
		
		/**
		 * 	getter for all loadedBytes
		 */
		
		public function get loadedBytes() : uint {
			return _loadedBytes;
		}
		
		/**
		 * 	setter for all loadedBytes
		 */
		
		public function set loadedBytes(loadedBytes : uint) : void {
			_loadedBytes = loadedBytes;
		}
		
		/**
		 * 	getter for all totalBytes
		 */
		
		public function get totalBytes() : uint {
			return _totalBytes;
		}
		
		/**
		 * 	setter for all totalBytes
		 */
		
		public function set totalBytes(totalBytes : uint) : void {
			_totalBytes = totalBytes;
		}
	}
}
