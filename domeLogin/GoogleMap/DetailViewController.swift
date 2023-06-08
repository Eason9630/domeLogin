//
//  DetailViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/7.
//

import UIKit

class DetailViewController: UIViewController {


    @IBOutlet weak var photoCollection: UICollectionView!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var reviewsTable: UITableView!
    
    
    @IBOutlet weak var titleName: UINavigationItem!
    
    var mapInfos: MapInfo?
    var photo: [Photo]?
    var reviews: [Reviews]?
    var detailInfo : DetailInfo?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        reviewsTable.dataSource = self
        reviewsTable.delegate = self
        
        titleName.title = mapInfos?.name
        DescriptionLabel.text = mapInfos?.vicinity
        
        
        GoogleMap.shared.detailMap(place_id: mapInfos?.place_id ?? "") { result in
            switch result {
            case .success(let detailInfos):
                self.detailInfo = detailInfos
                DispatchQueue.main.async {
                    self.photoCollection.reloadData()
                    self.reviewsTable.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailInfo?.reviews.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "\(ReviewsTableViewCell.self)", for: indexPath) as! ReviewsTableViewCell
        
        cell.authorName.text = detailInfo?.reviews[indexPath.row].author_name
        cell.authorTextLabel.text = detailInfo?.reviews[indexPath.row].text
        let time = detailInfo?.reviews[indexPath.row].time ?? Date()
        let timeInterval =  time.timeIntervalSince1970
        let date = Date(timeIntervalSince1970: timeInterval)
        self.dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"
        cell.timeLabel.text = dateFormatter.string(from: date)
  

        
        return cell
    }
    
    
}
extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return detailInfo?.photos.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as! PhotoCollectionViewCell
        
        cell.storePhoto.image = UIImage(systemName: "placeholder")
        
        GoogleMap.shared.getPhoto(photo_reference: detailInfo?.photos[indexPath.row].photo_reference ?? "") { image in
            DispatchQueue.main.async {
                cell.storePhoto.image = image
            }
        }
        return cell
    }
}

