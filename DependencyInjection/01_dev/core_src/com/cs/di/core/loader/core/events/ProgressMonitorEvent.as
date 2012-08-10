/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	IEventDispatcher.dispatch(new ProgressMonitorEvent(ProgressMonitorEvent.PROGRESS,type,progress,lBytes,tBytes,fileName));
 * 			IEventDispatcher.dispatch(new ProgressMonitorEvent(ProgressMonitorEvent.FILE_COMPLETE));
 * 
 * Parameters :	progress as uint
 * 				lBytes as uint
 * 				tBytes as uint
 * 				fileName as String
 *
 * Description : The ProgressMonitorEvent Class stands for monitor file loading Event.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.events {
	import com.cs.di.core.loader.core.monitor.ProgressMonitorData;

	import flash.events.Event;

	/**
	 * @author Christian Sobolewski
	 */
	public class ProgressMonitorEvent extends Event {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ProgressMonitorEvent));
		
		public static const PROGRESS : String = "PROGRESS";
		public static const FILE_COMPLETE : String = "FILE_COMPLETE";
//		private var _progress : uint;//		private var _lBytes : uint;//		private var _tBytes : uint;
//		private var _fileName : String;
		private var _progressData : ProgressMonitorData;

		public function ProgressMonitorEvent(type : String, progressData : ProgressMonitorData = null, bubbles : Boolean = false, cancelable : Boolean = false) {
//			_progress = progress;
//			_lBytes = lBytes;
//			_tBytes = tBytes;
//			_fileName = fileName;
			_progressData = progressData;
			super(type, bubbles, cancelable);
		}
		
		public function get progressData() : ProgressMonitorData {
			return _progressData;
		}
		
//		public function get progress() : uint {
//			return _progress;
//		}
//
//		public function get fileName() : String {
//			return _fileName;
//		}
//		
//		public function get tBytes() : uint {
//			return _tBytes;
//		}
//		
//		public function get lBytes() : uint {
//			return _lBytes;
//		}
	}
}
