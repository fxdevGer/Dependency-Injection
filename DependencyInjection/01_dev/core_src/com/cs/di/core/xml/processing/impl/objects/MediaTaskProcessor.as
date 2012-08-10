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
 * @file com.cs.di.core.xml.processing.impl.MediaTaskProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.objects {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class MediaTaskProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MediaTaskProcessor));

		public function MediaTaskProcessor() {
			super();
		}

		public override function proceedNode() : void {
//			log.warn("proceedNode: " + objectId + " | " + attributes);

			var method : String = getAttributeFromNode(xmlNode, attributes[1]);

			var nodeLength : int = xmlNode.children().length();
			var node : XML;

			for (var i : int = 0; i < nodeLength;i++) {
				node = xmlNode.children()[i];

				try {
					Context.getObject(objectId)[method] = node.toString();
				} catch(e : ReferenceError) {
					throw new ConfigurationError(node.toString() + " could not be injected into " + objectId + "." + method);
				}
			}
			
			dispose();
		}
	}
}
