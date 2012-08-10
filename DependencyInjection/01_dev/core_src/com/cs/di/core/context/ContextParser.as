/**
 * Copyright 11.03.2010 Christian Sobolewski
 * 
 * Usage :	_contextParser = new ContextParser();
 *			
 *			_contextParser.addFile("config/logging.xml");
 *			_contextParser.addFile("config/context.xml");
 *			
 *			_contextParser.addEventListener(Event.COMPLETE, onComplete);
 *			_contextParser.addEventListener(ErrorEvent.ERROR, onError);
 *			
 *			_contextParser.start();
 * 
 * Parameters :
 *
 * Description : The ContextParser Class is the main entry of the Framework. 
 * 				 It takes Context XML files, loads them and parses them.
 * 				 If Event.COMPLETE is fired Dependency Injection is ready to use.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context {
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.context.impl.ContextNameSpace;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.types.XMLLoader;

	import flash.events.ErrorEvent;
	import flash.events.EventDispatcher;
	import flash.xml.XMLDocument;

	/**
	 * @author Christian Sobolewski
	 */
	public class ContextParser extends EventDispatcher {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ContextParser));
		
		use namespace csinject;
		
		private var _xmlLoader : XMLLoader;
		private var _xmlContent : Vector.<XMLDocument>;
		
		public function ContextParser() {
			super(this);
			Context.parser = this;
			Context.fileLoader; // called here to be save that the FileLoader Instance is created.
			_xmlContent = new Vector.<XMLDocument>();
		}

		/**
		 * 	call method start to begin loading context files
		 */
		public function start() : void {
			if (_xmlLoader != null) _xmlLoader.sequentialLoading();
			else {
				throw new ConfigurationError("No context.xml or logging.xml found!");
			}
		}

		/**
		 * 	add xml files 
		 */
		public function addFile(p : String) : void {
			if (_xmlLoader == null) {
				_xmlLoader = new XMLLoader(null);
				_xmlLoader.dispatcher = this;
				_xmlLoader.addEventListener(FileLoaderEvent.COMPLETE, handleXML, false, 0, true);
				_xmlLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleXML, false, 1, true);
				addEventListener(ErrorEvent.ERROR, handleContextLoadingError);
			}
			_xmlLoader.addItem(p+"?cachebuster=" + Math.random());
		}

		/**
		 * 	called for each xml file that has been loaded
		 */
		private function handleXML(event : FileLoaderEvent) : void {
			var xLoader : XMLLoader = event.target as XMLLoader;
			switch(event.type) {
				case FileLoaderEvent.COMPLETE:
					_xmlContent.push(event.data.xml);
					break;
				case FileLoaderEvent.QUEUE_COMPLETE:
					removeEventListener(ErrorEvent.ERROR, handleContextLoadingError);
					xLoader.removeEventListener(FileLoaderEvent.COMPLETE, handleXML);
					xLoader.removeEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleXML);
					xLoader = null;
					context();
					break;
			}
		}

		/**
		 * 	called if each xml file has been loaded.
		 */
		private function context() : void {
			for each (var xmlDoc : XMLDocument in _xmlContent) {
				xmlDoc.ignoreWhite = true;
				var node : XML = new XML(xmlDoc);
				
				default xml namespace = ContextNameSpace.DI_NAMESPACE;
				
				var qname : QName = node.name() as QName;

				if (qname.uri != ContextNameSpace.DI_NAMESPACE_URI) {
					throw new ConfigurationError("Root node is not in Namespace " + ContextNameSpace.DI_NAMESPACE_URI);
				} else if (qname.localName != "context") {
					throw new ConfigurationError("Root node is not <context/>");
				}

				// start parsing the context
				Context.config.parse(node);
			}
			
			_xmlContent = null;
			
			// after all objects were parsed just call the FileLoaderContext.factory.fileLoader.load method to start loading
			Context.fileLoader.activeLoaderGroupLoading();
		}
		
		/**
		 * 	handleContextLoadingError throws Exception if *.xml not found.
		 */
		
		private function handleContextLoadingError(event : ErrorEvent) : void {
			throw new Error(event.text + " could not loaded.");
		}
		
	}
}
