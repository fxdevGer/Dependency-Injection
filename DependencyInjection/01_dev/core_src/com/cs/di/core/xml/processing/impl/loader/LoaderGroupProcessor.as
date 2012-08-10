/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.xml.processing.impl.loader
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.xml.processing.impl.loader.LoaderGroupProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.loader {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.impl.LoaderGroup;
	import com.cs.di.core.loader.impl.LoaderGroupCache;
	import com.cs.di.core.loader.impl.LoaderGroupLoad;
	import com.cs.di.core.loader.impl.LoaderGroupState;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderGroupProcessor extends AbstractProcessor {
		
		use namespace csinject;
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LoaderGroupProcessor));

		public function LoaderGroupProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.debug("proceed Node : " + xmlNode.toString());

			processedData = new LoaderGroup();

			var state : String = (getAttributeFromNode(xmlNode, "groupState").toUpperCase() == "") ? LoaderGroupState.ACTIVE.toString() : getAttributeFromNode(xmlNode, "groupState").toUpperCase();
			var load : String = (getAttributeFromNode(xmlNode, "groupLoad").toUpperCase() == "") ? LoaderGroupLoad.SEQUENTIAL.toString() : getAttributeFromNode(xmlNode, "groupLoad").toUpperCase();
			var cache : String = (getAttributeFromNode(xmlNode, "groupCache").toUpperCase() == "") ? LoaderGroupCache.CACHE_ON.toString() : getAttributeFromNode(xmlNode, "groupCache").toUpperCase();

			processedData.state = new LoaderGroupState(state);
			processedData.load = new LoaderGroupLoad(load);
			processedData.cache = new LoaderGroupCache(cache);
			processedData.id = getAttributeFromNode(xmlNode, "id");
			
			var objProcessor : IProcessor;
			var childs : String;
			var qName : QName;
			var decendantList : XMLList;
			
			for each (childs in children) {
				qName = new QName(ContextNameSpace.DI_NAMESPACE, childs);
				
				decendantList = xmlNode.descendants(qName);
				
				objProcessor = Processor.getProcessor(childs);
				objProcessor.children = Processor.getChildrenForProcessor(childs);
				objProcessor.attributes = Processor.getAttributesForProcessor(childs);
				objProcessor.xmlList = decendantList;
				objProcessor.processedData = processedData;
				objProcessor.factory = factory;
				objProcessor.proceedList();
			}
			
			// add each created LoaderGroup to the FileLoader
			Context.fileLoader.addLoaderGroup(processedData);
			
			dispose();
			
		}
	}
}
