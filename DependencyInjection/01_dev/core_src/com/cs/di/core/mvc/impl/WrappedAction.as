/**
 * Copyright 17.05.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The WrappedAction class wraps an Action.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc.impl {
	import com.cs.di.core.mvc.ApplicationEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public class WrappedAction implements ActionRegistration {
		
		private var _action : Action;
		
		public function WrappedAction(action : Action) {
			_action = action;
		}

		/**
		 * 	executes <code>ApplicationEvent</code>
		 */
		public function execute(event : ApplicationEvent) : void {
			_action.execute(event);
		}

		/**
		 * 	checks if <code>ActionRegistration</code> equals 
		 */
		public function equals(other : ActionRegistration) : Boolean {
			if (!(other is WrappedAction)) {
				return false;
			}
			var otherAction : WrappedAction = WrappedAction(other);
			return (_action == otherAction._action);
		}
	}
}
