/**
 * Copyright 06.09.2010 Christian Sobolewski
 * 
 * Usage :	 LocaleContext.getMessage(language, key);
 * 
 * Parameters :	
 *
 * Description : The LocaleContext Class is the Base Class for Localization. Its holds each MessageBundle.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.localization.core {
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.localization.MessageBundle;

	import flash.utils.Dictionary;

	/**
	 * @author Christian Sobolewski
	 */
	public class LocaleContext {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LocaleContext));
		
		protected static var _msg : Dictionary = new Dictionary();		protected static var _defaultLocale : String;
		protected static var _locale : Array = [];
		
		/**
		 * 	adds each <code>MessageBundle</code>
		 */
		
		public static function addMessageBundle(msg : MessageBundle) : void {
			var s : String = msg.locale.language + msg.id;
			_msg[s] = msg;
		}
		
		/**
		 * 	returns the message by a given language and a given key
		 */
		
		public static function getMessage(lang : String, key : String) : String {
			var a : Array = key.split(".");
			var s : String = lang + a[0];
			var tmp : String;
			
			try {
				if (_msg[s]) {
					tmp = MessageBundle(_msg[s]).getMessage(key);
				} else {
					s = _defaultLocale + a[0];
					tmp = MessageBundle(_msg[s]).getMessage(key);
				}
			} catch (e : TypeError) {
				throw new ConfigurationError("Message for Language:> " + lang + " < and Message Key> " + key + " < not found.");
				tmp = "";
			}
			
			return tmp;
		}
		
		/**
		 * 	sets locale as Array needed for messageSource
		 */
		
		public static function set locale(locale : Array) : void {
			_locale = locale;
		}
		
		public static function get locale() : Array {
			return _locale;
		}
		
		/**
		 * 	sets the default Locale as String
		 */
		
		public static function set defaultLocale(defaultLocale : String) : void {
			_defaultLocale = defaultLocale;
		}
		
		/**
		 * 	returns the default Locale as String
		 */
		
		public static function get defaultLocale() : String {
			return _defaultLocale;
		}
	}
}
