/**
 * Copyright 21.07.2011 Christian Sobolewski
 * 
 * Usage : com.cs.di.core.xml.processing.IProcessor
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
	import com.cs.di.core.context.impl.IContextFactory;
	/**
	 * @author Christian Sobolewski
	 */
	public interface IProcessor {
		
		function proceedList():void;
		function proceedNode():void;
		function dispose():void;
		
		function set childsInjection(childsInjection : Boolean) : void;
		function get childsInjection() : Boolean;
		
		function set children(children : Array) : void;
		function get children() : Array;
		
		function set attributes(attributes : Array) : void;
		function get attributes() : Array;
		
		function set xmlNode(node : XML) : void;
		function get xmlNode() : XML;
		
		function set xmlList(node : XMLList) : void;
		function get xmlList():XMLList;
		
		function set factory(factory : IContextFactory) : void;
		function get factory():IContextFactory;
		
		function set processedData(data : *) : void;
		function get processedData() : *;
		
		function set objectId(id : String) : void;
		function get objectId() : String;
		
	}
}
