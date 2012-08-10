/**
 * Copyright 17.03.2010 Christian Sobolewski
 * 
 * usage : screens.models
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.models.GalleryModel
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.models {
	import flash.display.BitmapData;

	/**
	 * @author Christian Sobolewski
	 */
	public class SuspendModel {
		
		private var _images : Vector.<BitmapData>;
		public function SuspendModel() {
			_images = new Vector.<BitmapData>();
		}

		public function get images() : Vector.<BitmapData> {
			return _images;
		}

		public function set addImage(image : BitmapData) : void {
			_images.push(image);
		}
		
		public function dispose() : void {
			for each (var bitmapData : BitmapData in _images) {
				bitmapData.dispose();
			}
			_images = new Vector.<BitmapData>();
		}
	}
}
