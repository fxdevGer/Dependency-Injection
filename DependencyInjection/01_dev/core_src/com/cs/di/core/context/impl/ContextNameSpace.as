/**
 * Copyright 04.10.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : Used to define xml namespaces. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.context.impl {

	/**
	 * @author Christian Sobolewski
	 */
	public class ContextNameSpace {

		public static const SCHEMA_NAMESPACE_URI : String = "http://www.w3.org/2001/XMLSchema-instance";		
		public static const DI_NAMESPACE_URI : String = "http://privatefunction.net/playground/di/xsd/core/";
		public static const MVC_NAMESPACE_URI : String = "http://privatefunction.net/playground/di/xsd/mvc/";
		public static const LOG_NAMESPACE_URI : String = "http://privatefunction.net/playground/di/xsd/log/";
		
		public static const DI_NAMESPACE : Namespace = new Namespace(DI_NAMESPACE_URI);
		public static const MVC_NAMESPACE : Namespace = new Namespace("mvc", MVC_NAMESPACE_URI);
		public static const LOG_NAMESPACE : Namespace = new Namespace("log", LOG_NAMESPACE_URI);
		
		
		public static const NAMESPACES : Array = [DI_NAMESPACE_URI, MVC_NAMESPACE_URI, LOG_NAMESPACE_URI];
		
	}
}
