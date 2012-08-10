/**
 * Copyright 01.01.2009 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :
 *
 * Description : The ILoaderType Class is implemented by each Loader Type. 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.loader.core.interfaces {
	import com.cs.di.core.loader.core.types.LoaderState;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;

	/**
	 * @author Christian Sobolewski
	 */
	public interface ILoaderType extends IEventDispatcher {
		
		function addFileLoader(fileLoader : IFileLoader) : void;
		
		function set state(state : LoaderState) : void;
		function get state() : LoaderState;
		
		function set groupLoad(groupLoad : String) : void;
		function get groupLoad() : String;
		
		function set dispatcher(dispatcher : IEventDispatcher) : void;		function get dispatcher() : IEventDispatcher;
		
		function get maxLength():uint;
		function set maxLength(maxLength : uint):void;

		function configureListener(dispatcher : EventDispatcher) : void;

		function removeListener(dispatcher : EventDispatcher) : void;

		function completeHandler(event : Event) : void;

		function httpStatusHandler(event : HTTPStatusEvent) : void;

		function ioErrorHandler(event : IOErrorEvent) : void;

		function openHandler(event : Event) : void;

		function progressHandler(event : ProgressEvent) : void;

		function securityErrorHandler(event : SecurityErrorEvent) : void;	}
}
