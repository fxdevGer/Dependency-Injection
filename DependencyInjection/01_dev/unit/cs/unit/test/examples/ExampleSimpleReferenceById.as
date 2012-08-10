/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleSimpleReferenceById
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
	public class ExampleSimpleReferenceById {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleSimpleReferenceById));
		
		private var _vector : Vector.<String>;
		
		public function ExampleSimpleReferenceById() {
			log.error("INJECTED");
			_vector = new Vector.<String>();
			_vector.push("Hallo Vector Operator Test 0");
			_vector.push("Hallo Vector Operator Test 1");
			_vector.push("Hallo Vector Operator Test 2");
			_vector.push("Hallo Vector Operator Test 3");
			_vector.push("Hallo Vector Operator Test 4");
			_vector.push("Hallo Vector Operator Test 5");
			_vector.push("Hallo Vector Operator Test 6");
			_vector.push("Hallo Vector Operator Test 7");
			_vector.push("Hallo Vector Operator Test 8");
			_vector.push("Hallo Vector Operator Test 9");
			_vector.push("Hallo Vector Operator Test 10");
		}

		public function get simpleValue() : String {
			return "simpleValue from " + getQualifiedClassName(ExampleSimpleReferenceById);
		}

		public function get object() : Object {
			return {a:100, b:200};
		}

		public function get array() : Array {
			return ["1", "2", "3"];
		}
		
		public function get vector() : Vector3D {
			return new Vector3D(100, 100, 100);
		}
		
		public function set scale(scale : Number) : void {
			log.info("scale: "  + scale);
		}
		
		public function scaleMethod(scale : Number) : void {
			log.info("scaleMethod: "  + scale);
		}
		
		public function get materials(): Vector.<String> {
			log.warn('_vector: ' + (_vector));
			return _vector;
		}
	}
}
