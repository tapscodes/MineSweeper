//
//  MineCell.swift
//  MineSweeper
//
//  Created by Tristan Pudell-Spatscheck on 6/7/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import UIKit
class MineCell: UICollectionViewCell{
    @IBOutlet weak var mineImg: UIImageView!
    override var isSelected: Bool{
        didSet{
            if (self.isSelected && !mineField[indexPicked]){
                mineImg.image = UIImage(named: "uncovered")
            }
            else if (self.isSelected){
                mineImg.image = UIImage(named: "mine")
            }
        }
    }
}
