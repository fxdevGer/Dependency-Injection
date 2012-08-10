/**
 * Copyright 06.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : Interface for the DefaultContext Factory
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context.impl {
	import com.cs.di.core.loader.impl.LoaderTask;
	import com.cs.di.core.localization.Locale;
	import com.cs.di.core.localization.MessageBundle;

	/**
	 * @author Christian Sobolewski
	 */
	public interface IContextFactory {
		
		/**
		 * 	creates a Class Instance by classId
		 */
		
		function createObject(id : String, classId : String, initMethod : String, expire : String, args : Array) : void;
		
		/**
		 * 	creates a EventClass Instance by classId
		 */
		
		function createEventClass(classId : String, args : Array) : *;
		
		/**
		 * 	creates a <code>Locale</code> Instance
		 */
		
		function createLocale(language : String = "", country : String = "", igCountry : String = "") : Locale;
		
		/**
		 * 	creates a <code>MessageBundle</code> Instance by id
		 */
		
		function createMessageBundle(id : String) : MessageBundle;
		
		/**
		 * 	creates a <code>DefaultBundleLoader</code> Instance by id
		 */
		
		function createBundleLoader(bundle : MessageBundle, loc : Locale) : Function;
		
		/**
		 * 	creates a <code>LoaderTask</code>
		 */
		
		function createTask(path : String, objRef : String = "", method : String = "", callBack : Function = null) : LoaderTask;
	}
}
