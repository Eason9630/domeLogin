//
//  WeatherViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/3.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController ,CLLocationManagerDelegate{


    @IBOutlet weak var dustrictName: UILabel!
    
    @IBOutlet weak var derscribetion: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBOutlet weak var temp: UILabel!
    
    @IBOutlet weak var humidity: UILabel!
    
    @IBOutlet weak var feelTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    
    var locationManager: CLLocationManager!
    
    var weatherModel: WeatherModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化定位管理器
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // 請求定位權限
        locationManager.requestWhenInUseAuthorization()
        
    }
    
    // 請求定位權限的回調方法
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // 開始定位更新
            locationManager.startUpdatingLocation()
        }
    }
    
    // 接收定位更新的回調方法
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            // 在這裡可以使用獲取到的經緯度進行相應的處理
            print("緯度：\(latitude)")
            print("經度：\(longitude)")
            
            GetWeather.share.WeatherInfo(lon: "\(longitude)", lat: "\(latitude)") { result in
                switch result {
                case .success(let weather):
                    print(weather)
                    DispatchQueue.main.async {
                        
                        self.getWeather(weather: weather)

                    }
                 
                case .failure(let error):
                    print(error)
                }
                    
                
            }
            
            // 獲取到所需的位置資訊後，停止定位更新
            locationManager.stopUpdatingLocation()
        }
    }
    
    // 處理定位錯誤的回調方法
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("定位錯誤：\(error.localizedDescription)")
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func  getWeather (weather: WeatherModel) {
        
        guard let icon = weather.weather.first?.icon else{return}
        guard let suffix = weather.weather.first?.icon.suffix(1) else {return}
        weatherImage.image = UIImage(systemName: "photo")
        let imageUrl = URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
        URLSession.shared.dataTask(with: imageUrl!) { data , response, error in
            if let data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.weatherImage.image = image
                    self.dustrictName.text = weather.name
                    self.derscribetion.text = weather.weather[0].description
                    self.temp.text = "\(weather.main.temp)℃"
                    self.minTemp.text = "\(weather.main.temp_min)℃"
                    self.maxTemp.text = "\(weather.main.temp_max)℃"
                    self.humidity.text = "\(weather.main.humidity)%"
                    self.feelTemp.text = "\(weather.main.feels_like)℃ "
                    
                    if (suffix == "n") {
                        self.view.backgroundColor = UIColor(red: 11/255, green: 72/255, blue: 108/255, alpha: 1)
                       self.changeLabelColorsIn(view: self.view, suffix: "n")
                    }else{
                        self.view.backgroundColor = UIColor(red: 36/255, green: 186/255, blue: 224/255, alpha: 1)
                        self.changeLabelColorsIn(view: self.view, suffix: "d")
                        }
                    }
                }
        }.resume()
    }
    
    func changeLabelColorsIn(view: UIView, suffix: String) {
        for subview in view.subviews {
            if let label = subview as? UILabel {
                if let text = label.text, text.hasSuffix(suffix) {
                    label.textColor = (suffix == "n") ? UIColor.white : UIColor.black
                }
            } else {
                changeLabelColorsIn(view: subview, suffix: suffix)
            }
        }
    }
    
}
