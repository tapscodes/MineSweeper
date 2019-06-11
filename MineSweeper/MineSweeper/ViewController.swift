//
//  ViewController.swift
//  MineSweeper
//
//  Created by Tristan Pudell-Spatscheck on 5/30/19.
//  Copyright © 2019 TAPS. All rights reserved.
//
import Foundation
import UIKit
var time = 0.0
var width = 8
var length = 8
var mines = 8
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var facePic: UIImageView!
    @IBOutlet weak var minesLeft: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        minesLeft.text = "Mines Left:\(mines)"
        facePic.image = UIImage(named: "happy")
        // Do any additional setup after loading the view.
        var timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (_)  in
            time += 0.1
            self!.timer.text = String(format: "%.1f", time)
        })
    }
    //amount of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("XX")
        return width*length
    }
    //set sup each cell of collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("WW")
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "mineCell", for: indexPath) as! MineCell
        cell.mineImg.image = UIImage(named: "covered")
        return cell
    }
    //what happens when reset is pressed (used to be called game)
    @IBAction func gamePressed(_ sender: Any) {
        
    }
    //what happens when options are pressed
    @IBAction func optionsPessed(_ sender: Any) {
        
    }
    //what happens when help is pressed
    @IBAction func helpPressed(_ sender: Any) {
        let app = UIApplication.shared
        //opens udacity signup page
        app.open(URL(string: "https://www.instructables.com/id/How-to-play-minesweeper/")!, options: [:], completionHandler: nil)
    }
}

