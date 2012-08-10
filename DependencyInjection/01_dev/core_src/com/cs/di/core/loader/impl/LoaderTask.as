/**
 * Copyright 15.03.2010 Christian Sobolewski
 * 
 * Usage :	_ld = new LoaderTask();
 * 			_ld.path = "xy.*";
 * 			_ld.type = "*";	
 * 			_ld.objRef = "objRef";
 * 			_ld.method = "methodToCall";
 * 			_ld.callback = function;
 * 
 * Parameters :
 *
 * Description : The LoaderTask Class acts as a Model for loaderTask nodes.
 * 				 It stores some major variables and its only used internaly by the Framework.
 * 				 Path stores file Path. Types stores the file type. ObjRef stores the object reference. 
 * 				 Method the method to call if file is loaded. Callback called after loading.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.impl {
	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderTask {
		
		protected var _path : String;
		protected var _type : String;
		protected var _objRef : String;
		protected var _method : String;
		protected var _callBack : Function;
		protected var _content : *;
		/**
		 * 	getter for the file path
		 */

		public function get path() : String {
			return _path;
		}

		/**
		 * 	setter for the file path
		 */

		public function set path(path : String) : void {
			_path = path;
		}

		/**
		 * 	getter for the file type
		 */

		public function get type() : String {
			return _type;
		}

		/**
		 * 	setter for the file type
		 */

		public function set type(type : String) : void {
			_type = type;
		}
		
		/**
		 * 	getter if file has a specified Reference
		 */
		
		public function get objRef() : String {
			return _objRef;
		}
		
		/**
		 * 	setter if file has a specified Reference
		 */
		
		public function set objRef(refObj : String) : void {
			_objRef = refObj;
		}
		
		/**
		 * 	getter to call if objRef is defined
		 */
		
		public function get method() : String {
			return _method;
		}
		
		/**
		 * 	setter to call if objRef is defined
		 */
		
		public function set method(method : String) : void {
			_method = method;
		}
		
		/**
		 * 	getter to call if callBack is defined
		 */
		
		public function get callBack() : Function {
			return _callBack;
		}
		
		/**
		 * 	getter to call if callBack is defined
		 */
		
		public function set callBack(callBack : Function) : void {
			_callBack = callBack;
		}
		
		/**
		 * 	getter for content that has been loaded for this task. Needed for sorting later
		 */
		
		public function get content() : * {
			return _content;
		}
		
		/**
		 * 	setter for content that has been loaded for this task
		 */
		
		public function set content(content : *) : void {
			_content = content;
		}
		
		public function garbageCollection() : void {
			_path = null;
			_type = null;
			_objRef = null;
			_method = null;
			_callBack = null;
			_content = null;
		}
		
	}
}
