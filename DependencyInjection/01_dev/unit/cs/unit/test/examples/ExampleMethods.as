/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleMethods
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
	public class ExampleMethods {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleMethods));
		private var _idRef : ExampleSimpleReferenceById;
		
		public function ExampleMethods() {}
		
		public function simpleMethod():void {
			log.info("simpleMethod called");
		}
		
		public function simpleMethodWithArguments(args : Number, args2 : Number) : void {
			log.info("simpleMethodWithArguments args= " + args + " | " + args2);
		}
				
		public function get returnsimpleMethodForIdRef():ExampleSimpleReferenceById {
			return _idRef;
		}
		
		public function simpleMethodForIdRef(idref : ExampleSimpleReferenceById) : void {
			_idRef = idref;
			log.info("simpleMethodForIdRef called idref = " + idref);
		}
		
		public function simpleMethodForValueRef(valueref : String) : void {
			log.info("simpleMethodForValueRef called valueref = " + valueref);
		}
		
		public function multiMethodForValueRef(s : String, o : Object, a : Array, v : Vector3D):void {
			log.info("multiMethodForValueRef called string = " + s);
			log.info("multiMethodForValueRef called object = " + o);
			log.info("multiMethodForValueRef called array = " + a);
			log.info("multiMethodForValueRef called vector = " + v);
		}
		
		public function testForArguments(id : *, arg0 : int, arg1 : int) : void {
			log.info("testForArguments called id: " + id);
			log.info("testForArguments called arg0: " + arg0);
			log.info("testForArguments called arg1: " + arg1);
		}
		
		public function testForArguments2(id : *, arg0 : int, arg1 : int) : void {
			log.info("testForArguments2 called id: " + id);
			log.info("testForArguments2 called arg0: " + arg0);
			log.info("testForArguments2 called arg1: " + arg1);
		}
		
	}
}
