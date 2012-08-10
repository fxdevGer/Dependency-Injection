/**
 * Copyright 11.08.2011 Christian Sobolewski
 * 
 * Usage : Vector3DProcessor
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
package com.cs.di.core.xml.processing.impl.objects {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.csinject;
	import com.cs.di.core.xml.processing.AbstractProcessor;
	import com.cs.di.core.xml.processing.impl.ProcessingUtils;

	/**
	 * @author Christian Sobolewski
	 */
	public class Vector3DProcessor extends AbstractProcessor {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(Vector3DProcessor));
		
		use namespace csinject;
		
		public function Vector3DProcessor() {
			super();
		}

		public override function proceedNode() : void {
			var name : String = getAttributeFromNode(xmlNode, attributes[0]);
			var value : String = getAttributeFromNode(xmlNode, attributes[1]);
			var idRef : String = getAttributeFromNode(xmlNode, attributes[2]);
			var valueRef : String = getAttributeFromNode(xmlNode, attributes[3]);
//			log.info('valueRef: ' + (valueRef));
//			log.info('idRef: ' + (idRef));

			if (!childsInjection) {
				try {
					switch(true) {
						case value != "" && idRef == "":
							Context.getObject(objectId)[name] = ProcessingUtils.getVector3D(value.split(","));
							break;
						case idRef != "":
							if (valueRef != "") {
								if (value != "") {
									try {
										Context.getObject(idRef)[valueRef][name] = ProcessingUtils.getVector3D(value.split(","));
									} catch (e : ReferenceError) {
										throw new ConfigurationError(idRef + "." + valueRef + "." + name + " = " + value + " could not be set!");
									}
								}
							}
							break;
					}
				} catch(e : ReferenceError) {
					throw new ConfigurationError("Setter " + name + " as Vector3D for " + objectId + " not found!");
				}
			} else {
				// If childsInjection false, push all Processors into ContextModel.
				Context.getContextModel(objectId).processors.push(this);
			}
		}
	}
}
