/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : MessageBundleProcessor
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
package com.cs.di.core.xml.processing.impl.localization {
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.localization.impl.LocaleUtil;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class MessageBundleProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MessageBundleProcessor));

		public function MessageBundleProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.warn("proceedNode: " + processedData + " | " + attributes);

			var locale : Array = LocaleContext.locale;
			var localeLength : int = locale.length;
			var callBack : Function;
			var fileName : String;

			for (var i : int = 0; i < localeLength; i++) {
				if (locale[i]) {
					callBack = factory.createBundleLoader(factory.createMessageBundle(getAttributeFromNode(xmlNode, attributes[0])), locale[i]);
					fileName = LocaleUtil.getFilename(getAttributeFromNode(xmlNode, attributes[1]), locale[i], locale[i].ignoreCountry);
					processedData.addTask(factory.createTask(fileName, "", "", callBack));
				}
			}
			
			dispose();
		}
	}
}
