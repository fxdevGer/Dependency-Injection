/**
 * Copyright 07.09.2010 Christian Sobolewski
 * 
 * usage : di.view.ui.video
 * 
 * Parameters:
 * 
 * Version:
 * 
 * History:
 * 
 * di.view.ui.video.VideoPlayer
 * @author Christian Sobolewski
 */
package cs.unit.test.screens.types {
	import cs.unit.test.screens.Screen;
	import cs.unit.test.screens.models.VideoModel;

	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.events.NetStatusEvent;
	import flash.events.SecurityErrorEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class VideoScreen extends Screen {

		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(VideoScreen));
		
		private var _m : VideoModel;
		private var stream : NetStream;
		private var con : NetConnection;
		private var _video : Video;
		private var _vId : Number = 0;

		public function VideoScreen() {
			log.info("injected");
		}

		public override function activate() : void {
			log.info("activate");
			_vId = 0;
			playVid();
		}
		
		public override function update() : void {
			log.info("update");
		}

		public override function dispose() : void {
			log.info("dispose");
			stream.close();
			_video.clear();
			_vId = 0;
		}

		public function onChangeLanguage() : void {
		}

		public function initVideoPlayer() : void {
			_video = new Video();
			_video.width = 640;
			_video.height = 480;
			
			_video.x = 1024 / 2 - 640 / 2;
			_video.y = 768 / 2 - 480 / 2;
			
			addChild(_video);
			
			con = new NetConnection();
			con.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			con.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			con.connect(null);
		}

		private function connectStream() : void {
			stream = new NetStream(con);
			stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
			stream.client = new CustomClient();
			_video.attachNetStream(stream);
		}

		private function playVid() : void {
			if (_vId == 0) {
				stream.play(videoModel.getPathById(0));
				_vId = 1;
//				FrontController.root().dispatchEvent(new MainEvent(MainEvent.STOP_ACTIVITY, ""));
			} else {
				stream.close();
				_video.clear();
				_vId = 0;
			}
		}

		private function netStatusHandler(event : NetStatusEvent) : void {
			switch (event.info.code) {
				case "NetConnection.Connect.Success":
					connectStream();
					break;
				case "NetStream.Play.StreamNotFound":
					log.fatal("Stream not found: " + videoModel.getPathById(0));
					break;
			}
		}

		private function securityErrorHandler(event : SecurityErrorEvent) : void {
			log.info("securityErrorHandler: " + event);
		}

		public function set videoModel(m : VideoModel) : void {
			_m = m;
		}

		public function get videoModel() : VideoModel {
			return _m;
		}
	}
}


class CustomClient {

//	private static const log : Logger = LogContext.getLogger(getQualifiedClassName(CustomClient));

	public function onMetaData(info : Object) : void {
//		log.info("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	}

	public function onCuePoint(info : Object) : void {
//		log.info("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	}
}
