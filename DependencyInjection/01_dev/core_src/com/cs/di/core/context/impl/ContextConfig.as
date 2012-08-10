/**
 * Copyright 05.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The Base Parser Class for context Files.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context.impl {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.xml.processing.IProcessor;
	import com.cs.di.core.xml.processing.Processor;

	/**
	 * @author Christian Sobolewski
	 */
	public class ContextConfig {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ContextConfig));
		
		protected var _factory : DefaultFactory;
		
		public function ContextConfig() {}

		/**
		 * 	parses each <code>xml</code> that has been given by the ContextParser
		 */
		public function parse(node : XML) : void {
			var contextProcessor : IProcessor =  Processor.getProcessor("context");
			contextProcessor.children = Processor.getChildrenForProcessor("context");

			var qName : QName;
			var decendantList : XMLList;
			var childContextPro : IProcessor;
			var childs : String;

			for each (childs in contextProcessor.children) {
				for (var i : int = 0;i < ContextNameSpace.NAMESPACES.length; i++) {
					qName = new QName(ContextNameSpace.NAMESPACES[i], childs);

					decendantList = node.descendants(qName);

					if (decendantList.length() > 0) {
						childContextPro = Processor.getProcessor(childs);
						childContextPro.children = Processor.getChildrenForProcessor(childs);
						childContextPro.attributes = Processor.getAttributesForProcessor(childs);
						childContextPro.xmlList = decendantList;
						childContextPro.factory = factory;
						childContextPro.proceedList();
					}
				}
			}

			contextProcessor.dispose();

			LogContext.refreshLoggerLevels();
		}
		
		
		/**
		 * 	returns and creates the <code>DefaultFactory</code>
		 */
		
		public function get factory() : DefaultFactory {
			if (_factory == null) _factory = new DefaultFactory();
			return _factory;
		}
	}
}
