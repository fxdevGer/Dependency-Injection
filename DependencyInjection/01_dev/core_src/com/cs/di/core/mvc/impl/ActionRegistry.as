/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The ActionRegistry
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc.impl {
	import com.cs.utils.ArrayUtil;
	/**
	 * @author Christian Sobolewski
	 */
	public class ActionRegistry extends Registry {
		public function ActionRegistry() {
			super();
		}

		/**
		 * 	removes an <code>ActionRegistration</code> inside given Array
		 */
		 
		protected override function removeItem(items : Array, item : Object) : void {
			var remove : ActionRegistration = findRegistration(items, item as ActionRegistration);
			if (remove != null) {
				ArrayUtil.remove(items, remove);
			}
		}
		
		/**
		 * 	finds an <code>ActionRegistration</code> inside given Array
		 */
		
		private function findRegistration(items : Array, registration : ActionRegistration) : ActionRegistration {
			for each (var action:ActionRegistration in items) {
				if (registration.equals(action)) {
					return action;
				}
			}
			return null;
		}
	}
}
