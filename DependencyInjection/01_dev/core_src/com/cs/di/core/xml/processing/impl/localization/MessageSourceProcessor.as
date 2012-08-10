/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : MessageSourceProcessor
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
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.impl.LoaderGroup;
	import com.cs.di.core.loader.impl.LoaderGroupCache;
	import com.cs.di.core.loader.impl.LoaderGroupLoad;
	import com.cs.di.core.loader.impl.LoaderGroupState;
	import com.cs.di.core.localization.core.LocaleContext;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	/**
	 * @author Christian Sobolewski
	 */
	public class MessageSourceProcessor extends AbstractProcessor {
		
		use namespace csinject;
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MessageSourceProcessor));
		
		public function MessageSourceProcessor() {
			super();
		}
		
		public override function proceedNode():void {
//			log.info("----------------------MessageSourceProcessor Processor Start----------------------------------");
			
			var state : String = (getAttributeFromNode(xmlNode, "groupState").toUpperCase() == "") ? LoaderGroupState.ACTIVE.toString() : getAttributeFromNode(xmlNode, "groupState").toUpperCase();
			var load : String = (getAttributeFromNode(xmlNode, "groupLoad").toUpperCase() == "") ? LoaderGroupLoad.SEQUENTIAL.toString() : getAttributeFromNode(xmlNode, "groupLoad").toUpperCase();
			var cache : String = (getAttributeFromNode(xmlNode, "groupCache").toUpperCase() == "") ? LoaderGroupCache.CACHE_ON.toString() : getAttributeFromNode(xmlNode, "groupCache").toUpperCase();
			
			processedData = new LoaderGroup();
			processedData.state = new LoaderGroupState(state);
			processedData.load = new LoaderGroupLoad(load);
			processedData.cache = new LoaderGroupCache(cache);
			processedData.id = getAttributeFromNode(xmlNode, "id");
			
			var objProcessor : IProcessor;
			var qName : QName;
			var decendantList : XMLList;
			var childs : String;
			var i : int = 0;
			
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
			
			LocaleContext.locale = [];
			
			// add each created LoaderGroup to the FileLoader
			Context.fileLoader.addLoaderGroup(processedData);
			
			dispose();
			
//			log.info("----------------------MessageSourceProcessor Processor Finished--------------------------------");
		}
		
	}
}
