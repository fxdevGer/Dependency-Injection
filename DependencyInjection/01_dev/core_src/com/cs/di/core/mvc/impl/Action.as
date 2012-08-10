/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The Action Interface for all MVC Actions
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
	public interface Action {
		
		/**
		 * 	executes the given <code>ApplicationEvent</code>
		 */
		
		function execute(event : ApplicationEvent) : void;
	}
}
