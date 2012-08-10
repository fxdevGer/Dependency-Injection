/**
 * Copyright 21.07.2011 Christian Sobolewski
 * 
 * Usage : com.cs.di.core.xml.processing.impl.ObjectProcessor
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
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ObjectProcessor extends AbstractProcessor {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ObjectProcessor));

		public function ObjectProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.info("----------------------Object Processor Start----------------------------------");
			var objProcessor : IProcessor;
			var qName : QName;
			var decendantList : XMLList;
			var childs : String;
			var key : String;
			var i : int = 0;

			var dic : Dictionary = new Dictionary(false);

			// parses each attribute into Dictionary
			for each (key in attributes) {
				if (key == attributes[5]) {
					if (getAttributeFromNode(xmlNode, key) != "") {
						dic[key] = getAttributeFromNode(xmlNode, key);
					} else dic[key] = false;
//					log.fatal(key + " = fetched attribute: " + dic[key]);
				} else dic[key] = getAttributeFromNode(xmlNode, key);
//				log.fatal(key + " = fetched attribute: " + dic[key]);
			}

			// set each Object attribute id to objectId
			objectId = dic[attributes[0]];

			// set each ObjectDictionary to processedData
			processedData = dic;

			for each (childs in children) {
				for (i = 0;i < ContextNameSpace.NAMESPACES.length; i++) {
					qName = new QName(ContextNameSpace.NAMESPACES[i], childs);
					
					decendantList = xmlNode.descendants(qName);
					
					if (decendantList.length() > 0) {
						if (childs != children[0]) {
							// if <code>object</code> has Class Attribute node create new Instance
							createObject([]);
						}
						
						for (var j : int = 0; j < decendantList.length(); j++) {
							objProcessor = Processor.getProcessor(childs);
							objProcessor.children = Processor.getChildrenForProcessor(childs);
							objProcessor.attributes = Processor.getAttributesForProcessor(childs);
							objProcessor.factory = factory;
							objProcessor.objectId = objectId;
							objProcessor.xmlNode = decendantList[j];
							objProcessor.childsInjection = (dic[attributes[5]] == "afterLoading") ? true : false;
							objProcessor.proceedNode();
						}

						// if <code>object</code> has <code>constructor-args</code> node create new Instance with args
						if (childs == "constructor-args") {
							createObject(objProcessor.processedData);
							objProcessor.dispose();
						}
					} else {
						if (childs != children[0]) {
							// if <code>object</code> has Class Attribute node create new Instance
							createObject([]);
						}
					}
				}
			}
			
			dispose();

//			log.info("----------------------Object Processor Finished----------------------------------");
		}

		private function createObject(data : *) : void {
//			log.fatal("processedData: " + processedData);
//			log.fatal("attributes: " + attributes.length);

			// if Context.getObject contains Object that has already created nothing happens here
			if (attributes.length > 0 && processedData != undefined) {
				if (Context.getObject(processedData[attributes[0]], true) == null && processedData[attributes[1]].length > 0) {
					factory.createObject(processedData[attributes[0]], processedData[attributes[1]], processedData[attributes[3]], processedData[attributes[4]], data);

					// if object has a ref Attribute this tries to inject the given reference into this object
					if (processedData[attributes[2]]) {
						try {
							Context.getObject(processedData[attributes[0]])[processedData[attributes[2]]] = Context.getObject(processedData[attributes[2]]);
						} catch(e : ReferenceError) {
							// if a object could not be injected the ErrorEvent will be fired
							throw new ConfigurationError(processedData[attributes[2]] + " could not be injected to : " + processedData[attributes[0]]);
						}
					}
				}
			}
		}

		public function toString() : String {
			return "object";
		}
	}
}
