/**
 * Copyright 07.09.2010 Christian Sobolewski
 * 
 * usage : screens.models
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.models.VideoModel
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.models {

	/**
	 * @author Christian Sobolewski
	 */
	
	public class VideoModel {
		
		private var _vid : Array = [];
		
		public function set addVideoPath(path : String) : void {
			_vid.push(path);
		}

		public function getPathById(id : Number) : String {
			return _vid[id];
		}
	}
}
