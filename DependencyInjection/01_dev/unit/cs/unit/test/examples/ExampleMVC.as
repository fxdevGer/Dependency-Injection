/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleMVC
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
	import com.cs.di.core.mvc.FrontController;

	import flash.utils.getQualifiedClassName;
	/**
	 * @author Christian Sobolewski
	 */
	public class ExampleMVC {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleMVC));
		
		public function ExampleMVC() {}
		
		
		public function start():void {
			FrontController.root().dispatchEvent(new ExampleMVCEvent(ExampleMVCEvent.SIMPLE_EVENT));
		}
		
		public function onSimpleEvent(event : ExampleMVCEvent) : void {
			log.info("onSimpleEvent called event = " + event);
		}
		
	}
}
