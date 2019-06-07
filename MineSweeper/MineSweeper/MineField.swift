//
//  MineField.swift
//  MineSweeper
//
//  Created by Tristan Pudell-Spatscheck on 6/7/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import UIKit
class MineField: UICollectionView, UICollectionViewDelegate{
    //amount of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    //set sup each cell of collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "mineCell", for: indexPath) as! MineCell
        //MineCell.image = put image here
        return cell
    }
}
