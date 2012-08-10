/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.xml.processing.impl.mvc.MVCProcessor
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.xml.processing.impl.mvc.MVCProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.mvc {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.mvc.FrontController;
	import com.cs.di.core.mvc.impl.DelegateAction;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	import flash.utils.Dictionary;

	/**
	 * @author Christian Sobolewski
	 */
	public class MVCProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MVCProcessor));
		
		public function MVCProcessor() {
			super();
		}
		
		public override function proceedNode():void {
//			log.info('proceedNode: ' + (proceedNode));
			var key : String;
			var attr : String;
			var dic : Dictionary = new Dictionary(false);
			
			for each (key in attributes) {
				attr = getAttributeFromNode(xmlNode, key);
				dic[key] = attr;
			}
			
			try {
				var e : * = factory.createEventClass(dic[attributes[0]], [dic[attributes[1]]/*, ref*/]);
				FrontController.root().registerAction(new DelegateAction(Context.getObject(objectId)[dic[attributes[2]]]), e.constructor,  dic[attributes[1]]);
			} catch(e : ReferenceError) {
				throw new ConfigurationError(dic[attributes[0]]+ " could not created for : " + objectId);
			}
			
			dispose();
			
		}
		
	}
}
