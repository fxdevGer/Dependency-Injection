/**
 * Copyright 09.11.2010 Christian Sobolewski
 * 
 * Usage :	Context.fileLoader.addLoaderGroup(loaderGroup);
 * 			Context.fileLoader.loadByGroupName(id);
 *			Context.fileLoader.addEventListener(Event.COMPLETE, handleComplete);
 * 
 * Parameters :	
 *
 * Description : The AbstractFileLoaderContext Class handles some basic functionality for FileLoader.
 * 				 It creates the QueueLoader and ProgressMonitor instances and the EventListener.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.core.QueueLoader;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;
	import com.cs.di.core.loader.core.monitor.ProgressMonitorData;
	import com.cs.di.core.loader.impl.LoaderGroup;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * @author Christian Sobolewski
	 */
	public class AbstractFileLoaderContext extends EventDispatcher {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(AbstractFileLoader));
		
		use namespace csinject;
		
		protected var _queueLoader : QueueLoader;
		protected var _monitor : ProgressMonitor;
		protected var _id : String;
		protected var _queueComplete : Function;
		protected var _lgArr : Vector.<LoaderGroup>;
		protected var _lg : LoaderGroup;

		public function AbstractFileLoaderContext(target : IEventDispatcher = null) {
			super(target);
			_lgArr = new Vector.<LoaderGroup>();
		}

		/**
		 * 	called if all <code>LoaderGroup</code> are loaded
		 */
		public function removeListener() : void {
			monitor.removeEventListener(ProgressMonitorEvent.PROGRESS, monitorProgress, false);
			queueLoader.removeEventListener(FileLoaderEvent.QUEUE_COMPLETE, queueComplete, false);
			_monitor = null;
			_queueLoader = null;
		}

		private function monitorProgress(event : ProgressMonitorEvent) : void {
			var pData : ProgressMonitorData = monitor.progressData;
			pData.fileName = event.progressData.fileName;
			Context.progressData = pData;
			
//			Context.fileName = event.fileName;
//			Context.progress = monitor.loadedBytes / monitor.totalBytes * 100;
//			Context.loadedBytes = monitor.loadedBytes;
//			Context.totalBytes = monitor.totalBytes;
		}

		/**
		 * 	setter for the complete Callback
		 */
		 
		public function set queueComplete(f : Function) : void {
			_queueComplete = f;
		}
		
		/**
		 * 	getter for the complete Callback
		 */
		
		public function get queueComplete() : Function {
			return _queueComplete;
		}
		
		/**
		 * 	getter for the <code>QueueLoader</code> Instance
		 */
		
		public function get queueLoader() : QueueLoader {
			if (_queueLoader == null) {
				_queueLoader = new QueueLoader(monitor);
				_queueLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, queueComplete, false, 0, true);
			}
			return _queueLoader;
		}
		
		/**
		 * 	getter for the <code>ProgressMonitor</code> Instance
		 */
		
		public function get monitor() : ProgressMonitor {
			if (_monitor == null) {
				_monitor = new ProgressMonitor();
				_monitor.addEventListener(ProgressMonitorEvent.PROGRESS, monitorProgress, false, 0, true);
			}
			return _monitor;
		}
	}
}
