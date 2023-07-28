//
//  GoogleMapTableViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/6.
//

import UIKit
import CoreLocation
import SnapKit

class GoogleMapTableViewController: UITableViewController,CLLocationManagerDelegate {
    
    
    private var locationManager: CLLocationManager!
    
    var mapInfo = [MapInfo]()
  
    
    let loadingView = UIView()
    let activityIndicator = UIActivityIndicatorView()
    let loadingLabel = UILabel()

    
    func addSearchBar() {
            let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 44))
            tableView.tableHeaderView = searchBar
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.rowHeight = 130
        tableView.register(GoogleMapTableViewCell.self, forCellReuseIdentifier: "GoogleMapTableViewCell")
        
        addSearchBar()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // 初始化定位管理器
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        // 請求定位權限
        locationManager.requestWhenInUseAuthorization()
        setActivityIndicatorView()
        hideActivityIndicatorView()
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
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            GoogleMap.shared.getMap(location: "\(latitude),\(longitude)") { result in
                switch result {
                case .success(let mapModels):
                    print(mapModels)
                    self.mapInfo = mapModels
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mapInfo.count
    }
    
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "\(GoogleMapTableViewCell.self)", for: indexPath) as! GoogleMapTableViewCell
     
         let mapInfo = mapInfo[indexPath.row]
     // Configure the cell...

         cell.nameLabel.text = mapInfo.name
         cell.DetailLabel.text = mapInfo.vicinity
         cell.iconImage.image = UIImage(systemName: "photo")

         GoogleMap.shared.getPhoto(photo_reference: mapInfo.photos[0].photo_reference) { image in
             if let image = image {
                 DispatchQueue.main.async {
                     cell.iconImage.image = image
                 }
             }
         }
         
         
     return cell
     }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("HELLOO")
        guard let controller = DetailViewController() as? DetailViewController else {
            print("I'm die")
            return
            
        }
        controller.mapInfos = mapInfo[indexPath.row]
        print(mapInfo[indexPath.row])
        navigationController?.pushViewController(controller, animated: true)
    }
    

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
    extension GoogleMapTableViewController {
        
        func setActivityIndicatorView() {
            
            let width: CGFloat = 120
            let height: CGFloat = 30
            let x = (tableView.frame.width / 2) - (width / 2)
            let y = (tableView.frame.height / 2) - (height / 2) //- (navigationController?.navigationBar.frame.height)!
            loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
            
            // Sets loading text
            loadingLabel.textColor = .gray
            loadingLabel.textAlignment = .center
            loadingLabel.text = "Loading..."
            loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
            
            // Sets spinner
            activityIndicator.style = .medium
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            activityIndicator.startAnimating()
            
            // Adds text and spinner to the view
            loadingView.addSubview(loadingLabel)
            loadingView.addSubview(activityIndicator)
            tableView.addSubview(loadingView)
            
        }
        
        func showActivityIndicatorView() { loadingView.isHidden = false }
        
        func hideActivityIndicatorView() { loadingView.isHidden = true }
        
    }


    extension GoogleMapTableViewController: UISearchBarDelegate {
        //搜尋文字改變時會觸發
           func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
               //搜尋時跳出loading
               showActivityIndicatorView()

               GoogleMap.shared.sreachMap(keyword: searchText) { result in
                   switch result {
                   case .success(let mapModels):
                       print(mapModels)
                       self.mapInfo = mapModels
                       DispatchQueue.main.async {
                           self.tableView.reloadData()
                       }
                   case .failure(let error):
                       print(error)
                   }
               }
               
           }
           
           //點擊search後會觸發
           func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
               //收鍵盤
               searchBar.resignFirstResponder()
           }
           
    }

