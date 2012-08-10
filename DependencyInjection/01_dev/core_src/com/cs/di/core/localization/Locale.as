/**
 * Copyright 22.06.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The Locale Class 
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.localization {

	/**
	 * @author Christian Sobolewski
	 */
	public class Locale {
		
		private var _language : String = "";
		private var _country : String = "";		private var _ignoreCountry : Boolean;

		public function Locale(language : String = "", country : String = "", igCountry : String = "") {
			_language = language;
			_country = country;
			_ignoreCountry = (igCountry == "true") ? true : false;
		}
		
		/**
		 * 	returns language for <code>Locale</code>
		 */
		
		public function get language() : String {
			return _language;
		}
		
		/**
		 * 	returns country for <code>Locale</code>
		 */
		
		public function get country() : String {
			return _country;
		}
		
		/**
		 * 	returns ignoreCountry for <code>Locale</code>
		 */
		
		public function get ignoreCountry() : Boolean {
			return _ignoreCountry;
		}
		
		/**
		 * 	checks if given <code>Locale</code> equals this <code>Locale</code>
		 */
		
		public function equals(loc : Locale) : Boolean {
			if (loc == this) return true;
			if (loc == null) return false;
			return (loc.language == _language && loc.country == _country);
		}
		
		/**
		 * 	returns toString()
		 */
		
		public function toString() : String {
			return "language: " + _language + " - country: " + _country;
		}
	}
}
