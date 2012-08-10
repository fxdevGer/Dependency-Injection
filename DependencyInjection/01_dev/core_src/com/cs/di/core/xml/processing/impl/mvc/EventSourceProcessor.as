/**
 * Copyright 25.07.2011 Christian Sobolewski
 * 
 * Usage : EventSourceProcessor
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
package com.cs.di.core.xml.processing.impl.mvc {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.mvc.EventSource;
	import com.cs.di.core.mvc.FrontController;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	import flash.utils.Dictionary;

	/**
	 * @author Christian Sobolewski
	 */
	public class EventSourceProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(EventSourceProcessor));
		
		public function EventSourceProcessor() {
			super();
		}
		
		public override function proceedNode():void {
			var key : String;
			var attr : String;
			var dic : Dictionary = new Dictionary(false);
			
			for each (key in attributes) {
				attr = getAttributeFromNode(xmlNode, key);
				dic[key] = attr;
			}
			
			try {
				var evTypes : Array = dic[attributes[0]].split(",");
				var eventSource : EventSource = new EventSource(Context.getObject(dic[attributes[1]]), Context.getObject(dic[attributes[1]])[dic[attributes[2]]], evTypes);
				FrontController.root().registerEventSource(eventSource);
			} catch(e : ReferenceError) {
				throw new ConfigurationError("event-source node could not created for : " + dic[attributes[1]]);
			}
			
		}
		
	}
}
