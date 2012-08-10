/**
 * Copyright 30.09.2010 Christian Sobolewski
 * 
 * usage : screens.types
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * screens.types.MP3Player
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.types {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.events.ProgressMonitorEvent;
	import com.cs.di.core.loader.core.monitor.ProgressMonitor;
	import com.cs.di.core.loader.core.types.SoundLoader;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;
	import com.cs.utils.references.GetMovieClip;
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.models.MP3Model;
	import flash.display.MovieClip;
	import flash.events.ErrorEvent;
	import flash.events.MouseEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.text.AntiAliasType;
	import flash.text.TextFieldAutoSize;
	import flash.utils.getQualifiedClassName;



	/**
	 * @author Christian Sobolewski
	 */
	public class MP3Screen extends Screen {

		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(MP3Screen));
		private var _model : MP3Model;
		private var _bgExportName : String;
		private var _bg : MovieClip;
		private var _fileId : Number = 0;
		private var _m : ProgressMonitor;
		private var _sd : SoundLoader;
		private var _snd : Sound;
		private var _sndChannel : SoundChannel;

		public function MP3Screen(bgExportName : String) {
			_bgExportName = bgExportName;
		}

		public override function activate() : void {
			log.info("activate");
			playSound();
		}
		
		public override function update() : void {
			log.info("update");
		}

		public override function dispose() : void {
			log.info("dispose");
			
			_m.removeEventListener(ProgressMonitorEvent.PROGRESS, handlePro);
			_m.garbageCollection();
			_m = null;
			if (_bg != null) removeChild(_bg); 
			_bg = null;
			
			_sd.stopLoading();
			_sd = null;
			
			_snd = null;
			
			if (_sndChannel != null) {
				_sndChannel.stop();
				_sndChannel = null;
			}
		}

		public function initSoundPlayer() : void {
//			log.trace("initSoundPlayer: " + mp3Model);		}

		public function onChangeLanguage() : void {
		}

		private function playSound() : void {
			if (_bg == null) {
				_bg = GetMovieClip(_bgExportName); 
				
				_bg.bg.width = 1024;
				_bg.bg.height = 768;
				
				_bg.preloader.x = 1024 / 2 - _bg.preloader.width / 2;
				_bg.preloader.y = 768 / 2 - _bg.preloader.height / 2;
				_bg.preloader.bar.width = 0;
				
				_bg.preloader.total.styleSheet = Context.styleSheet;
				_bg.preloader.loaded.styleSheet = Context.styleSheet;
				
				_bg.tfID3.styleSheet = Context.styleSheet;
				_bg.tfID3.x = 20;
				_bg.tfID3.y = 20;
				
				addChild(_bg);
			}
			
			_m = new ProgressMonitor();
			_m.addEventListener(ProgressMonitorEvent.PROGRESS, handlePro);
			
			_sd = new SoundLoader(_m);
			if (_fileId > 2) _fileId = 0;
			var p : String = mp3Model.getPathById(_fileId);
			_fileId++;
			_sd.addItem(p);
			_sd.dispatcher = this;
			_sd.addEventListener(FileLoaderEvent.COMPLETE, handleComplete);
			_sd.sequentialLoading();
		}

		private function handleClose(event : MouseEvent) : void {
		}

		private function handlePro(event : ProgressMonitorEvent) : void {
			var m : ProgressMonitor = ProgressMonitor(event.currentTarget);
			if (m.totalBytes > 0) {
				_bg.preloader.bar.width = (m.loadedBytes * 100 / m.totalBytes) * 300 / 100;
			
				_bg.preloader.total.htmlText = "<.small>" + "total Bytes: " + m.totalBytes + "</.small>";
				_bg.preloader.total.antiAliasType = AntiAliasType.ADVANCED;
				_bg.preloader.total.autoSize = TextFieldAutoSize.LEFT;
			
				_bg.preloader.loaded.htmlText = "<.small>" + "loaded Bytes: " + m.loadedBytes + "</.small>";
				_bg.preloader.loaded.antiAliasType = AntiAliasType.ADVANCED;
				_bg.preloader.loaded.autoSize = TextFieldAutoSize.LEFT;
			
				_bg.preloader.loaded.x = (_bg.preloader.bar.x + _bg.preloader.bar.width) - (_bg.preloader.loaded.width / 2);				_bg.preloader.line.x = _bg.preloader.loaded.x + (_bg.preloader.loaded.width / 2);
			}
		}

		private function handleError(event : ErrorEvent) : void {
			log.fatal("Error has occured " + event.text);
		}

		private function handleComplete(event : FileLoaderEvent) : void {
			//			if (_bg.preloader != null) _bg.removeChild(_bg.preloader);

			_snd = Sound(event.data.sound);
			var idInfo : String = "ID3 Tag Information:<br>";
			
			for (var s : String in _snd.id3) {
				idInfo = idInfo.concat(s + " : " + _snd.id3[s] + "<br>");
			}
			
			
			if (idInfo == "ID3 Tag Information:<br>") idInfo = "No ID3 data found";
			
			_bg.tfID3.multiline = true;
			_bg.tfID3.htmlText = "<.mp3Info>" + idInfo + "</.mp3Info>";
			_bg.tfID3.antiAliasType = AntiAliasType.ADVANCED;
			_bg.tfID3.autoSize = TextFieldAutoSize.LEFT;
			_bg.tfID3.y = 100;
			
			_sndChannel = _snd.play();
		}

		public function get mp3Model() : MP3Model {
			return _model;
		}

		public function set mp3Model(model : MP3Model) : void {
			_model = model;
		}
	}
}
