/**
 * Copyright 17.03.2010 Christian Sobolewski
 * 
 * Usage : 	var m : ContextModel = new ContextModel();
 *			m.id = id;
 *			m.classId = classId;
 *			m.instance = instance as *;
 *			m.initMethod = initMethod;
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
package com.cs.di.core.context.impl {
	import com.cs.di.core.xml.processing.IProcessor;
	/**
	 * @author Christian Sobolewski
	 */
	public class ContextModel {
		
		private var _id : String;
		private var _instance : *;
		private var _initMethod : String;
		private var _isInitialized : Boolean;
		private var _expire : Boolean;
		private var _processors : Vector.<IProcessor>;
		
		public function ContextModel() {
			isInitialized = false;
			expire = false;
			processors = new Vector.<IProcessor>();
		}
		
		public function dispose():void {
			_id = null;
			_instance = null;
			_initMethod = null;
			_isInitialized = undefined;
			_expire = undefined;
			_processors = null;
			
			delete this;
		}
		
		/**
		 * 	getter for expire
		 */
		
		public function set expire(expire : Boolean):void {
			_expire = expire;
		}
		
		/**
		 * 	setter expire
		 */
		
		public function get expire():Boolean {
			return _expire;
		}
		
		/**
		 * 	getter for the method to call if Context.isReady()
		 */
		
		public function get initMethod() : String {
			return _initMethod;
		}
		
		/**
		 * 	setter for the method to call if Context.isReady()
		 */
		
		public function set initMethod(initMethod : String) : void {
			_initMethod = initMethod;
		}
		
		/**
		 * 	getter for the id or name of this Object
		 */
		
		public function get id() : String {
			return _id;
		}
		
		/**
		 * 	setter for the id or name of this Object
		 */
		
		public function set id(id : String) : void {
			_id = id;
		}
		
		public function get instance() : * {
			return _instance;
		}
		
		/**
		 * 	setter for the instance created from classId
		 */
		
		public function set instance(instance : *) : void {
			_instance = instance;
		}
		
		/**
		 * 	getter thas defines if the instance object has been initialized
		 */
		
		public function get isInitialized() : Boolean {
			return _isInitialized;
		}
		
		/**
		 * 	setter thas defines if the instance object has been initialized
		 */
		
		public function set isInitialized(isInitialized : Boolean) : void {
			_isInitialized = isInitialized;
		}
		
		/**
		 * 	getter for processors, if attribute autoWire is false
		 */
		
		public function get processors() : Vector.<IProcessor> {
			return _processors;
		}
		
		/**
		 * 	setter for processors, if attribute autoWire is false
		 */
		
		public function set processors(processors : Vector.<IProcessor>) : void {
			_processors = processors;
		}
	}
}
