//
//  NewsCell.swift
//  Covid-19
//
//  Created by treCoops on 9/16/20.
//  Copyright © 2020 treCoops. All rights reserved.
//

import UIKit

class NewsCell: UICollectionViewCell {

    @IBOutlet weak var txtNews: UILabel!
    @IBOutlet weak var view: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        view.roundView()
    }
    
    class var reuseIdentifier: String {
        return "newsCellReuseable"
    }
    class var nibName: String {
        return "NewsCell"
    }
    
    func configureCell(name: String) {
        self.txtNews.text = name
    }

}


