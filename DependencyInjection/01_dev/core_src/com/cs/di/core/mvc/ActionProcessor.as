/**
 * Copyright 20.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The ActionProcessor Class used to execute Actions.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc {
	import com.cs.di.core.mvc.impl.Action;
	import com.cs.utils.iterator.ForwardIterator;

	/**
	 * @author Christian Sobolewski
	 */
	public class ActionProcessor {
		protected var _event : ApplicationEvent;
		protected var _actions : Array;
		protected var _interceptors : Array;
		
		public function ActionProcessor(event : ApplicationEvent, actions : Array, interceptors : Array) {
			_event = event;
			_actions = actions;
			_interceptors = interceptors;
		}

		
		/**
		 * 	the event that this processor handles.
		 */
		 
		public function get event() : ApplicationEvent {
			return _event;
		}

		
		/**
		 * 	executes all <code>Action</code>
		 */
		 
		public function proceed() : void {
			if (_interceptors.length > 0) {
				var ic : ActionInterceptor = _interceptors.shift() as ActionInterceptor;
				ic.intercept(this);
			} else {
				
				var fI : ForwardIterator = new ForwardIterator(_actions);
				
				while(fI.hasNext) {
					Action(fI.next).execute(event);
				}
			}
		}	
	}
}
