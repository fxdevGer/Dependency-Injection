/**
 * Copyright 06.09.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The MessageBundle Class is created for each MessageBundle.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.localization {
	/**
	 * @author Christian Sobolewski
	 */
	public class MessageBundle {
		
		private var _loc : Locale;
		private var _messages : Object;
		private var _id : String;
		
		/**
		 * 	adds messages for the specified.
		 */
		
		public function addMessages(loc : Locale, messages : Object) : void {
			_loc = loc;
			_messages = messages;
		}

		/**
		 * returns a localized message for the specified key.
		 */
		 
		public function getMessage(messageKey : String/*, params : Array*/) : String {
			return _messages[messageKey];
		}
		
		/**
		 * setter for <code>MessageBundle</code> id
		 */
		
		public function get id() : String {
			return _id;
		}
		
		/**
		 * getter for <code>MessageBundle</code> id
		 */
		
		public function set id(id : String) : void {
			_id = id;
		}
		
		/**
		 * getter for <code>Locale</code>
		 */
		
		public function get locale() : Locale {
			return _loc;
		}	
	}
}
