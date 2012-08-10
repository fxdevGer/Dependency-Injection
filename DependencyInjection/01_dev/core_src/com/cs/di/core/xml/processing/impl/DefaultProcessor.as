/**
 * Copyright 22.07.2011 Christian Sobolewski
 * 
 * Usage : com.cs.di.core.xml.processing.impl.DefaultProcessor
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
package com.cs.di.core.xml.processing.impl {
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	/**
	 * @author Christian Sobolewski
	 */
	public class DefaultProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(DefaultProcessor));
		
		public function DefaultProcessor() {
			super();
		}
		
		public override function proceedList() : void {
			var objProcessor : IProcessor;
			var qName : QName;
			var decendantList : XMLList;
			var childs : String;
			
			for each (childs in children) {
				for (var i:int = 0;i < ContextNameSpace.NAMESPACES.length; i++) {
					qName = new QName(ContextNameSpace.NAMESPACES[i], childs);
					
					decendantList = xmlList.descendants(qName);
					
					if (decendantList.length() > 0) {
						
						if (childs == "log") LogContext.logger.connectSocket(); // activates Flash Socket Connection if a Logger has found
						
						for (var j : int = 0; j < decendantList.length(); j++) {
							objProcessor = Processor.getProcessor(childs);
							objProcessor.children = Processor.getChildrenForProcessor(childs);
							objProcessor.attributes = Processor.getAttributesForProcessor(childs);
							objProcessor.xmlNode = decendantList[j];
							objProcessor.factory = factory;
							objProcessor.proceedNode();
						}
					}
				}
			}
			
			dispose();
			
//			log.info("----------------------Default Processor Finished----------------------------------");
		}
	}
}
