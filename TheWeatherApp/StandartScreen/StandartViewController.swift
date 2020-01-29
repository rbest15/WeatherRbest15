import UIKit


class StandartViewController: UIViewController {
    
    @IBOutlet weak var standartTableView: UICollectionView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    let cityName = "Krasnodar"
    var weatherDecoded: ForecastDecoder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherUpdater()

    }
}

extension StandartViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherDecoded?.list.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = standartTableView.dequeueReusableCell(withReuseIdentifier: "standartCell", for: indexPath) as! StandartCollectionViewCell
        return cell
    }
}

extension StandartViewController {
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
                    self.tempLabel.text = "\(NSString(format: "%.2f",(currentWeather.list[0].main?.temp)! - 273.15))" + " ℃"
                    self.cityNameLabel.text = self.cityName
                    self.standartTableView.reloadData()
                }
            } catch { print("Error after download") }
        }.resume()
    }
}
