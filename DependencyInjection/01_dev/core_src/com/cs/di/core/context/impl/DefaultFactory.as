/**
 * Copyright 06.10.2010 Christian Sobolewski
 * 
 * usage : com.cs.di.core.context.impl
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * com.cs.di.core.context.impl.DefaultFactory
 * @author Christian Sobolewski
 */
package com.cs.di.core.context.impl {
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.impl.FileLoaderUtils;
	import com.cs.di.core.loader.impl.LoaderGroupCache;
	import com.cs.di.core.loader.impl.LoaderTask;
	import com.cs.di.core.localization.Locale;
	import com.cs.di.core.localization.MessageBundle;
	import com.cs.di.core.localization.impl.DefaultBundleLoader;

	import flash.utils.getDefinitionByName;
	
	use namespace csinject;
	
	/**
	 * @author Christian Sobolewski
	 */
	public class DefaultFactory implements IContextFactory {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(DefaultFactory));
		
		/**
		 * createObject is called if an object instance is created.
		 * classId = the name of the class that has to be created
		 * id = the identifier
		 * initMethod = a method in the classId that is called after all object were created
		 * args = constructor arguments
		 */
		
		public function createObject(id : String, classId : String, initMethod : String, expire : String, args : Array) : void {
//			log.debug("Create Object " + id + " as  " + classId + " has initMethod " + initMethod + " and Object lifetime : " + expire);
			var m : ContextModel = new ContextModel();
			m.id = id;
			m.instance = createInstance(classId, args);
			m.initMethod = initMethod;
			m.expire = (expire == "expire") ? true : false;
			
			ContextUtils.addInstanceModel(m);
		}
		
		/**
		 * createEventClass used to create Event Class objects.
		 * classId = the Class name
		 * args = constructor arguments
		 */
		
		public function createEventClass(classId : String, args : Array) : * {
			var ClassReference : Class;
			try {
				ClassReference = getDefinitionByName(classId) as Class;
			} catch(e : ReferenceError) {
//				if an object could not be injected the ConfigurationError will be fired
				throw new ConfigurationError("Reference Error " + classId + " could not be found. Check if you linked that Class.");
			}
			// TODO : Check if it is necessary to have arguments as Array in an Event Class!
//			return createNewInstance(ClassReference, args[0]);
			return createNewInstance(ClassReference, args);
		}
		
		/**
		 * createLocale called if a <code>Locale</code> Object has to be created
		 */
		
		public function createLocale(language : String = "", country : String = "", igCountry : String = "") : Locale {
			return new Locale(language, country, igCountry);
		}
		
		/**
		 * createMessageBundle creates a <code>MessageBundle</code> by param id
		 */
		
		public function createMessageBundle(id : String) : MessageBundle {
			var m : MessageBundle = new MessageBundle();
			m.id = id;
			return m;
		}
		
		/**
		 * createBundleLoader creates a <code>DefaultBundleLoader</code> by basename
		 */
		
		public function createBundleLoader(bundle : MessageBundle, loc : Locale) : Function {
			var def : DefaultBundleLoader = new DefaultBundleLoader(bundle, loc);
			return def.callBack();
		}
		
		/**
		 * createTask creates a <code>LoaderTask</code> with given Params
		 */
		
		public function createTask(path : String, objRef : String = "", method : String = "", callBack : Function = null) : LoaderTask {
//			log.debug("Create Loader Task for " + objRef + " has Path: " + path + " inject into " + method + " | " + callBack);
			var t : LoaderTask = new LoaderTask();
			t.path = path;
			t.type = FileLoaderUtils.getTypeFromString(path, LoaderGroupCache.CACHE_OFF.toString());
			t.objRef = objRef;
			t.method = method;
			if (callBack != null) t.callBack = callBack;
			return t;
		}
		
		private function createInstance(classId : String, args : Array) : * {
			var ClassReference : Class;
			try {
				ClassReference = getDefinitionByName(classId) as Class;
			} catch(e : ReferenceError) {
//				if an object could not be injected the ConfigurationError will be fired
				throw new ConfigurationError("Reference Error " + classId + " could not be found.");
			}
			return createNewInstance(ClassReference, args);
		}
		
		private function createNewInstance (type:Class, params:Array) : Object {
			switch (params.length) {
				// Now this is really stupid. But there is no "Class.createInstance(args)" in AS3
				case 0: return new type();
				case 1: return new type(params[0]);				
				case 2: return new type(params[0], params[1]);
				case 3: return new type(params[0], params[1], params[2]);
				case 4: return new type(params[0], params[1], params[2], params[3]);
				case 5: return new type(params[0], params[1], params[2], params[3], params[4]);
				case 6: return new type(params[0], params[1], params[2], params[3], params[4], params[5]);
				case 7: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
				case 8: return new type(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
				default: throw new ArgumentError("Unsupported number of Constructor args: " + params.length);
			}
		}
	}
}
