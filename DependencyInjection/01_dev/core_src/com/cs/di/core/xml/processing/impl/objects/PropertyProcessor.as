/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.xml.processing.impl
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.xml.processing.impl.PropertyProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.objects {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.csinject;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class PropertyProcessor extends AbstractProcessor {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(PropertyProcessor));
		use namespace csinject;
		public function PropertyProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.warn("proceedNode: " + objectId + " | " + attributes);

//			["name", "value", "boolean", "id-ref", "value-ref"];

			var name : String = getAttributeFromNode(xmlNode, attributes[0]);
			var value : String = getAttributeFromNode(xmlNode, attributes[1]);
			var booleanValue : String = getAttributeFromNode(xmlNode, attributes[2]);
			var idRef : String = getAttributeFromNode(xmlNode, attributes[3]);
			var valueRef : String = getAttributeFromNode(xmlNode, attributes[4]);
			var valueSplitNumber : Array = value.match(/[0-9]{1,5}/);
			var valueSplitType : Array = value.match(/[[0-9]/);
			
			// if childsInjection is true set all Properties to objectId
			if (!childsInjection) {
				try {
					switch(true) {
						case booleanValue != "" && idRef == "":
							/**
							 * 	Note : BooleanValue just works in simple Mode. 
							 */
							Context.getObject(objectId)[name] = (booleanValue == "true") ? true : false;
						break;
						case value != "" && idRef == "":
							Context.getObject(objectId)[name] = value;
							break;
						case idRef != "":
							if (valueRef != "") {
								if (value != "") {
									try {
										if (valueSplitNumber[0] != null && valueSplitType[0] == "[") {
											Context.getObject(objectId)[name] = Context.getObject(idRef)[valueRef][valueSplitNumber[0]];
										} else Context.getObject(idRef)[valueRef][name] = value;
									} catch (e : ReferenceError) {
										throw new ConfigurationError(idRef + "." + valueRef + "." + name + " = " + value + " could not be set!");
									}
								} else {
									try {
										Context.getObject(objectId)[name] = Context.getObject(idRef)[valueRef];
									} catch (e : ReferenceError) {
										throw new ConfigurationError(idRef + "." + valueRef + " could not be injected into " + objectId + "." + name);
									}
								}
							} else {
								try {
									Context.getObject(objectId)[name] = Context.getObject(idRef);
								} catch (e : ReferenceError) {
									throw new ConfigurationError(idRef + " could not be injected into " + objectId);
								}
							}
							break;
					}
				} catch (e : ReferenceError) {
					throw new ConfigurationError("Setter " + name + " as Property for " + objectId + " not found!");
				}

				dispose();
			} else {
				// If childsInjection false, push all Processors into ContextModel.
				Context.getContextModel(objectId).processors.push(this);
			}
		}
	}
}
