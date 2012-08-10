/**
 * Copyright 12.03.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The LoggerSocket creates a XMLSocket Connection to LocalHost 
 *
 * Version :	 1.l 
 * 				 Refactored private Method initLogger to a public Method connectSocket.
 * 				 Only if a <code>logger</code> Node parsed by the framework this Socket
 * 				 connects to Localhost otherwise no connection.
 * 
 * History : 	 1.0
 * 
 */
package com.cs.di.core.logger.core {
	import com.cs.di.core.logger.impl.LogEvent;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.XMLSocket;

	/**
	 * @author Christian Sobolewski
	 */
	public class LoggerSocket {

		private var _host : String = "localhost";
		private var _port : uint = 4444;

		private var _socket : XMLSocket;
		private var _ready : Boolean;
		private var _cache : Array;
		private var _id : String;

		public function LoggerSocket() {
			ready = false;
			_cache = [];
		}
		
		/**
		 * 	create and connect <code>XMLSocket</code>
		 */
		
		public function connectSocket() : void {
			_socket = new XMLSocket();
			_socket.addEventListener(Event.CONNECT, onConnect);
			_socket.addEventListener(IOErrorEvent.IO_ERROR, onError);
			_socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			
			try {
				_socket.connect(_host, _port);
			} catch (error : SecurityError) {
				handleError("SecurityError in LoggerSocket: " + error);
			}
		}
		
		/**
		 * 	handles each <code>LogEvent</code>. If <code>XMLSocket</code> is not connected yet a cache wil be involved.
		 */
		
		public function handleLogEvent(event : LogEvent) : void {
			if (!ready) {
				if (_cache != null) _cache.push(event);
				return;
			}
			var message : String = formatLogMessage(event);
			_socket.send(message);
		}
		
		/**
		 * 	If connection has been established, all _cache Events will be 
		 * 	send over the <code>XMLSocket</code>.
		 */
		
		private function onConnect(event : Event) : void {
			ready = true;
			for each (var logEvent:LogEvent in _cache) {
				handleLogEvent(logEvent);
			} 	
			_cache = null;
		}
		
		/**
		 * 	formats each <code>LogEvent</code>.message
		 */
		
		private function formatLogMessage(event : LogEvent) : String {
			var loggerName : String = event.name;

			var level : String = event.level.toString();
			var message : String = event.message;
			var command : String;
			
			command = "!SOS<showMessage key=\"" + level + "\"><![CDATA[" + loggerName + ": " + message + "]]></showMessage>\n";
			return command;
		}
		
		/**
		 * 	called if an <code>IOErrorEvent</code> occurs
		 */
		
		private function onError(event : IOErrorEvent) : void {
			handleError(event.text);
		}
		
		/**
		 * 	close the <code>XMLSocket</code>
		 */
		
		private function handleError(message : String) : void {
			// do not log to avoid loops
			_socket.close();
			_socket = null;
			_cache = null;		
		}
		
		/**
		 * 	returns <code>XMLSocket</code> connection status
		 */
		
		public function get ready() : Boolean {
			return _ready;
		}
		
		/**
		 * 	sets <code>XMLSocket</code> connection status
		 */
		
		public function set ready(ready : Boolean) : void {
			_ready = ready;
		}
		
		/**
		 * 	returns id
		 */
		
		public function get id() : String {
			return _id;
		}
		
		/**
		 * 	sets id
		 */
		
		public function set id(id : String) : void {
			_id = id;
		}
	}
}
