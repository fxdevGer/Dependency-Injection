/**
 * Copyright 17.03.2010 Christian Sobolewski
 * 
 * usage : cs.unit.test.examples.ExampleLoaderGroup
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 *	cs.unit.test.examples
 * @author Christian Sobolewski
 */
package cs.unit.test.examples {
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.display.BitmapData;
	import flash.display.Shader;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class ExampleLoaderGroup {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(ExampleLoaderGroup));
		
		private var _images : Vector.<BitmapData>;
		private var _shaders : Array;

		public function ExampleLoaderGroup() {
			_images = new Vector.<BitmapData>();
			_shaders = [];
		}
		
		public function set addAWDModel(model : ByteArray):void {
			log.trace("addAWDModel? " + model.bytesAvailable + " | " + model.length);
		}
		
		public function set add3dsModel(model : ByteArray):void {
			log.trace("add3dsModel? " + model.bytesAvailable + " | " + model.length);
		}
		
		public function set addObjModel(model : String):void {
//			log.trace("addObjModel? " + model);
		}
		
		public function get images() : Vector.<BitmapData> {
			return _images;
		}

		public function set addImage(image : BitmapData) : void {
			log.info('addImage: ' + (image));
			_images.push(image);
		}

		public function get shader() : Array {
			return _shaders;
		}

		public function set addShader(s : Shader) : void {
			log.info('addShader: ' + (s));
			_shaders.push(s);
		}

		public function dispose() : void {
			for each (var bitData : BitmapData in _images) {
				bitData.dispose();
			}
			_images = null;
			_shaders = null;

			delete this;
		}
	}
}
