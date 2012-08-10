/**
 * Copyright 22.06.2010 Christian Sobolewski
 * 
 * Usage :
 * 
 * Parameters :	
 *
 * Description : The LocaleUtil Class used for some util methods.
 *
 * Version :	1.0
 * 
 * History : 	-
 * 
 */
package com.cs.di.core.localization.impl {
	import com.cs.di.core.localization.Locale;

	/**
	 * @author Christian Sobolewski
	 */
	public class LocaleUtil {

		/**
		 * 	returns the country suffix
		 */
		public static function getSuffix(loc : Locale, ignoreCountry : Boolean = false) : String {
			if (loc.language == "") return "";
			var suffix : String = "_" + loc.language;
			return (ignoreCountry || loc.country == "") ? suffix : suffix + "_" + loc.country;		
		}
		
		/**
		 * 	returns the xml file name
		 */
		public static function getFilename(basename : String, loc : Locale, ignoreCountry : Boolean = false) : String {
			return basename + getSuffix(loc, ignoreCountry) + ".xml";
		}	
	}
}
