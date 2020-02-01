import UIKit
import Alamofire

class AlamoViewController: UIViewController {
    
    @IBOutlet weak var standartTableView: UICollectionView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var tableView: UICollectionView!
    let cityName = "Krasnodar"
    var weatherDecoded: ForecastDecoder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempLabel.text = "\(Saver.shared.temp)"
        WeatherUpdateWithAlamofire()
    }
}

extension AlamoViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDecoded?.list.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = standartTableView.dequeueReusableCell(withReuseIdentifier: "alamoCell", for: indexPath) as! AlamoCollectionViewCell
        
        
        let dt = Double(weatherDecoded?.list[indexPath.row].dt ?? 0)
        let date = Date(timeIntervalSince1970: dt)
        let dateFormated = DateFormatter()
        dateFormated.dateFormat = "MMM dd HH:mm"
        
        cell.dtLabel.text = dateFormated.string(from: date) + " - \(NSString(format: "%.2f",(weatherDecoded!.list[indexPath.row].main?.temp)! - 273.15))" + " ℃"
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
}

extension AlamoViewController {
    func weatherUpdater() {
        let api = "399e9ee290d3b3f3a2b179c3162f9b41"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(api)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let currentWeather = try JSONDecoder().decode(ForecastDecoder.self, from: data)
                self.weatherDecoded = currentWeather
                DispatchQueue.main.async {
                    
                    let normalTemp = "\(NSString(format: "%.2f",(currentWeather.list[0].main?.temp)! - 273.15))" as String
                    
                    Saver.shared.temp = normalTemp
                    
                    self.tempLabel.text = normalTemp + " ℃"
                    self.cityNameLabel.text = self.cityName
                    self.standartTableView.reloadData()
                }
            } catch { print("Error after download") }
        }.resume()
    }
    
    func WeatherUpdateWithAlamofire() {
        AF.request("https://api.openweathermap.org/data/2.5/forecast?q=Krasnodar&appid=399e9ee290d3b3f3a2b179c3162f9b41").responseJSON { (response) in
            do {
                let currentWeather = try JSONDecoder().decode(ForecastDecoder.self, from: response.data!)
                self.weatherDecoded = currentWeather
                DispatchQueue.main.async {
                    
                    let normalTemp = "\(NSString(format: "%.2f",(currentWeather.list[0].main?.temp)! - 273.15))" as String
                    
                    Saver.shared.temp = normalTemp
                    
                    self.tempLabel.text = normalTemp + " ℃"
                    self.cityNameLabel.text = self.cityName
                    self.standartTableView.reloadData()
                }
            } catch { print("Error after download") }
        }
    }
}
