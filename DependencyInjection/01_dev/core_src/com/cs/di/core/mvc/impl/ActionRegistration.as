/**
 * Copyright 15.04.2010 Christian Sobolewski
 * 
 * Usage : 
 * 
 * Parameters :
 *
 * Description : The ActionRegistration Interface for all MVC ActionRegistration
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.mvc.impl {

	/**
	 * @author Christian Sobolewski
	 */
	public interface ActionRegistration extends Action {
		
		/**
		 *  returns if equal or not
		 */
		
		function equals(other : ActionRegistration) : Boolean;
	}
}
