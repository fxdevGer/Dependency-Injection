/**
 * Copyright 11.03.2010 Christian Sobolewski
 * 
 * Usage :	
 * 
 * Parameters :
 *
 * Description : The Context Class is the most important Class in this Framework.
 * 				 Call Context.getObject(name) for getting your UI instances.
 * 				 It holds the global StyleSheet Object, Information about the 
 * 				 monitoring process and the FileLoader instance. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context {
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.context.impl.ContextConfig;
	import com.cs.di.core.context.impl.ContextModel;
	import com.cs.di.core.context.impl.ContextUtils;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.FileLoaderContext;
	import com.cs.di.core.loader.core.monitor.ProgressMonitorData;
	import com.cs.di.core.xml.processing.IProcessor;

	import flash.events.Event;
	import flash.text.StyleSheet;
	
	use namespace csinject;

	/**
	 * @author Christian Sobolewski
	 */
	public class Context {
		// private static const log : Logger = LogContext.getLogger(getQualifiedClassName(Context));
		protected static var _contextConfig : ContextConfig;
		protected static var _fileLoader : FileLoaderContext;
		protected static var _parser : ContextParser;
		protected static var _styles : StyleSheet;
		protected static var _progressData : ProgressMonitorData;

		public function Context() {}

		csinject static function contextIsReady() : void {

			// if an Object has an init param the init params are taken as a init method call
			// so that each Object knows when the application is ready to start!

			for each (var context : ContextModel in ContextUtils.getModels()) {
				// calls initMethod in instance
				if (context.initMethod && context.instance && !context.isInitialized) {
					context.instance[context.initMethod]();
					context.isInitialized = true;
				}
				// if context.processor.length greater zero, all childs are injected after loading process
				if (context.processors.length > 0) {
					for each (var p : IProcessor in context.processors) {
						p.childsInjection = false;
						p.proceedNode();
					}
					// null context.processors to avoid double processing
					context.processors = new Vector.<IProcessor>();
				}
			}

			// dispatch ContextEvent.COMPLETE if the context.xml is parsed
			if (parser.hasEventListener(Event.COMPLETE)) {
				parser.dispatchEvent(new Event(Event.COMPLETE));
			} else throw new ConfigurationError("ContextParser has no Event.COMPLETE Listener");
		}

		/**
		 * 	deletes all Objects that has an <code>lifeTime</code> Attribute
		 * 	or delete one Object with a given key
		 */
		public static function lifeTime(key : String = "") : void {
			if (key != "") ContextUtils.removeInstanceModel(key);
			else {
				for each (var context : ContextModel in ContextUtils.getModels()) {
					if (context.expire) ContextUtils.removeInstanceModel(context.id);
				}
			}
		}

		/**
		 * 	returns the given instance by name
		 */
		public static function getObject(name : String, check : Boolean = false) : * {
			return ContextUtils.getInstanceByName(name, check);
		}

		/**
		 * 	returns the given instance by name
		 */
		csinject static function getContextModel(name : String) : ContextModel {
			return ContextUtils.getContextModelByName(name);
		}

		/**
		 * 	returns <code>ContextConfig</code>
		 */
		csinject static function get config() : ContextConfig {
			if (_contextConfig == null) _contextConfig = new ContextConfig();
			return _contextConfig;
		}

		/**
		 * 	returns <code>FileLoader</code>
		 */
		csinject static function get fileLoader() : FileLoaderContext {
			if (_fileLoader == null) {
				config.factory.createObject("fileLoader", "com.cs.di.core.loader.FileLoaderContext", "", "", []);
				_fileLoader = getObject("fileLoader");
			}
			return _fileLoader;
		}

		/**
		 * 	setter for File(s) monitoring as <code>ProgressMonitorData</code>
		 */
		public static function set progressData(progressData : ProgressMonitorData) : void {
			_progressData = progressData;
		}

		/**
		 * 	getter for File(s) monitoring as <code>ProgressMonitorData</code> call if you need to show File loading Progress
		 */
		public static function get progressData() : ProgressMonitorData {
			return _progressData;
		}

		/**
		 * setter <code>StyleSheet</code>
		 */
		public static function set styleSheet(style : StyleSheet) : void {
			_styles = style;
		}

		/**
		 * getter <code>StyleSheet</code>
		 */
		public static function get styleSheet() : StyleSheet {
			return _styles;
		}

		/**
		 * 	settter <code>ContextParser</code>
		 */
		csinject static function set parser(p : ContextParser) : void {
			_parser = p;
		}

		/**
		 * 	getter <code>ContextParser</code>
		 */
		csinject static function get parser() : ContextParser {
			return _parser;
		}
	}
}
