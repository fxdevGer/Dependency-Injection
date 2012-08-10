/**
 * Copyright 2008 Christian Sobolewski
 * 
 * usage : cs.framework
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * @file cs.framework.FrameworUnitTest.as
 * @author Christian Sobolewski
 */
package cs.unit {
	import cs.unit.test.Unit;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author Christian Sobolewski
	 */
	public class DependencyInjection extends Sprite {
		
		public function DependencyInjection() {
			addEventListener(Event.ADDED_TO_STAGE, handleAdded, false, 0, true);
		}

		private function handleAdded(event : Event) : void {
			removeEventListener(Event.ADDED_TO_STAGE, handleAdded, false);
			
			var unit : Unit = new Unit();
			addChild(unit);

		}
	}
}
