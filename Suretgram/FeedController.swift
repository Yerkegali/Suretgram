//
//  FeedController.swift
//  Suretgram
//
//  Created by Yerkegali Abubakirov on 04.07.2018.
//  Copyright © 2018 Yerkegali Abubakirov. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class FeedController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var userName = ""
    var imageURLs: [String] = []
    var titleName = ""
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let url = URL(string: "https://apinsta.herokuapp.com/u/\(userName)")
        Alamofire.request(url!).responseJSON { (json) in
            if json.value == nil {
                print("error")
            } else {
                let swiftyJsonVar = JSON(json.value!)
                let graphql = swiftyJsonVar["graphql"].dictionaryObject! as [String:AnyObject]
                let user = graphql["user"] as! [String:AnyObject]
                let full_name = user["full_name"] as! String

                self.titleName = full_name
                self.navigationItem.title = self.titleName
                let edgeOwnerToTimelineMedia = user["edge_owner_to_timeline_media"] as! [String:AnyObject]
                let edges = edgeOwnerToTimelineMedia["edges"] as! [[String:AnyObject]]
                self.imageURLs = []
                edges.forEach({ (edge) in
                    let nodes = edge["node"] as! [String:AnyObject]
                    let displayUrl = nodes["display_url"] as! String
                    self.imageURLs.append(displayUrl)
                })
                    DispatchQueue.main.async{
                        self.collectionView.reloadData()
                    }
            }
        }.resume()
    }
 
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        let resource = ImageResource(downloadURL: URL(string: imageURLs[indexPath.row])!, cacheKey: imageURLs[indexPath.row])
        
        cell.imgView.kf.setImage(with: resource)
        
        return cell

    }
    
}

