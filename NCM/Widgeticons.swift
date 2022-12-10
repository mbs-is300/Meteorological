//
//  Widgeticons.swift
//  NCM
//
//  Created by Meshal Alsallami on 02/12/2022.
//

import Foundation

class Widgeticons {
    func getWeatherIcon (ID: Int) -> [String] {
        
        if ID == 1 {return ["wsymbol_0001_sunny.png","Clear sky"]}
        else if ID == 2 {return ["wsymbol_0002_sunny_intervals.png","Light clouds"]}
        else if ID == 3 {return ["wsymbol_0043_mostly_cloudy.png","Partly cloudy"]}
        else if ID == 4 {return ["wsymbol_0003_white_cloud.png","Cloudy"]}
        else if ID == 5 {return ["wsymbol_0018_cloudy_with_heavy_rain.png","Rain"]}
        else if ID == 6 {return ["wsymbol_0021_cloudy_with_sleet.png","Rain and snow / sleet"]}
        else if ID == 7 {return ["wsymbol_0020_cloudy_with_heavy_snow.png","Snow"]}
        else if ID == 8 {return ["wsymbol_0009_light_rain_showers.png","Rain shower"]}
        else if ID == 9 {return ["wsymbol_0011_light_snow_showers.png","Snow shower"]}
        else if ID == 10 {return ["wsymbol_0013_sleet_showers.png","Sleet shower"]}
        else if ID == 11 {return ["wsymbol_0006_mist.png","Light Fog"]}
        else if ID == 12 {return ["wsymbol_0007_fog.png","Dense fog"]}
        else if ID == 13 {return ["wsymbol_0050_freezing_rain.png","Freezing rain"]}
        else if ID == 14 {return ["wsymbol_0024_thunderstorms.png","Thunderstorms"]}
        else if ID == 15 {return ["wsymbol_0048_drizzle.png","Drizzle"]}
        else if ID == 16 {return ["wsymbol_0056_dust_sand.png","Sandstorm"]}

        // night
        else if ID == 101 {return ["wsymbol_0008_clear_sky_night.png","Clear sky"]}
        else if ID == 102 {return ["wsymbol_0041_partly_cloudy_night.png","Light clouds"]}
        else if ID == 103 {return ["wsymbol_0044_mostly_cloudy_night.png","Partly cloudy"]}
        else if ID == 104 {return ["wsymbol_0042_cloudy_night.png","Cloudy"]}
        else if ID == 105 {return ["wsymbol_0034_cloudy_with_heavy_rain_night.png","Rain"]}
        else if ID == 106 {return ["wsymbol_0037_cloudy_with_sleet_night.png","Rain and snow / sleet"]}
        else if ID == 107 {return ["wsymbol_0036_cloudy_with_heavy_snow_night.png","Snow"]}
        else if ID == 108 {return ["wsymbol_0025_light_rain_showers_night.png","Rain shower"]}
        else if ID == 109 {return ["wsymbol_0027_light_snow_showers_night.png","Snow shower"]}
        else if ID == 110 {return ["wsymbol_0029_sleet_showers_night.png","Sleet shower"]}
        else if ID == 111 {return ["wsymbol_0063_mist_night.png","Light Fog"]}
        else if ID == 112 {return ["wsymbol_0064_fog_night.png","Dense fog"]}
        else if ID == 113 {return ["wsymbol_0068_freezing_rain_night.png","Freezing rain"]}
        else if ID == 114 {return ["wsymbol_0040_thunderstorms_night.png","Thunderstorms"]}
        else if ID == 115 {return ["wsymbol_0066_drizzle_night.png","Drizzle"]}
        else if ID == 116 {return ["wsymbol_0074_dust_sand_night.png","Sandstorm"]}

        else {return ["wsymbol_0999_unknown.png","A weather code could not be determined"]}
    }
}
