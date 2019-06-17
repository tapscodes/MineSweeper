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
            if (self.isSelected && (mineResult==0)){
                mineImg.image = UIImage(named: "uncovered")
            }
            else if (self.isSelected && (mineResult==1)){
                mineImg.image = UIImage(named: "one")
            }
            else if (self.isSelected && (mineResult==2)){
                mineImg.image = UIImage(named: "two")
            }
            else if (self.isSelected && (mineResult==3)){
                mineImg.image = UIImage(named: "three")
            }
            else if (self.isSelected && (mineResult==4)){
                mineImg.image = UIImage(named: "four")
            }
            else if (self.isSelected && (mineResult==5)){
                mineImg.image = UIImage(named: "five")
            }
            else if (self.isSelected && (mineResult==6)){
                mineImg.image = UIImage(named: "six")
            }
            else if (self.isSelected && (mineResult==7)){
                mineImg.image = UIImage(named: "seven")
            }
            else if (self.isSelected && (mineResult==8)){
                mineImg.image = UIImage(named: "eight")
            }
            else if (self.isSelected && mineResult==9){
                mineImg.image = UIImage(named: "mine")
                alive=false
            }
        }
    }
}
