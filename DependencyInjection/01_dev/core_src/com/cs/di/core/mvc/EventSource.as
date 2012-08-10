/**
 * Copyright 21.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : Not used right now!
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class EventSource {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(EventSource));
		
		protected var _dispatcher : IEventDispatcher;
		protected var _transformer : Function;
		protected var _eventTypes : Array;
		protected var _controller : FrontController;

		public function EventSource(dispatcher : IEventDispatcher, transformer : Function, eventTypes : Array) {
			_dispatcher = dispatcher;
			_transformer = transformer;
			_eventTypes = eventTypes;
		}

		/**
		 * @private
		 */
		internal function activate(controller : FrontController) : void {
			_controller = controller;
			
			for each (var eventType:String in _eventTypes) {
				_dispatcher.addEventListener(eventType, handleEvent);
				log.debug("hasEventListener? " + _dispatcher.hasEventListener(eventType));
			}	
		}

		/**
		 * @private
		 */
		internal function deactivate() : void {
			
			for each (var eventType:String in _eventTypes) {
				_dispatcher.removeEventListener(eventType, handleEvent);
			}	
		}

		private function handleEvent(event : Event) : void {
			log.debug('_controller: ' + (_controller));			log.debug('_transformer(event): ' + (_transformer(event)));
			_controller.dispatchEvent(_transformer(event));
		}
	}
}
