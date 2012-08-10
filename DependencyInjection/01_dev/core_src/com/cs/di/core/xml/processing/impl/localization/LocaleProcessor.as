/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : LocaleProcessor
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
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class LocaleProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LocaleProcessor));
		
		public function LocaleProcessor() {
			super();
		}
		
		public override function proceedNode() : void {
//			log.warn("proceedNode: " + processedData);
			
			var language : String = getAttributeFromNode(xmlNode, attributes[0]);
			var country : String = getAttributeFromNode(xmlNode, attributes[1]);
			var ignoreCountry : String = getAttributeFromNode(xmlNode, attributes[2]);
			
			if (xmlNode.localName() == "defaultLocale") {
				LocaleContext.defaultLocale = language;
			}
			
			processedData.push(factory.createLocale(language, country,ignoreCountry));
			
			dispose();
			
		}
	}
}
