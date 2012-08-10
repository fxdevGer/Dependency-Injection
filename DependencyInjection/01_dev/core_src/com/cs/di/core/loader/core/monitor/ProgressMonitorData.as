/**
 * Copyright 08.09.2011 Christian Sobolewski
 * 
 * Usage : ProgressMonitorData
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
 * History :
 * 
 */
package com.cs.di.core.loader.core.monitor {
	/**
	 * @author Christian Sobolewski
	 */
	public class ProgressMonitorData {
		
		private var _fileName : String;
		private var _progress : uint;
		private var _loadedBytes : uint;
		private var _totalBytes : uint;
		
		public function ProgressMonitorData() {}
		
		/**
		 * 	setter for the actually loaded fileName
		 * 	call the getter to monitor the file loading process
		 */
		public function set fileName(name : String) : void {
			_fileName = name;
		}

		/**
		 * 	call the getter to monitor the file loading process
		 */
		public function get fileName() : String {
			return _fileName;
		}

		/**
		 * 	setter for the percent
		 */
		public function set progress(progress : uint) : void {
			_progress = progress;
		}

		/**
		 * 	call the getter to monitor the file loading process
		 */
		public function get progress() : uint {
			return _progress;
		}

		/**
		 *  setter for the loadedBytes
		 */
		public function set loadedBytes(loadedBytes : uint) : void {
			_loadedBytes = loadedBytes;
		}

		/**
		 * 	call the getter to monitor the file loading process
		 */
		public function get loadedBytes() : uint {
			return _loadedBytes;
		}

		/**
		 * 	setter for the loadedBytes
		 */
		public function set totalBytes(totalBytes : uint) : void {
			_totalBytes = totalBytes;
		}

		/**
		 * 	call the getter to monitor the file loading process
		 */
		public function get totalBytes() : uint {
			return _totalBytes;
		}
		
	}
}
