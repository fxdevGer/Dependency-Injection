/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : The IProgressMonitor Class acts as the Interface for the monitoring classes.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.interfaces {
	/**
	 * @author Christian Sobolewski
	 */
	public interface IProgressMonitor {

		function get loadedBytes() : uint;

		function set loadedBytes(loadedBytes : uint) : void;
		
		function get totalBytes() : uint;
		
		function set totalBytes(totalBytes : uint) : void;
		
		function garbageCollection() : void;
	}
}
