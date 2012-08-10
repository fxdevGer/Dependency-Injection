/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : The IFileLoader Class is implemented by each Loader Type. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.interfaces {
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.utils.ByteArray;

	/**
	 * @author Christian Sobolewski
	 */
	public interface IFileLoader extends ILoaderType {
		
		function addItem(path : String) : void;

		function addBinaryData(data : ByteArray) : void;

		function sequentialLoading() : void;

		function altogetherLoading() : void;

		function stopLoading() : void;

		function getBitmapData(ld : Loader) : BitmapData;

		function garbageCollection() : void;
		
		function set isQueue(isQueue : Boolean) : void;
		function get isQueue() : Boolean;
		
		function set dataFormat(dataFormat : String) : void;
		function get dataFormat() : String;
		
	}
}
