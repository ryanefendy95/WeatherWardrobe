import UIKit

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperature))º"
    }
    
    var humidityString: String {
        let percentageValue = Int(humidity * 100)
        return "\(percentageValue)%"
    }
    
    var precipitationProbabilityString: String {
        let percentageValue = Int(precipitationProbability * 100)
        return "\(percentageValue)%"
    }
}

class HomeVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var SummaryCollectionView: UICollectionView!
    
    var shirts = ["shirt1", "shirt2", "shirt3"]
    
    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "f2e402e100336f7fdde19e022eae899c")
    let coordinate = Coordinate(latitude: 39.956613, longitude: -75.189944)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.SummaryCollectionView.delegate = self
        self.SummaryCollectionView.dataSource = self
        fetchCurrentWeather()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func fetchCurrentWeather() {
        forecastAPIClient.fetchCurrentWeather(coordinate) { result in
            self.toggleRefreshAnimation(false)
            
            switch result {
            case .success(let currentWeather):
                self.display(currentWeather)
            case .failure(let error as NSError):
                self.showAlert("Unable to retrieve forecast", message: error.localizedDescription)
            default: break
            }
        }
        
    }
    
    func display(_ weather: CurrentWeather) {
        currentTemperatureLabel.text = weather.temperatureString
        currentPrecipitationLabel.text = weather.precipitationProbabilityString
        currentHumidityLabel.text = weather.humidityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }
    
    func showAlert(_ title: String, message: String?, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func refreshWeather(_ sender: AnyObject) {
        toggleRefreshAnimation(true)
        fetchCurrentWeather()
    }
    
    func toggleRefreshAnimation(_ on: Bool) {
        refreshButton.isHidden = on
        
        if on {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shirts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "summaryCell", for: indexPath) as! SummaryCollectionViewCell
        
        // set image
        cell.summaryImageView.image = UIImage(named: shirts[indexPath.row])
        return cell
    }
}
