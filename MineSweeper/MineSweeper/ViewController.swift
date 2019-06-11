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
var mineField: [Bool] = []
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
    //MINEFIELD SETUP
    //amount of items in collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return width*length
    }
    //set sup each cell of collectionView
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "mineCell", for: indexPath) as! MineCell
        cell.mineImg.image = UIImage(named: "covered")
        return cell
    }
    //sets size of each cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewWidth = Double(self.view.frame.width)
        let viewHeight = Double(self.view.frame.height)
        return CGSize(width: (viewWidth / Double(width)), height: (viewHeight / Double(length)))
    }
    //NORMAL FUNCTIONS
    //sets up the mineField array with all the mines
    func setUp(){
        var i = 0
        while(i<(width*length)){
            let randomBool = Bool.random()
            mineField.append(randomBool)
            i+=1
        }
    }
    //BUTTONS AT TOP
    //what happens when reset is pressed (used to be called game)
    @IBAction func gamePressed(_ sender: Any) {
        mineField.removeAll()
    }
    //what happens when options are pressed
    @IBAction func optionsPessed(_ sender: Any) {
        let alert = UIAlertController()
        alert.title = "Enter Size and Mines"
        self.present(alert, animated: true)
    }
    //what happens when help is pressed
    @IBAction func helpPressed(_ sender: Any) {
        let app = UIApplication.shared
        //opens udacity signup page
        app.open(URL(string: "https://www.instructables.com/id/How-to-play-minesweeper/")!, options: [:], completionHandler: nil)
    }
}

