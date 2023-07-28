//
//  WeatherViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/3.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController ,CLLocationManagerDelegate{
    
    let dustrictName = UILabel()
    let derscribetion = UILabel()
    let weatherImage = UIImageView()
    let temp = UILabel()
    let humidity = UILabel()
    let feelTemp = UILabel()
    let maxTemp = UILabel()
    let minTemp = UILabel()
    
    var weatherModel: WeatherModel?
    
    var locationManager: CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager?.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest

        
        // name
        dustrictName.font = UIFont.systemFont(ofSize: 20)
        dustrictName.textColor = .black
        view.addSubview(dustrictName)
        dustrictName.translatesAutoresizingMaskIntoConstraints = false
        
        dustrictName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(view)
        }
        //天氣描述
        derscribetion.font = UIFont.systemFont(ofSize: 20)
        derscribetion.textColor = .black
        view.addSubview(derscribetion)
        derscribetion.translatesAutoresizingMaskIntoConstraints = false
        
        derscribetion.snp.makeConstraints { make in
            make.top.equalTo(dustrictName.snp_bottom).offset(20)
            make.centerX.equalTo(view)
        }
        //圖片
        weatherImage.image = UIImage(systemName: "photo")
        view.addSubview(weatherImage)
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        
        weatherImage.snp.makeConstraints { make in
            make.top.equalTo(derscribetion.snp_bottom).offset(30)
            make.centerX.equalTo(view)
            make.width.equalTo(180)
            make.height.equalTo(100)
        }
        //溫度
        let tempLabel = UILabel()
        tempLabel.text = "溫度:"
        tempLabel.textColor = .black
        tempLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(tempLabel)
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        tempLabel.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp_bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.width.equalTo(100)
        }
        temp.font = UIFont.systemFont(ofSize: 20)
        temp.textColor = .black
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        
        temp.snp.makeConstraints { make in
            make.top.equalTo(weatherImage.snp_bottom).offset(40)
            make.leading.equalTo(tempLabel.snp_trailing).offset(30)
        }
        //最高溫度
        let maxTempLabel = UILabel()
        maxTempLabel.text = "最高溫度:"
        maxTempLabel.textColor = .black
        maxTempLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(maxTempLabel)
        maxTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        maxTempLabel.snp.makeConstraints { make in
            make.top.equalTo(tempLabel.snp_bottom).offset(40)
            make.leading.equalTo(view.snp_leading).offset(40)
            make.width.equalTo(100)
        }
        maxTemp.font = UIFont.systemFont(ofSize: 20)
        maxTemp.textColor = .black
        view.addSubview(maxTemp)
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        
        maxTemp.snp.makeConstraints { make in
            make.top.equalTo(temp.snp_bottom).offset(40)
            make.leading.equalTo(maxTempLabel.snp_trailing).offset(30)
        }
        //最低溫度
        let minTempLabel = UILabel()
        minTempLabel.text = "最低溫度:"
        minTempLabel.textColor = .black
        minTempLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(minTempLabel)
        minTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        minTempLabel.snp.makeConstraints { make in
            make.top.equalTo(maxTempLabel.snp_bottom).offset(40)
            make.leading.equalTo(view.snp_leading).offset(40)
            make.width.equalTo(100)
        }
        minTemp.font = UIFont.systemFont(ofSize: 20)
        minTemp.textColor = .black
        view.addSubview(minTemp)
        minTemp.translatesAutoresizingMaskIntoConstraints = false
        
        minTemp.snp.makeConstraints { make in
            make.top.equalTo(maxTemp.snp_bottom).offset(40)
            make.leading.equalTo(minTempLabel.snp_trailing).offset(30)
        }
        //濕度
        let humidityLabel = UILabel()
        humidityLabel.text = "濕度:"
        humidityLabel.textColor = .black
        humidityLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(humidityLabel)
        humidityLabel.translatesAutoresizingMaskIntoConstraints = false
        
        humidityLabel.snp.makeConstraints { make in
            make.top.equalTo(minTempLabel.snp_bottom).offset(40)
            make.leading.equalTo(view.snp_leading).offset(40)
            make.width.equalTo(100)
        }
        humidity.font = UIFont.systemFont(ofSize: 20)
        humidity.textColor = .black
        view.addSubview(humidity)
        humidity.translatesAutoresizingMaskIntoConstraints = false
        
        humidity.snp.makeConstraints { make in
            make.top.equalTo(minTemp.snp_bottom).offset(40)
            make.leading.equalTo(humidityLabel.snp_trailing).offset(30)
        }
        //體感溫度
        let feelTempLabel = UILabel()
        feelTempLabel.text = "體感溫度:"
        feelTempLabel.textColor = .black
        feelTempLabel.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(feelTempLabel)
        feelTempLabel.translatesAutoresizingMaskIntoConstraints = false
        
        feelTempLabel.snp.makeConstraints { make in
            make.top.equalTo(humidityLabel.snp_bottom).offset(40)
            make.leading.equalTo(view.snp_leading).offset(40)
            make.width.equalTo(100)
        }
        feelTemp.font = UIFont.systemFont(ofSize: 20)
        feelTemp.textColor = .black
        view.addSubview(feelTemp)
        feelTemp.translatesAutoresizingMaskIntoConstraints = false
        
        feelTemp.snp.makeConstraints { make in
            make.top.equalTo(humidity.snp_bottom).offset(40)
            make.leading.equalTo(feelTempLabel.snp_trailing).offset(30)
        }
        
       
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
          gradientLayer.colors = [
            UIColor(red: 0.949, green: 0.855, blue: 0.396, alpha: 1).cgColor,
            UIColor(red: 0.933, green: 0.855, blue: 0.396, alpha: 1).cgColor,
            UIColor(red: 0.878, green: 0.651, blue: 0.467, alpha: 1).cgColor,
            UIColor(red: 0.776, green: 0.784, blue: 0.694, alpha: 1).cgColor
          ]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        requestLocationPermission()
    }
    
    
    private func requestLocationPermission() {
            locationManager = CLLocationManager()
            locationManager?.delegate = self

            // 請求定位權限
            locationManager?.requestWhenInUseAuthorization()
        }
    
    // 請求定位權限的回調方法
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization() // First time lanch app need to get authorize from user
          fallthrough
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation() // Start location
        case .denied:
          let alertController = UIAlertController(title: "定位權限已關閉", message:"如要變更權限，請至 設定 > 隱私權 > 定位服務 開啟", preferredStyle: .alert)
          let okAction = UIAlertAction(title: "確認", style: .default, handler:nil)
          alertController.addAction(okAction)
          self.present(alertController, animated: true, completion: nil)
        default:
          break
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
            locationManager?.stopUpdatingLocation()
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
                    
                    if suffix == "n" {
                        self.view.backgroundColor = UIColor.blue
                    }else{
                        self.view.backgroundColor = UIColor.lightGray
                    }

                    }
                }
        }.resume()
    }

    
}
