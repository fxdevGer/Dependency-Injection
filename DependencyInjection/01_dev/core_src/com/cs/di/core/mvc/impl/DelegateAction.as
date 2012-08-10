/**
 * Copyright 17.05.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The DelegateAction delegates an ApplicationEvent.
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
	public class DelegateAction implements ActionRegistration {
		
		private var _delegate : Function;

		/**
		 *	delegate the action delegate
		 */
		 
		public function DelegateAction(delegate : Function) {
			_delegate = delegate;
		}
		
		/**
		 * 	execute its <code>ApplicationEvent</code>
		 */
		 
		public function execute(event : ApplicationEvent) : void {
			_delegate(event);
		}

		/**
		 *	checks if <code>ActionRegistration</code> equals 
		 */
		 
		public function equals(other : ActionRegistration) : Boolean {
			if (!(other is DelegateAction)) {
				return false;
			}
			var otherAction : DelegateAction = DelegateAction(other);
			return (_delegate == otherAction._delegate);
		}
	}
}
