/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleMediaTask
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
	public class ExampleMediaTask {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleMediaTask));
		
		private var _paths : Vector.<String>;
		
		public function ExampleMediaTask() {
			_paths = new Vector.<String>();
		}
		
		public function set addPath(p : String) : void {
			log.info("addPath : " + p);
			_paths.push(p);
		}
		
	}
}
