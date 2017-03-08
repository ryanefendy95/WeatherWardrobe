import Foundation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}

enum Forecast: Endpoint {
    case current(token: String, coordinate: Coordinate)
    
    var baseURL: URL {
        return URL(string: "https://api.forecast.io")!
    }
    
    var path: String {
        switch self {
        case .current(let token, let coordinate):
            return "/forecast/\(token)/\(coordinate.latitude),\(coordinate.longitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        return URLRequest(url: url)
    }
}

final class ForecastAPIClient: APIClient {
    var configuration: URLSessionConfiguration
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    fileprivate let token: String
    
    init(config: URLSessionConfiguration, APIKey: String) {
        self.configuration = config
        self.token = APIKey
    }
    
    convenience init(APIKey: String) {
        self.init(config: URLSessionConfiguration.default, APIKey: APIKey)
    }
    
    
    func fetchCurrentWeather(_ coordinate: Coordinate, completion: @escaping  (APIResult<CurrentWeather>) -> Void) {
        let request = Forecast.current(token: self.token, coordinate: coordinate).request
        
        fetch(request, parse: { json -> CurrentWeather? in
            // Parse from JSON response to CurrentWeather
            
            if let currentWeatherDictionary = json["currently"] as? [String : AnyObject] {
                return CurrentWeather(JSON: currentWeatherDictionary)
            } else {
                return nil
            }
            
        }, completion: completion)
    }
}
