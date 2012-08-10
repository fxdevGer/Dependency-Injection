/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : LocalManagerProcessor
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
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	/**
	 * @author Christian Sobolewski
	 */
	public class LocaleManagerProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LocaleManagerProcessor));

		public function LocaleManagerProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.info("----------------------LocaleManager Processor Start----------------------------------");
			
			var objProcessor : IProcessor;
			var qName : QName;
			var decendantList : XMLList;
			var childs : String;
			var i : int = 0;

			processedData = [];

			for each (childs in children) {
				for (i = 0;i < ContextNameSpace.NAMESPACES.length; i++) {
					qName = new QName(ContextNameSpace.NAMESPACES[i], childs);

					decendantList = xmlNode.descendants(qName);

					if (decendantList.length() > 0) {
						for (var j : int = 0; j < decendantList.length(); j++) {
							objProcessor = Processor.getProcessor(childs);
							objProcessor.children = Processor.getChildrenForProcessor(childs);
							objProcessor.attributes = Processor.getAttributesForProcessor(childs);
							objProcessor.factory = factory;
							objProcessor.processedData = processedData;
							objProcessor.xmlNode = decendantList[j];
							objProcessor.proceedNode();
						}
					}
				}
			}
			
			LocaleContext.locale = processedData;
			
			dispose();
			
//			log.info("----------------------LocaleManager Processor Finished----------------------------------");
			
		}
	}
}
