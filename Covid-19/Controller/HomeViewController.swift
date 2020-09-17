//
//  HomeViewController.swift
//  Covid-19
//
//  Created by treCoops on 9/15/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var viewInfected: UIView!
    @IBOutlet weak var viewNonInfected: UIView!
    @IBOutlet weak var viewTotal: UIView!
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var viewNews: UIView!
    @IBOutlet weak var viewMap: UIView!
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    var names = ["Anders is sick", "Kristian has head ack", "Sofia has stomack ack", "John cena is a super star", "Jenny Weasly is a harry potter star", "Lina", "Annie", "Katie", "Johanna"]
//    var news : [News] = []
    var news = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        viewInfected.roundView()
        viewTotal.roundView()
        viewNonInfected.roundView()
        viewParent.roundView()
        viewNews.roundView()
        viewMap.roundView()
        
        registerNib()
        
        readNews()
        
    }
    
    func registerNib() {
        let nib = UINib(nibName: NewsCell.nibName, bundle: nil)
        newsCollectionView?.register(nib, forCellWithReuseIdentifier: NewsCell.reuseIdentifier)
        if let flowLayout = self.newsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    func readNews() {
        let ref = Database.database().reference()
        ref.child("Notifications").observe(DataEventType.value, with: { (snapshot) in
          let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for key in postDict {
//                print(key.value["message"] ?? "")
                self.news.append(key.value["message"]! as! String)
                print("Array \(self.news)")
            }
        })
    }
    
}

extension HomeViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return names.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = newsCollectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseIdentifier,
                                                             for: indexPath) as? NewsCell {
            let name = names[indexPath.row]
            cell.configureCell(name: name)
            return cell
        }
        return UICollectionViewCell()
    }
    
}

extension HomeViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let cell: NewsCell = Bundle.main.loadNibNamed(NewsCell.nibName, owner: self, options: nil)?.first as? NewsCell else {
            return CGSize.zero
        }
        
        
        
        cell.configureCell(name: names[indexPath.row])
        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        let size: CGSize = cell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        return CGSize(width: size.width, height: 150)
    }
    
}
