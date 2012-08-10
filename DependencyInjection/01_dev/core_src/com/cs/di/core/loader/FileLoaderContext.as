/**
 * Copyright 11.03.2010 Christian Sobolewski
 * 
 * Usage :	Context.fileLoader.addLoaderGroup(loaderGroup);
 * 			Context.fileLoader.loadByGroupName(id);
 *			Context.fileLoader.addEventListener(Event.COMPLETE, handleComplete);
 * 
 * Parameters :	
 *
 * Description : The FileLoaderContext Class is the base Class for all Loading activity in this framework. 
 * 				 Method addLoaderGroup is called each time if a loaderGroup node has found.
 * 				 You could call loadByGroupName if you need to load a loaderGroup later in your project.
 * 				 You dont need to create a FileLoader Instance. The Framework does that for you. 
 * 				 Call Context.fileLoader if you need to have that instance.
 * 				 There are two way of loading files sequential and altogether. 
 * 				 Sequential means the start of each file.
 * 				 Altogether means the start of all files.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader {
	import com.cs.di.core.context.Context;
	import com.cs.di.core.context.impl.ConfigurationError;
	import com.cs.di.core.csinject;
	import com.cs.di.core.loader.core.events.FileLoaderEvent;
	import com.cs.di.core.loader.impl.FileLoaderUtils;
	import com.cs.di.core.loader.impl.LoadFiles;
	import com.cs.di.core.loader.impl.LoaderGroup;
	import com.cs.di.core.loader.impl.LoaderGroupState;
	import com.cs.di.core.logger.core.LogContext;
	import com.cs.di.core.logger.impl.Logger;

	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Christian Sobolewski
	 */
	public class FileLoaderContext extends AbstractFileLoaderContext {
		private static const log : Logger = LogContext.getLogger(getQualifiedClassName(FileLoaderContext));
		
		use namespace csinject;	
		
		public function FileLoaderContext() {
			super();
			super.queueComplete = queueOnComplete;
		}
		
		/**
		 * 	called if each <code>LoaderGroup</code> has been loaded or the whole Queue
		 */
		
		private function queueOnComplete(event : FileLoaderEvent) : void {
			log.warn("Queue completely loaded: " + queueLoader.maxLength);
			
			removeListener();
			
			if (hasEventListener(Event.COMPLETE)) dispatchEvent(new Event(Event.COMPLETE));
			
			Context.contextIsReady();
		}
		
		/**
		 * 	call if you want to load a <code>LoaderGroup</code> after parsing and loading the main files
		 * 	
		 * 	Important: You have to add an Event.COMPLETE to FileLoader outside!
		 * 	
		 * 	Its necessary here cause if you load a Group by Name you have to add that Event.COMPLETE 
		 * 	to get informed if <code>LoaderGroup</code> has been loaded.
		 */
		
		public function loadByGroupName(id : String) : void {
			_lg = FileLoaderUtils.getGroupByName(id, _lgArr);
			
			if (_lg != null) {
				loadGroup(_lg, true);
			} else throw new ConfigurationError("LoaderGroup by Name : > " + id + " < could not be found");
		}
		
		/**
		 * 	used to load each <code>LoaderGroup</code>
		 */
		
		private function loadGroup(lg : LoaderGroup, load : Boolean = false) : void {
			lg.state = (lg.state.toString() == LoaderGroupState.ACTIVE.toString()) ? LoaderGroupState.FINISHED : LoaderGroupState.SUSPEND;

			var iLoad : LoadFiles = new LoadFiles();
			iLoad.loaderGroup = lg;
			iLoad.fileLoader = this;
			iLoad.createLoader();
			
			if (load) activeLoaderGroupLoading();
		}
		
		/**
		 * 	adds a <code>LoaderGroup</code> into the queue
		 * 	if state == ACTIVE the group is not stored
		 */
		
		public function addLoaderGroup(lg : LoaderGroup) : void {
			if (lg.state.toString() == LoaderGroupState.ACTIVE.toString()) loadGroup(lg); else _lgArr.push(lg);
		}
		
		/**
		 * 	called after all <code>LoaderGroup</code> and 
		 * 	<code>LoaderTask</code> nodes were parsed
		 */
		
		public function activeLoaderGroupLoading():void {
			log.warn('queueLoader.maxLength: ' + (queueLoader.maxLength));
			if (queueLoader.maxLength > 0) {
				queueLoader.loadByGroupMode();
			} else Context.contextIsReady();
		}
	}
}
