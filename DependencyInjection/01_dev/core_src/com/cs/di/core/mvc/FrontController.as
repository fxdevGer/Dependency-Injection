/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * usage : com.cs.di.core.mvc
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * com.cs.di.core.mvc.FrontController
 * @author Christian Sobolewski
 */
package com.cs.di.core.mvc {
	import com.cs.di.core.mvc.impl.Action;
	import com.cs.di.core.mvc.impl.ActionRegistry;
	import com.cs.di.core.mvc.impl.DelegateAction;
	import com.cs.di.core.mvc.impl.Registry;
	import com.cs.di.core.mvc.impl.WrappedAction;

	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class FrontController {
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(FrontController));
		
		protected static var _root : FrontController;
		protected var _actionsByType : ActionRegistry;
		protected var _actionsByName : ActionRegistry;
		protected var _actionsByTypeAndName : ActionRegistry;
		protected var _globalActions : ActionRegistry;
		protected var _interceptorsByType : Registry;
		protected var _interceptorsByName : Registry;
		protected var _interceptorsByTypeAndName : Registry;
		protected var _globalInterceptors : Registry;
		protected var _eventSources : Array;

		public function FrontController(useAsRoot : Boolean = false) {
			if (useAsRoot) {
				_root = this;
			}
			init();
		}

		private function init() : void {
			_actionsByType = new ActionRegistry();
			_actionsByName = new ActionRegistry();
			_actionsByTypeAndName = new ActionRegistry();
			_globalActions = new ActionRegistry();
		
			_interceptorsByType = new Registry();
			_interceptorsByName = new Registry();
			_interceptorsByTypeAndName = new Registry();
			
			_globalInterceptors = new Registry();		
		
			_eventSources = new Array();
		}

		/**
		 * Dispatches the specified <code>ApplicationEvent</code>
		 */
		 
		public function dispatchEvent(event : ApplicationEvent) : void {
			var name : String = event.name;
			var type : String = getQualifiedClassName(event);
		
			var actions : Array = _globalActions.getItems("*")
			.concat(_actionsByType.getItems(type))
			.concat(_actionsByName.getItems(name))
			.concat(_actionsByTypeAndName.getItems(type + "#" + name));
			
			var interceptors : Array = _globalInterceptors.getItems("*")
			.concat(_interceptorsByType.getItems(type))
			.concat(_interceptorsByName.getItems(name))
			.concat(_interceptorsByTypeAndName.getItems(type + "#" + name));
			
			var processor : ActionProcessor = new ActionProcessor(event, actions, interceptors);
//			log.warn('interceptors: ' + (interceptors));
//			log.warn('actions: ' + (actions));
//			log.warn('event: ' + (event));
			processor.proceed();
		}

		/**
		 * Registers the specified 
		 */
		public function registerEventSource(source : EventSource) : void {
			source.activate(this);
			_eventSources.push(source);
		}

		/**
		 * Registers the specified <code>Action</code> with this controller.
		 */
		public function registerAction(action : Action, eventClass : Class = null, eventName : String = null) : void {
			registerActionInstance(new WrappedAction(action), eventClass, eventName);	
		}

		public function registerActionDelegate(action : Function, eventClass : Class = null, eventName : String = null) : void {
			registerActionInstance(new DelegateAction(action), eventClass, eventName);	
		}

		private function registerActionInstance(action : Action, eventClass : Class, eventName : String) : void {
			getActionRegistry(eventClass, eventName).registerItem(getKey(eventClass, eventName), action);
		}

		public function registerInterceptor(ic : ActionInterceptor, eventClass : Class = null, eventName : String = null) : void {
			getInterceptorRegistry(eventClass, eventName).registerItem(getKey(eventClass, eventName), ic);
		}

		public function unregisterAction(action : Action, eventClass : Class = null, eventName : String = null) : void {
			unregisterActionInstance(new WrappedAction(action), eventClass, eventName);
		}

		/**
		 * Unregisters the specified function with this FrontController.
		 */	
		public function unregisterActionDelegate(action : Function, eventClass : Class = null, eventName : String = null) : void {
			unregisterActionInstance(new DelegateAction(action), eventClass, eventName);		
		}

		private function unregisterActionInstance(action : Action, eventClass : Class, eventName : String) : void {
			getActionRegistry(eventClass, eventName).unregisterItem(getKey(eventClass, eventName), action);
		}

		/**
		 * Unregisters the specified <code>ActionInterceptor</code> with this FrontController.
		 */	
		public function unregisterInterceptor(ic : ActionInterceptor, eventClass : Class = null, eventName : String = null) : void {
			getInterceptorRegistry(eventClass, eventName).unregisterItem(getKey(eventClass, eventName), ic);	
		}

		private function getKey(eventClass : Class, eventName : String) : String {
			if (eventClass != null && eventName != null) {
				return getQualifiedClassName(eventClass) + "#" + eventName;
			} else if (eventClass != null) {
				return getQualifiedClassName(eventClass);
			} else if (eventName != null) {
				return eventName;
			} else {
				return "*";
			}				
		}

		private function getActionRegistry(eventClass : Class, eventName : String) : Registry {
			if (eventClass != null && eventName != null) {
				return _actionsByTypeAndName;
			} else if (eventClass != null) {
				return _actionsByType;
			} else if (eventName != null) {
				return _actionsByName;
			} else {
				return _globalActions;
			}	
		}	

		private function getInterceptorRegistry(eventClass : Class, eventName : String) : Registry {
			if (eventClass != null && eventName != null) {
				return _interceptorsByTypeAndName;
			} else if (eventClass != null) {
				return _interceptorsByType;
			} else if (eventName != null) {
				return _interceptorsByName;
			} else {
				return _globalInterceptors;
			}	
		}	

		public function destroy() : void {
			for each (var source:EventSource in _eventSources) {
				source.deactivate();
			}
			init();
			if (_root == this) {
				_root = null;
			}
		}

		/**
		 * 	returns the FrontController instance
		 */

		public static function root() : FrontController {
			if (_root == null) {
				_root = new FrontController(true);
			}
			return _root;
		}
	}
}
