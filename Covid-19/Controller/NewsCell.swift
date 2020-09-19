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
    @IBOutlet weak var txtName: UILabel!
    
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
    
    func configureCell(news: News) {
        self.txtNews.text = news.news
        self.txtName.text = "(\(news.name))"
    }

}


