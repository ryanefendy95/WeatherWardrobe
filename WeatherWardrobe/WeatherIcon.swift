import Foundation
import UIKit

enum WeatherIcon: String {
    case clearDay = "clear-day"
    case clearNight = "clear-night"
    case rain = "rain"
    case snow = "snow"
    case sleet = "sleet"
    case wind = "wind"
    case fog = "fog"
    case cloudy = "cloudy"
    case partlyCloudyDay = "partly-cloudy-day"
    case partlyCloudyNight = "partly-cloudy-night"
    case unexpectedType = "default"
    
    init(rawValue: String) {
        switch rawValue {
        case "clear-day": self      = .clearDay
        case "clear-night": self    = .clearNight
        case "rain": self           = .rain
        case "snow": self           = .snow
        case "sleet": self          = .sleet
        case "wind": self           = .wind
        case "fog": self            = .fog
        case "cloudy": self         = .cloudy
        case "partly-cloudy-day": self = .partlyCloudyDay
        case "partly-cloudy-night": self = .partlyCloudyNight
        default: self = .unexpectedType
        }
    }
}

extension WeatherIcon {
    var image: UIImage {
        return UIImage(named: self.rawValue)!
    }
}



















