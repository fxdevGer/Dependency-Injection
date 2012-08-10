/**
 * Copyright 12.07.2011 Christian Sobolewski
 * 
 * Usage : AbstractLoaderType
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
package com.cs.di.core.loader.core {
	import com.cs.di.core.loader.core.interfaces.IFileLoader;
	import com.cs.di.core.loader.core.interfaces.ILoaderType;
	import com.cs.di.core.loader.core.types.LoaderState;

	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public class AbstractLoaderType extends EventDispatcher implements ILoaderType {
		
		protected var _queue : Array;
		protected var _content : Array;
		protected var _maxLength : uint;
		
		protected var _groupLoad : String;
		
		protected var _state : LoaderState;
		protected var _dispatcher : IEventDispatcher;
		
		public function AbstractLoaderType() {
			_queue = [];
			_content = [];
			maxLength = 0;
			state = LoaderState.PENDING;
		}
		
		public function configureListener(dispatcher : EventDispatcher) : void {
			dispatcher.addEventListener(Event.COMPLETE, completeHandler, false, 0, true);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			dispatcher.addEventListener(Event.OPEN, openHandler, false, 0, true);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler, false, 0, true);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
		}

		public function removeListener(dispatcher : EventDispatcher) : void {
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler, false);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false);
			dispatcher.removeEventListener(Event.OPEN, openHandler, false);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler, false);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false);
		}

		public function completeHandler(event : Event) : void {
		}

		public function httpStatusHandler(event : HTTPStatusEvent) : void {
		}

		public function ioErrorHandler(event : IOErrorEvent) : void {
			if (dispatcher) {
				dispatcher.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, getMessageByType(event.currentTarget)));
			}
		}

		public function openHandler(event : Event) : void {
		}

		public function progressHandler(event : ProgressEvent) : void {
		}

		public function securityErrorHandler(event : SecurityErrorEvent) : void {
			if (dispatcher) {
				var msg : String = "SecurityErrorEvent has occured error.text= " + event.text;
				dispatcher.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, msg));
			}
		}

		public function get groupLoad() : String {
			return _groupLoad;
		}
		
		public function set groupLoad(groupLoad : String) : void {
			_groupLoad = groupLoad;
		}
		
		/**
		 * 	returns <code>LoaderStatus</code> 
		 */
		
		public function get state() : LoaderState {
			return _state;
		}
		
		public function set state(state : LoaderState) : void {
			_state = state;	
		}
		
		public function get dispatcher() : IEventDispatcher {
			return _dispatcher;
		}
		
		public function set dispatcher(dispatcher : IEventDispatcher) : void {
			_dispatcher = dispatcher;
		}
		
		public function get maxLength() : uint {
			return _maxLength;
		}
		
		public function set maxLength(maxLength : uint) : void {
			_maxLength = maxLength;
		}
		
		public function addFileLoader(fileLoader : IFileLoader) : void {
		}
				
		private function getMessageByType(currentTarget : Object) : String {
			var msg : String = "";
			var index : Number;
			
			switch(true) {
				
				case currentTarget.toString() == "[object LoaderInfo]":
				
					index = (_content.length == _queue.length) ? _content.indexOf(currentTarget.loader) : _maxLength - 1;
					msg = "File " + _queue[index] + " not found!";
				
				break;
				
				case currentTarget.toString() == "[object URLLoader]":

					index = (_content.length == _queue.length) ? _content.indexOf(currentTarget) : _maxLength - 1;
					msg = "File " + _queue[index] + " not found!";
					
				case currentTarget.toString() == "[object Sound]":

					index = (_content.length == _queue.length) ? _content.indexOf(currentTarget) : _maxLength - 1;
					msg = "File " + _queue[index] + " not found!";
				
				break;
				
				default:
					index = (_content.length == _queue.length) ? _content.indexOf(currentTarget) : _maxLength - 1;
					msg = "File " + _queue[index] + " not found!";
				
			}
			
			return msg;
		}
	}
}
