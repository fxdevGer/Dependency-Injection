/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The ApplicationEvent Class is the Base Class for all MVC Events.
 * 				 Each Event must extend ApplicationEvent
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc {
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ApplicationEvent {

		private var _name : String;
		private var _controller : FrontController;

		
		public function ApplicationEvent(name : String) {
			_name = name;
		}
		
		/**
		 * 	sets the <code>FrontController</code> instance
		 */
		
		internal function setFrontController(controller : FrontController) : void {
			_controller = controller;
		}
		
		/**
		 * 	returns the <code>FrontController</code>
		 */
		
		public function get controller() : FrontController {
			return _controller;
		}
		
		/**
		 * 	returns the name
		 */
		
		public function get name() : String {
			return _name;
		}
		
		/**
		 * 	returns the getQualifiedClassName + name
		 */

		public function toString() : String {
			return getQualifiedClassName(this) + "." + name;
		}
	}
}
