/**
 * Copyright 16:04:25 24.11.2011 Christian Sobolewski
 * 
 * Usage : IObjectFactory
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
  * History :	-1.1 Refactored into Framework Utils
 * 	
 * 				-1.0 Initial Release
 */
package com.cs.utils.objectpool {
	/**
	 * @author Christian Sobolewski
	 */
	public interface IPoolObjectFactory {
		function createObject(c : Class, id : String) : IPoolObject;
	}
}
