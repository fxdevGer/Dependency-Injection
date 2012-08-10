/**
 * Copyright 01.01.2008 Christian Sobolewski
 * 
 * Usage :	GetMovieClip(className)
 * 
 * Parameters :	
 *
 * Description : The GetMovieClip Class returns a MovieClip by a given Class name.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.utils.references {
	import flash.display.MovieClip;
	
	/**
	 * @author Christian Sobolewski
	 */

	public function GetMovieClip(className : String) : MovieClip {
		return GetObject(className) as MovieClip;
	}
}
