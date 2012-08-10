/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleConstructorArgs
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

	import flash.geom.Vector3D;
	import flash.utils.getQualifiedClassName;
	/**
	 * @author Christian Sobolewski
	 */
	public class ExampleConstructorArgs {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleConstructorArgs));
		
//		public function ExampleConstructorArgs(bool : Boolean, nb : Number, i : int, ui : uint, s : String, arr : Array, d : Date, ref : *) {
//			log.info("constructor - args Boolean : " + bool);
//			log.info("constructor - args Number : " + nb);
//			log.info("constructor - args Int : " + i);
//			log.info("constructor - args uint : " + ui);
//			log.info("constructor - args String : " + s);
//			log.info("constructor - args Array : " + arr + " | " + arr.length);
//			log.info("constructor - args Date : " + d);
//			log.info("constructor - args id-ref : " + ref);
//			log.trace("Injection via Constructor - Args finished.");
//		}
		
		public function ExampleConstructorArgs(bool : Boolean, nb : Number, i : int, ui : uint, s : String, arr : Array, d : Date, vec : Vector3D) {
			log.info("constructor - args Boolean : " + bool);
			log.info("constructor - args Number : " + nb);
			log.info("constructor - args Int : " + i);
			log.info("constructor - args uint : " + ui);
			log.info("constructor - args String : " + s);
			log.info("constructor - args Array : " + arr + " | " + arr.length);
			log.info("constructor - args Date : " + d);
			log.info("constructor - args vec : " + vec);
			log.trace("Injection via Constructor - Args finished.");
		}
	}
}
