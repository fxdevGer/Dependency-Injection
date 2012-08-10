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
 * @file com.cs.di.core.xml.processing.impl.LogProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.LogUtils;
	import com.cs.di.core.xml.processing.AbstractProcessor;

	import flash.utils.Dictionary;


	/**
	 * @author Christian Sobolewski
	 */
	public class LogProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LogProcessor));
		
		public function LogProcessor() {
			super();
		}
		
		public override function proceedNode():void {
			var key : String;
			var attr : String;
			var dic : Dictionary = new Dictionary(false);
			
			for each (key in attributes) {
				attr = getAttributeFromNode(xmlNode, key);
				if (attr != "") dic[key] = attr;
			}
			
			LogContext.factory.addLogLevel(dic[attributes[0]], LogUtils.getLevelByName(dic[attributes[1]]));
			
			dispose();
		}
	}
}
