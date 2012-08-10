/**
 * Copyright 21.07.2011 Christian Sobolewski
 * 
 * Usage : AbstractProcessor
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
	public class AbstractProcessor implements IProcessor {
		protected var _xmlList : XMLList;
		protected var _xmlNode : XML;
		
		protected var _children : Array;
		protected var _attributes : Array;
		
		protected var _factory : IContextFactory;
		protected var _data : *;
		
		protected var _objectId : String;
		protected var _childsInjection : Boolean;
		
		
		public function AbstractProcessor() {}
		
		public function getAttributeFromNode(node : XML, key : String, charToSplit : String = "") : String {
			return (node.attribute(key) != "" || node.attribute(key) != "undefined") ? node.attribute(key).toString().split(charToSplit).join("") : "";
		}
		
		public function getAttributeFromList(node : XMLList, key : String, charToSplit : String = "") : String {
			return (node.attribute(key) != "" || node.attribute(key) != "undefined") ? node.attribute(key).toString().split(charToSplit).join("") : "";
		}

		public function proceedList() : void {
		}

		public function proceedNode() : void {
		}
		
		public function dispose():void {
			children = null;
			attributes = null;
			xmlNode = null;
			xmlList = null;
			factory = null;
			processedData = null;
			objectId = null;
			
			delete this;
		}
		
		public function set children(children : Array) : void{
			_children = children;
		}
		
		public function get children() : Array {
			return _children;
		}
		
		public function set attributes(attributes : Array) : void {
			_attributes = attributes;
		}
		
		public function get attributes() : Array {
			return _attributes;
		}

		public function set xmlNode(node : XML) : void {
			_xmlNode = node;
		}

		public function get xmlNode() : XML {
			return _xmlNode;
		}

		public function set xmlList(node : XMLList) : void {
			_xmlList = node;
		}

		public function get xmlList() : XMLList {
			return _xmlList;
		}

		public function set factory(factory : IContextFactory) : void {
			_factory = factory;
		}

		public function get factory() : IContextFactory {
			return _factory;
		}

		public function set processedData(data : *) : void {
			_data = data;
		}

		public function get processedData() : * {
			return _data;
		}

		public function set objectId(id : String) : void {
			_objectId = id;
		}

		public function get objectId() : String {
			return _objectId;
		}

		public function set childsInjection(childsInjection : Boolean) : void {
			_childsInjection = childsInjection;
		}

		public function get childsInjection() : Boolean {
			return _childsInjection;
		}
		
	}
}
