/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :	IEventDispatcher.dispatch(new FileLoaderEvent(FileLoaderEvent.COMPLETE,type,loader,bitmap,styles,shader,bytes,sound,fileName ));
 * 			IEventDispatcher.dispatch(new FileLoaderEvent(FileLoaderEvent.QUEUE_COMPLETE));
 * 
 * Parameters :	xml as XMLDocument
 * 				loader as Loader
 * 				bitmap as Bitmap
 * 				styles as StyleSheet
 * 				shader as Shader
 * 				bytes as ByteArray
 * 				sound as Sound
 * 				fileName as String
 *
 * Description : The FileLoaderEvent Class acts to notify each IFileLoader if a File has been loaded.
 * 				 With the specific getter you can get your loaded file as you need.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.events {
	import com.cs.di.core.loader.core.types.LoaderData;

	import flash.events.Event;

	/**
	 * @author Christian Sobolewski
	 */
	public class FileLoaderEvent extends Event {
		public static const COMPLETE : String = "complete";
		public static const QUEUE_COMPLETE : String = "queue_complete";
		
		private var _data : LoaderData;

		public function FileLoaderEvent(type : String, data : LoaderData = null, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
			_data = data;
		}

		public function get data() : LoaderData {
			return _data;
		}
		
	}
}
