/**
 * Copyright 22.06.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The DefaultBundleLoader Class loads a Message Bundle and parses the XML. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.localization.impl {
	import com.cs.di.core.localization.Locale;
	import com.cs.di.core.localization.MessageBundle;
	import com.cs.di.core.localization.core.LocaleContext;

	import flash.xml.XMLDocument;

	/**
	 * @author Christian Sobolewski
	 */
	public class DefaultBundleLoader {
		// private static const log : Logger = LogContext.getLogger(getQualifiedClassName(DefaultBundleLoader));
		private var _bundle : MessageBundle;
		private var _locale : Locale;

		public function DefaultBundleLoader(bundle : MessageBundle, loc : Locale) {
			_bundle = bundle;
			_locale = loc;
		}

		/**
		 * 	returns only callBack for parsing xml
		 */
		public function callBack() : Function {
			return parseXML;
		}

		/**
		 * 	parses the Bundle XML
		 */
		public function parseXML(xml : XMLDocument) : void {
			var xXML : XML = new XML(xml);
			xml.ignoreWhite = true;

			var nodes : XMLList = xXML.children();
			var messages : Object = new Object();

			for each (var node:XML in nodes) {
				var msgKey : String = node.@key;
				var message : String = node.text()[0];
				messages[msgKey] = message;
			}

			_bundle.addMessages(_locale, messages);

			LocaleContext.addMessageBundle(_bundle);
		}
	}
}
