/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleObject
 * 
 * Parameters :
 *
 * Description :
 *
 * Version : 
 * 
 * History :
 * 
 */
package cs.unit.test.examples {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author Christian Sobolewski
	 */
	public class ExampleObject {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleObject));
		
		public function ExampleObject() {}
		
		public function initExampleObject():void {
			log.info("initExampleObject called");
		}
		
		public function set simpleReferenceById(ref : ExampleSimpleReferenceById) : void {
			log.info("simpleReferenceById: " + ref);
		}

		
	}
}
