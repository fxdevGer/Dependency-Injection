/**
 * Copyright 15.03.2010 Christian Sobolewski
 * 
 * Usage :	FileLoaderUtils.getTypeFromString(path);
 * 			FileLoaderUtils.setLoadedContent(lg, fileName, content);
 * 			FileLoaderUtils.getGroupByName(id, arr);
 * 
 * Parameters :
 *
 * Description : The FileLoaderUtils Class only used internaly and has some util methods
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.impl {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.net.URLLoaderDataFormat;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class FileLoaderUtils {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(FileLoaderUtils));
		
		public static var XML : String = "xml";
		public static var CSS : String = "css";
		public static var SWF : String = "swf";
		public static var JPG : String = "jpg";
		public static var PNG : String = "png";
		public static var GIF : String = "gif";
		public static var PBJ : String = "pbj";
		public static var MP3 : String = "mp3";
		public static var DAT : String = "dat";
		public static var BIN : String = "bin";
		public static var MAX : String = "3ds";
		public static var OBJ : String = "obj";
		public static var AWD : String = "awd";
		public static var MD5MESH : String = "md5mesh";
		public static var MD5ANIM : String = "md5anim";
		
		protected static var FILE_TYPES : Dictionary = new Dictionary();
		FILE_TYPES[XML] = 1;
		FILE_TYPES[CSS] = 2;
		FILE_TYPES[SWF] = 3;
		FILE_TYPES[JPG] = 4;
		FILE_TYPES[PNG] = 4;
		FILE_TYPES[GIF] = 5;
		FILE_TYPES[PBJ] = 5;
		FILE_TYPES[MP3] = 6;
		FILE_TYPES[DAT] = 7;
		FILE_TYPES[BIN] = 7;
		FILE_TYPES[MAX] = 7;
		FILE_TYPES[OBJ] = 7;
		FILE_TYPES[AWD] = 7;
		FILE_TYPES[MD5MESH] = 7;
		FILE_TYPES[MD5ANIM] = 7;
		
		protected static var FILE_DATA_FORMAT : Dictionary = new Dictionary();
		FILE_DATA_FORMAT[OBJ] = URLLoaderDataFormat.TEXT;
		FILE_DATA_FORMAT[DAT] = URLLoaderDataFormat.BINARY;
		FILE_DATA_FORMAT[BIN] = URLLoaderDataFormat.BINARY;
		FILE_DATA_FORMAT[MAX] = URLLoaderDataFormat.BINARY;
		FILE_DATA_FORMAT[AWD] = URLLoaderDataFormat.BINARY;
		FILE_DATA_FORMAT[MD5MESH] = URLLoaderDataFormat.TEXT;
		FILE_DATA_FORMAT[MD5ANIM] = URLLoaderDataFormat.TEXT;
		
		
		/**
		 * 	getFileTypeMapping(type : String)
		 * 	returns int for type
		 */
		
		public static function getFileTypeMapping(type : String) : int {
			return FILE_TYPES[type];
		}
		
		/**
		 * 	getFileDataMapping(type : String)
		 * 	returns URLLoaderDataFormat for type
		 */
		
		public static function getFileDataFormatMapping(type : String) : String {
			return FILE_DATA_FORMAT[type];
		}
		
		/**
		 * 	getTypeFromString(path : String, cache : String)
		 * 	returns the File Type such as swf, jpg ...
		 */
		public static function getTypeFromString(path : String, cache : String) : String {
			var a : Array = [];
			var s : String = "";

			// log.fatal("path " + path);
			// log.fatal("cache " + cache);

			if (cache == "OFF") {
				a = path.split("?");
				a = String(a[0]).split(".");
				s = a[a.length - 1];
			} else {
				a = path.split(".");
				s = a[a.length - 1];
			}

			// log.fatal("returned file type " + s);

			return s;
		}

		/**
		 * 	getFileFromString(path : String)
		 * 	returns the File Name
		 */
		public static function getFileFromString(path : String) : String {
			var a : Array = [];
			var s : String = "";

			a = path.split("?");
			s = a[0];

			// log.fatal("returned fileName " + s);

			return s;
		}

		/**
		 * 	sets each loaded Content to its Object Reference
		 */
		public static function setLoadedContent(tasks : Vector.<LoaderTask>) : void {
			for each (var task : LoaderTask in tasks) {
				try {
					if (task.objRef) {
						if (task.method) 
//							log.warn('task.objRef: ' + (task.objRef) + " | task.method: " + task.method + " | task.content: " + Boolean(task.content is ByteArray) + " | " + task.path);
							Context.getObject(task.objRef)[task.method] = task.content;
					}
				} catch(e : Error) {
					var errMsg : String = task.content + " could not be injected into " + Context.getObject(task.objRef) + "." + task.method;
					errMsg = errMsg + ". Check if " + task.method + " is defined as a Setter!";
					throw new ConfigurationError(errMsg);
				}
				if (task.callBack != null) {
					var f : Function = task.callBack;
					f(task.content);
				}
			}
		}

		/**
		 * 	returns the specific <code>LoaderGroup</code> by a given Name
		 */
		public static function getGroupByName(id : String, arr : Vector.<LoaderGroup>) : LoaderGroup {
			var lTemp : LoaderGroup = null;
			var l : int = arr.length;

//			log.warn("id: " + id + " " + arr);

			for (var i : int = 0; i < l;i++) {
//				log.fatal('id: ' + (id) + " | " + arr[i].id);
				if (arr[i].id == id) {
					lTemp = arr[i];
					break;
				}
			}

			return lTemp;
		}
	}
}
