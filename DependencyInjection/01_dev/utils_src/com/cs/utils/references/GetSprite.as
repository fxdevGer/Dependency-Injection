/**
 * Copyright 01.01.2008 Christian Sobolewski
 * 
 * Usage :	GetSprite(className)
 * 
 * Parameters :	
 *
 * Description : The GetSprite Class returns a Sprite from a swf Library
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.references {
	import flash.display.Sprite;	
	
	/**
	 * @author Christian Sobolewski
	 */
	
	public function GetSprite(className : String) : Sprite
	{
		return GetObject(className) as Sprite;
	}
}
