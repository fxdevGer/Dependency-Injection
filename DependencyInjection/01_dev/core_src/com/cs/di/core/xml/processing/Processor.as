/**
 * Copyright 21.07.2011 Christian Sobolewski
 * 
 * Usage : Processor
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
package com.cs.di.core.xml.processing {
	import com.cs.di.core.xml.processing.impl.objects.Vector3DProcessor;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.xml.processing.impl.ContextProcessor;
	import com.cs.di.core.xml.processing.impl.DefaultProcessor;
	import com.cs.di.core.xml.processing.impl.LogProcessor;
	import com.cs.di.core.xml.processing.impl.ObjectProcessor;
	import com.cs.di.core.xml.processing.impl.loader.LoaderGroupProcessor;
	import com.cs.di.core.xml.processing.impl.loader.LoaderTaskProcessor;
	import com.cs.di.core.xml.processing.impl.localization.LocaleManagerProcessor;
	import com.cs.di.core.xml.processing.impl.localization.LocaleProcessor;
	import com.cs.di.core.xml.processing.impl.localization.MessageBundleProcessor;
	import com.cs.di.core.xml.processing.impl.localization.MessageSourceProcessor;
	import com.cs.di.core.xml.processing.impl.mvc.EventSourceProcessor;
	import com.cs.di.core.xml.processing.impl.mvc.MVCProcessor;
	import com.cs.di.core.xml.processing.impl.objects.ConstructorArgsProcessor;
	import com.cs.di.core.xml.processing.impl.objects.MediaTaskProcessor;
	import com.cs.di.core.xml.processing.impl.objects.MethodProcessor;
	import com.cs.di.core.xml.processing.impl.objects.PropertyProcessor;

	/**
	 * @author Christian Sobolewski
	 */
	public class Processor {
		public static function getAttributesForProcessor(processor : String) : Array {
			switch(processor) {
				case "factory":
					return [];
					break;
//-----------------------------------------------Attributes for localization---------------------------------------------------
				case "localization":
					return [];
					break;
				case "localeManager":
					return [];
					break;
				case "defaultLocale":
					return ["language", "country", "ignoreCountry"];
					break;
				case "locale":
					return ["language", "country", "ignoreCountry"];
					break;
				case "messageSource":
					return ["id", "groupState", "groupLoad", "groupCache"];
					break;
				case "messageBundle":
					return ["id", "basename"];
					break;
//-----------------------------------------------Attributes for object---------------------------------------------------
				case "object":
					return ["id", "class", "ref", "initMethod", "lifetime", "childsInjection"];
					break;
				case "loaderGroup":
					return ["id", "groupState", "groupLoad", "groupCache"];
					break;
				case "loaderTask":
					return ["method"];
					break;
				case "constructor-args":
					return [];
					break;
				case "mediaTask":
					return ["id", "method"];
					break;
				case "method":
					return ["name", "value", "id-ref", "value-ref", "arguments"];
					break;
				case "property":
					return ["name", "value", "boolean", "id-ref", "value-ref"];
					break;
				case "vector3D":
					return ["name", "value", "id-ref", "value-ref"];
					break;
//-----------------------------------------------Attributes for mvc---------------------------------------------------
				case "action":
					return ["event-class", "event-name", "method"];
					break;
				case "event-source":
					return ["event-types", "transformer-object", "transformer-method", "controller"];
					break;
				case "interceptor":
					return ["event-class", "event-name", "method"];
					break;
//-----------------------------------------------Attributes for logging---------------------------------------------------
				case "logger":
					return [];
					break;
				case "log":
					return ["name", "level"];
					break;
				default:
					throw new ConfigurationError("Attributes for " + processor + " not found!");
			}
			return null;
		}

		public static function getChildrenForProcessor(processor : String) : Array {
			switch(processor) {
				case "context":
					return ["localization", "factory", "logger"];
				break;
				case "factory":
					return ["object"];
					break;
//-----------------------------------------------Children for localization---------------------------------------------------
				case "localization":
					return ["localeManager", "messageSource"];
					break;
				case "localeManager":
					return ["defaultLocale", "locale"];
					break;
				case "defaultLocale":
					return [];
				case "locale":
					return [];
					break;
				case "messageSource":
					return ["messageBundle"];
					break;
				case "messageBundle":
					return [];
					break;
//-----------------------------------------------Children for object---------------------------------------------------------
				case "object":
					return ["constructor-args", "loaderGroup", "mediaTask", "property", "method", "vector3D", "action", "event-source", "interceptor"];
					break;
				case "loaderGroup":
					return ["loaderTask"];
					break;
				case "loaderTask":
					return [];
					break;
				case "constructor-args":
					return ["boolean", "number", "int", "uint", "vector3D", "string", "array", "date", "id-ref"];
					break;
				case "mediaTask":
					return [];
					break;
				case "method":
					return [];
					break;
				case "property":
					return [];
					break;
				case "vector3D":
					return [];
					break;
//-----------------------------------------------Children for mvc-------------------------------------------------------------			
				case "action":
					return [];
					break;
				case "event-source":
					return [];
					break;	
				case "interceptor":
					return [];
					break;	
//-----------------------------------------------Children for logging---------------------------------------------------------
				case "logger":
					return ["log"];
					break;
				case "log":
					return [];
					break;
				default:
					throw new ConfigurationError("Children for " + processor + " not found!");
			}
			return null;
		}

		public static function getProcessor(processor : String) : IProcessor {
			switch(processor) {
				case "context":
					return new ContextProcessor();
				break;
				case "factory":
					return new DefaultProcessor();
					break;
//-----------------------------------------------Processors for localization---------------------------------------------------
				case "localization":
					return new DefaultProcessor();
					break;
				case "localeManager":
					return new LocaleManagerProcessor();
					break;
				case "defaultLocale":
					return new LocaleProcessor();
					break;
				case "locale":
					return new LocaleProcessor();
					break;
				case "messageSource":
					return new MessageSourceProcessor();
					break;
				case "messageBundle":
					return new MessageBundleProcessor();
					break;
//-----------------------------------------------Processors for object---------------------------------------------------------
				case "object":
					return new ObjectProcessor();
					break;
				case "constructor-args":
					return new ConstructorArgsProcessor();
					break;
				case "loaderGroup":
					return new LoaderGroupProcessor();
					break;
				case "loaderTask":
					return new LoaderTaskProcessor();
					break;
				case "mediaTask":
					return new MediaTaskProcessor();
					break;
				case "method":
					return new MethodProcessor();
					break;
				case "property":
					return new PropertyProcessor();
					break;
				case "vector3D":
					return new Vector3DProcessor();
					break;
//-----------------------------------------------Processors for mvc---------------------------------------------------------
				case "action":
					return new MVCProcessor();
					break;
				case "interceptor":
					return new MVCProcessor();
					break;
				case "event-source":
					return new EventSourceProcessor();
					break;
//-----------------------------------------------Processors for logging---------------------------------------------------------			
				case "logger":
					return new DefaultProcessor();
					break;
				case "log":
					return new LogProcessor();
					break;
				default:
					throw new ConfigurationError("Processor for " + processor + " not found!");
			}
			return null;
		}
	}
}
