/**
 * Copyright 30.09.2010 Christian Sobolewski
 * 
 * usage : screens.models
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.models.MP3Model
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.models {
	import flash.media.Sound;

	/**
	 * @author Christian Sobolewski
	 */
	public class MP3Model {
		
		private var _snd : Array = [];		private var _sndPath : Array = [];

		public function set addMP3Path(path : String) : void {
			_sndPath.push(path);
		}

		public function getPathById(id : Number) : String {
			return _sndPath[id];
		}
		
		public function set addMusic(snd : Sound) : void {
			_snd.push(snd);
		}

		public function getMP3ById(id : Number) : Sound {
			return _snd[id];
		}
		
	}
}
