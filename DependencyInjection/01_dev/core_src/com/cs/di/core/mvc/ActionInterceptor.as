/**
 * Copyright 20.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The ActionInterceptor Class used to send before an ApplicationEvent.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc {

	/**
	 * @author Christian Sobolewski
	 */
	public interface ActionInterceptor {
		
		/**
		 * 	used if an Interceptor should be called before the ApplicationEvent occurs.
		 */
		
		function intercept(processor:ActionProcessor) : void;
		
	}
}
