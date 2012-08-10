/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleSimpleEvent
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
	import com.cs.di.core.mvc.ApplicationEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public class ExampleMVCEvent extends ApplicationEvent {
		
		public static const SIMPLE_EVENT : String = "SIMPLE_EVENT";
		
		public function ExampleMVCEvent(name : String) {
			super(name);
		}
	}
}
