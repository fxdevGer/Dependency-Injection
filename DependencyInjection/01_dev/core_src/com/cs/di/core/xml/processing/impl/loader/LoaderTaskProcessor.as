/**
 * Copyright 2011 Christian Sobolewski
 * 
 * usage : com.cs.di.core.xml.processing.impl.loader.impl
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file com.cs.di.core.xml.processing.impl.loader.SimpleProcessor.as
 * @author Christian Sobolewski
 */
package com.cs.di.core.xml.processing.impl.loader {
	import com.cs.di.core.xml.processing.AbstractProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderTaskProcessor extends AbstractProcessor {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LoaderTaskProcessor));

		public function LoaderTaskProcessor() {
			super();
		}

		public override function proceedList() : void {
			var listLength : int = xmlList.children().length();
			var node : XML;
			
			for (var i : int = 0 ; i < listLength;i++) {
				node = xmlList.children()[i];
				processedData.addTask(factory.createTask(node.toString(), processedData.id, getAttributeFromList(xmlList, attributes[0])));
			}
			
			dispose();
		}
	}
}
