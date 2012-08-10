/**
 * Copyright 08.11.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : The LoaderGroup Class is created if an LoaderGroup node has been found by the Framework Parser.
 * 				 It creates a LoaderTask for each LoaderGroup node and stores its LoaderGroupState.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.impl {
	import flash.utils.ByteArray;
	/**
	 * @author Christian Sobolewski
	 */
	public class LoaderGroup {
//		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(LoaderGroup));
		
		protected var _tasks : Vector.<LoaderTask>;
		protected var _id : String;
		protected var _state : LoaderGroupState;
		protected var _load : LoaderGroupLoad;
		protected var _cache : LoaderGroupCache;

		public function LoaderGroup() {
			_tasks = new Vector.<LoaderTask>();
		}
		
		/**
		 * 	setLoadedContent(fileName : String, content : *) sets content to its <code>LoaderTask</code>
		 */
		public function setLoadedContent(fileName : String, content : *) : void {
			var t : LoaderTask = getLoaderTaskByName(fileName);
			if (content is ByteArray) {
				// if content is ByteArray create a new Instance, cause in LoadFiles event.data.dispose() is called.
				var b : ByteArray = new ByteArray();
				b.writeBytes(content, 0, content.length);
				t.content = b;
			} else t.content = content;
		}

		/**
		 * 	addTask a <code>LoaderTask</code>
		 */
		public function addTask(t : LoaderTask) : void {
			_tasks.push(t);
		}

		/**
		 * 	frees Memory
		 */
		public function garbageCollection() : void {
			_state = null;
			_load = null;
			_cache = null;
			
			for each (var t : LoaderTask in _tasks) {
				t.garbageCollection();
			}
			
			_tasks = null;
			_id = undefined;

			delete this;
		}

		/**
		 * getLoaderTaskByName(fileName : String) 
		 * returns the <code>LoaderTask</code> by Name
		 */
		private function getLoaderTaskByName(fileName : String) : LoaderTask {
			for each (var t : LoaderTask in _tasks) {
				if (t.path == fileName) return t;
			}
			return null;
		}

		/**
		 * 	returns all <code>LoaderTask</code> found for this <code>LoaderGroup</code>
		 */
		public function get tasks() : Vector.<LoaderTask> {
			return _tasks;
		}

		/**
		 * 	returns the id
		 */
		public function get id() : String {
			return _id;
		}

		/**
		 * 	sets the id
		 */
		public function set id(id : String) : void {
			_id = id;
		}

		/**
		 * 	returns <code>LoaderGroupState</code> 
		 */
		public function get state() : LoaderGroupState {
			return _state;
		}

		/**
		 * 	sets <code>LoaderGroupState</code> 
		 */
		public function set state(state : LoaderGroupState) : void {
			_state = state;
		}

		/**
		 * 	returns <code>LoaderGroupLoad</code> 
		 */
		public function get load() : LoaderGroupLoad {
			return _load;
		}

		/**
		 * 	sets <code>LoaderGroupState</code> 
		 */
		public function set load(load : LoaderGroupLoad) : void {
			_load = load;
		}

		/**
		 * 	returns <code>LoaderGroupCache</code> 
		 */
		public function get cache() : LoaderGroupCache {
			return _cache;
		}

		/**
		 * 	sets <code>LoaderGroupCache</code> 
		 */
		public function set cache(cache : LoaderGroupCache) : void {
			_cache = cache;
		}
	}
}
