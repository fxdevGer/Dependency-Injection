/**
 * Copyright 17.03.2010 Christian Sobolewski
 * 
 * Usage :	com.cs.di.core.loader.core.interfaces
 * 
 * Parameters :
 *
 * Description : 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.interfaces {
	import com.cs.di.core.loader.FileLoaderContext;
	import com.cs.di.core.loader.impl.LoaderGroup;
	/**
	 * @author Christian Sobolewski
	 */
	public interface ILoader {
		
		function createLoader() : void; 							// creates all task types that could be found in tasks
		
		function set fileLoader(fileLoader : FileLoaderContext) : void;	// set the fileLoader Instance to add each IFileLoader to the queue
				function get fileLoader() : FileLoaderContext;						// getter 
		
		function set loaderGroup(loaderGroup : LoaderGroup) : void;	// set the loaderGroup for setting each content on the right place
		
		function get loaderGroup() : LoaderGroup;					// getter
		

	}
}
