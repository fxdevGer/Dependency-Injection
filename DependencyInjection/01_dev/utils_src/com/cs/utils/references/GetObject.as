/**
 * Copyright 01.01.2008 Christian Sobolewski
 * 
 * Usage :	GetObject(className)
 * 
 * Parameters :	
 *
 * Description : The GetObject Class returns an Object by a given Class name.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.references {
	import flash.utils.getDefinitionByName;
	
	/**
	 * @author Christian Sobolewski
	 */
	public function GetObject(className : String) : *
	{
		var ClassReference : Class = getDefinitionByName(className) as Class;
			
		return new ClassReference();
	}
}
