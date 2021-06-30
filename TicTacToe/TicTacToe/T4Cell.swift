//
//  T4Cell.swift
//  TicTacToe
//
//  Created by DCS on 27/06/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class T4Cell: UICollectionViewCell {
    
    private let myImageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    func setupCell(with status:Int) {
        
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        
        contentView.addSubview(myImageView)
        
        myImageView.frame = CGRect(x: 5, y: 5, width: 60, height: 60)
        
        let name = status == 0 ? "0" : status == 1 ? "x" : ""
        myImageView.image = UIImage(named: name)
        //myImageView.image = UIImage(named:"zero.png")
    }
    
}
