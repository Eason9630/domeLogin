//
//  DetailViewController.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/7.
//

import UIKit
import SnapKit

class DetailViewController: UIViewController {


    var photoCollection: UICollectionView!
    let DescriptionLabel = UILabel()
    var reviewsTable: UITableView!
    
    var mapInfos: MapInfo?
    var photo: [Photo]?
    var reviews: [Reviews]?
    var detailInfo : DetailInfo?
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white



        title = mapInfos?.name ?? ""
       
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 128, height: 128)
        layout.minimumInteritemSpacing = 1
        layout.estimatedItemSize = .zero
        photoCollection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(photoCollection)
        photoCollection.delegate = self
        photoCollection.dataSource = self
        photoCollection.translatesAutoresizingMaskIntoConstraints = false
        photoCollection.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        
        photoCollection.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(5)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(300)
        }
        
        DescriptionLabel.font = UIFont.systemFont(ofSize: 18)
        DescriptionLabel.textColor = .black
        DescriptionLabel.textAlignment = .left
        DescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(DescriptionLabel)
        DescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(photoCollection.snp_bottom).offset(5)
            make.leading.equalTo(view.snp_leading).offset(0)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(50)
        }
        
        reviewsTable = UITableView(frame: .zero, style: .plain)
        reviewsTable.allowsSelection = false
        reviewsTable.translatesAutoresizingMaskIntoConstraints = false
        reviewsTable.register(ReviewsTableViewCell.self, forCellReuseIdentifier: "ReviewsTableViewCell")
        reviewsTable.rowHeight = 180
        view.addSubview(reviewsTable)
        reviewsTable.dataSource = self
        reviewsTable.delegate = self
        reviewsTable.snp.makeConstraints { make in
            make.top.equalTo(DescriptionLabel.snp_bottom).offset(5)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(300)
        }
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
        return detailInfo?.reviews.count ?? 10
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
        return detailInfo?.photos.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(PhotoCollectionViewCell.self)", for: indexPath) as! PhotoCollectionViewCell
        
        cell.storePhoto.image = UIImage(systemName: "photo")
        
        GoogleMap.shared.getPhoto(photo_reference: detailInfo?.photos[indexPath.row].photo_reference ?? "") { image in
            DispatchQueue.main.async {
                cell.storePhoto.image = image
            }
        }
        return cell
    }
}

