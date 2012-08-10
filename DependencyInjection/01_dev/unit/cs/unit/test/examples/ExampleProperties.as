/**
 * Copyright 26.07.2011 Christian Sobolewski
 * 
 * Usage : ExampleProperties
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
	public class ExampleProperties {
		
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleProperties));
		
		private var _id : String;
		private var _idRef : ExampleSimpleReferenceById;
		private var _valueRef : String;
		private var _scale : String = "10";
		private var _position : Vector3D;
		
		public function ExampleProperties() {}
		
		public function set booleanTest(b : Boolean) : void {
			log.debug("b as boolean? " + b + " | " + typeof b);
		}
		
		public function get id() : String {
			return _id;
		}
		
		public function set id(id : String) : void {
			log.info('id: ' + (id));
			_id = id;
		}

		public function get idRef() : ExampleSimpleReferenceById {
			return _idRef;
		}

		public function set idRef(idRef : ExampleSimpleReferenceById) : void {
			log.info('idRef: ' + (idRef));
			_idRef = idRef;
		}

		public function get valueRef() : String {
			return _valueRef;
		}

		public function set valueRef(valueRef : String) : void {
			log.info('valueRef: ' + (valueRef));
			_valueRef = valueRef;
		}
		
		public function set valueRefValue(value : String) : void {
			log.info('valueRef: ' + value);
			_scale = value;
		}
		
		public function set position(pos : Vector3D) : void {
			log.info('pos: ' + pos);
			_position = pos;
		}
		
		public function set specularMap(map : String) : void {
			log.info('map: ' + map); // Should be BitmapData :D
		}
		
	}
}
