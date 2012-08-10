/**
 * Copyright 29.09.2010 Christian Sobolewski
 * 
 * Usage :	var iLoad : LoadFiles = new LoadFiles();
 * 			iLoad.loaderGroup = <code>LoaderGroup</code>;
 *			iLoad.fileLoader = <code>FileLoader</code>;
 *			iLoad.createLoader();
 * 
 * Parameters :	
 *
 * Description : The LoadFiles Class creates all LoaderTasks in the given LoaderGroup.
 * 				 It handles each File for <code>FileLoaderEvent.COMPLETE</code> and each <code>IFileLoader</code> <code>FileLoaderEvent.QUEUE_COMPLETE</code> 
 * 				 After File Loading each Content will be set into <code>FileLoaderUtils</code>
 *
 * Version :	1.2 - Refactored from LoadAll to LoadFiles cause LoadSeq is no longer needed!
 * 					- added GarbageCollection Method
 * 
 * History : 	1.1 - Refactored all File Complete Event Handler to only one Method.
 * 					- Refactored all File Types Methods to only one Method.
 * 
 */
package com.cs.di.core.loader.impl {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.FileLoaderContext;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.core.interfaces.IFileLoader;
	import com.cs.di.core.loader.core.interfaces.ILoader;
	import com.cs.di.core.loader.core.types.BinaryLoader;
	import com.cs.di.core.loader.core.types.CSSLoader;
	import com.cs.di.core.loader.core.types.ImageLoader;
	import com.cs.di.core.loader.core.types.LoaderState;
	import com.cs.di.core.loader.core.types.SWFLoader;
	import com.cs.di.core.loader.core.types.ShaderLoader;
	import com.cs.di.core.loader.core.types.SoundLoader;
	import com.cs.di.core.loader.core.types.XMLLoader;

	import flash.events.ErrorEvent;
	import flash.utils.Dictionary;

	/**
	 * @author Christian Sobolewski
	 */
	public class LoadFiles implements ILoader {
		use namespace csinject;
		
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LoadFiles));
		
		private var _fileLoader : FileLoaderContext;
		private var _loader : Dictionary = new Dictionary(false);
		private var _lg : LoaderGroup;

		public function LoadFiles() {
//			log.debug("------------------------new instance------------------------------------");
		}

		/**
		 * 	createLoader
		 * 	creates all <code>LoaderTask</code>`s
		 */
		public function createLoader() : void {
			for each (var task : LoaderTask in loaderGroup.tasks) {
				createILoader(task);
			}
//			log.debug("-----------------------------------------------------------------------");
		}

		/**
		 * 	createILoader
		 * 	creates a <code>IFileLoader</code> switched by task.type
		 */
		private function createILoader(task : LoaderTask) : void {
			var iFileLoader : IFileLoader;
			var mapping : int = FileLoaderUtils.getFileTypeMapping(task.type);
//			log.debug("mapping for " + task.type + " | " + FileLoaderUtils.getFileTypeMapping(task.type) + " | " + FileLoaderUtils.getFileDataFormatMapping(task.type));
			switch(mapping) {
				case 1:
					if (_loader[XMLLoader] == undefined) {
						iFileLoader = new XMLLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[XMLLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[XMLLoader];
					}
					break;
				case 2:
					if (_loader[CSSLoader] == undefined) {
						iFileLoader = new CSSLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[CSSLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[CSSLoader];
					}
					break;
				case 3:
					if (_loader[SWFLoader] == undefined) {
						iFileLoader = new SWFLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[SWFLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[SWFLoader];
					}
					break;
				case 4:
					if (_loader[ImageLoader] == undefined) {
						iFileLoader = new ImageLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[ImageLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[ImageLoader];
					}
					break;
				case 5:
					if (_loader[ShaderLoader] == undefined) {
						iFileLoader = new ShaderLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[ShaderLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[ShaderLoader];
					}
					break;
				case 6:
					if (_loader[SoundLoader] == undefined) {
						iFileLoader = new SoundLoader(fileLoader.monitor);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[SoundLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[SoundLoader];
					}
					break;
				case 7:
					if (_loader[BinaryLoader] == undefined) {
						iFileLoader = new BinaryLoader(fileLoader.monitor);
						iFileLoader.dataFormat = FileLoaderUtils.getFileDataFormatMapping(task.type);
						iFileLoader.addEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
						iFileLoader.addEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
						iFileLoader.dispatcher = (Context.parser);
						iFileLoader.groupLoad = loaderGroup.load.toString();
						fileLoader.queueLoader.addFileLoader(iFileLoader);
						_loader[BinaryLoader] = iFileLoader;
					} else {
						iFileLoader = _loader[BinaryLoader];
					}
					break;
				default: // if FileLoaderUtils.getFileTypeMapping(task.type) returns 0 fileType is not supported
					Context.parser.dispatchEvent(new ErrorEvent(ErrorEvent.ERROR, false, false, "File " + task.path + " not supportet. Ask for File Support. Could not create IFileLoader!"));
					break;
			}

			if (iFileLoader != null) {
				// log.info('iFileLoader.groupLoad: ' + (iFileLoader.groupLoad) + " | loaderGroup: " + loaderGroup.id + " | fileToLoad: " + task.path);
				iFileLoader.addItem((loaderGroup.cache.toString() == LoaderGroupCache.CACHE_ON.toString()) ? task.path : task.path + "?cachebuster=" + Math.random());
			}
		}

		private function handleFileComplete(event : FileLoaderEvent) : void {
			var iFileLoader : IFileLoader = event.target as IFileLoader;
			var type : String, fileName : String = "";
			var mapping : int;

			switch(event.type) {
				case FileLoaderEvent.COMPLETE:
					type = FileLoaderUtils.getTypeFromString(event.data.fileName, loaderGroup.cache.toString());
					fileName = (loaderGroup.cache.toString() == LoaderGroupCache.CACHE_OFF.toString()) ? FileLoaderUtils.getFileFromString(event.data.fileName) : event.data.fileName;
					mapping = FileLoaderUtils.getFileTypeMapping(type);
//					log.debug("loaded filetype : " + type + " for fileName : " + fileName);
					switch(mapping) {
						case 1:
							loaderGroup.setLoadedContent(fileName, event.data.xml);
							break;
						case 2:
							// not the best way here. but works for now.
							// could be very buggy if more then one style sheets are used but why should more than one css file used?
							// FIXME : find a better way.
							if (Context.styleSheet == null) Context.styleSheet = event.data.styles;
							break;
						case 3:
							// FileType swf dont need a specific content Object
							break;
						case 4:
							loaderGroup.setLoadedContent(fileName, event.data.bitmapData.clone());
							break;
						case 5:
							loaderGroup.setLoadedContent(fileName, event.data.shader);
							break;
						case 6:
							loaderGroup.setLoadedContent(fileName, event.data.sound);
							break;
						case 7:
							if (type == FileLoaderUtils.OBJ || type == FileLoaderUtils.MD5MESH || type == FileLoaderUtils.MD5ANIM) {
								loaderGroup.setLoadedContent(fileName, event.data.bytesPlain);
							} else {
								loaderGroup.setLoadedContent(fileName, event.data.bytes);
							}
							break;
					}
					event.data.dispose();
					break;
				case FileLoaderEvent.QUEUE_COMPLETE:
//					log.debug("Loading Complete for LoaderGroup: " + loaderGroup.id);
					iFileLoader.removeEventListener(FileLoaderEvent.COMPLETE, handleFileComplete);
					iFileLoader.removeEventListener(FileLoaderEvent.QUEUE_COMPLETE, handleFileComplete);
					var garbage : Boolean = true;
					for each (var key : IFileLoader in  _loader) {
						if (key.state.toString() == LoaderState.PENDING.toString()) {
							garbage = false;
						} else {
							switch(true) {
								case key is XMLLoader:
									delete _loader[XMLLoader];
									break;
								case key is CSSLoader:
									delete _loader[CSSLoader];
									break;
								case key is SWFLoader:
									delete _loader[SWFLoader];
									break;
								case key is ImageLoader:
									delete _loader[ImageLoader];
									break;
								case key is ShaderLoader:
									delete _loader[ShaderLoader];
									break;
								case key is BinaryLoader:
									delete _loader[BinaryLoader];
									break;
							}
						}
					}
					if (garbage) {
						// loaderGroup.sortContent cause if e.g. *.jpg files were loaded with altogehter loaded content is not sorted
						FileLoaderUtils.setLoadedContent(loaderGroup.tasks);
						garbageCollection();
					}
					break;
			}

//			log.trace("-------------------------------------------------------------------------------------------------------------------------------");
		}

		private function garbageCollection() : void {
			_loader = null;
			_fileLoader = null;

			if (_lg.state.toString() != LoaderGroupState.SUSPEND.toString()) {
				_lg.garbageCollection();
				_lg = null;
			}

			delete this;
		}

		// Getter and Setter
		public function get fileLoader() : FileLoaderContext {
			return _fileLoader;
		}

		public function set fileLoader(fileLoader : FileLoaderContext) : void {
			_fileLoader = fileLoader;
		}

		public function get loaderGroup() : LoaderGroup {
			return _lg;
		}

		public function set loaderGroup(lg : LoaderGroup) : void {
			_lg = lg;
		}
	}
}
