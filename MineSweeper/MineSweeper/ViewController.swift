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
var indexPicked = 0
var alive = true
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var facePic: UIImageView!
    @IBOutlet weak var minesLeft: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        minesLeft.text = "Mines Left:\(mines)"
        facePic.image = UIImage(named: "happy")
        // Do any additional setup after loading the view.
        var timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (_)  in
            time += 0.1
            //stops timer if user picks a mine
            if(alive){
            self!.timer.text = String(format: "%.1f", time)
            }
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
    //what happens when a mine spot is clicked
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexPicked = indexPath.row
        if(!alive){
            endGame()
        }
    }
    //NORMAL FUNCTIONS
    //sets up the mineField array with all the mines
    func setUp(){
        alive=true
        collectionView.isUserInteractionEnabled=true
        var i = 0
        var totMines = mines
        //makes a blank minefield
        while(i<(width*length)){
            mineField.append(false)
            i+=1
        }
        //sets up the mines
        while(totMines>0){
            var randomInt = Int.random(in: 0..<(length*width))
            while(mineField[randomInt]){
                randomInt = Int.random(in: 0..<(length*width))
            }
            mineField[randomInt]=true
            totMines-=1
        }
    }
    //ends game
    func endGame(){
        collectionView.isUserInteractionEnabled=false
        facePic.image = UIImage(named: "dead")
        basicAlert(title: "You blew up", message: "You were alive for \(timer.text!) seconds. Hit reset to try again!")
    }
    //makes an alert pop up
    func basicAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true)
    }
    //BUTTONS AT TOP
    //what happens when reset is pressed (used to be called game)
    @IBAction func gamePressed(_ sender: Any) {
        mineField.removeAll()
        //resets mine placement after old mines are removed
        viewDidLoad()
        //resets visuals of minefield after mines are replaced in random locations
        collectionView.reloadData()
        //resets time when game is reset
        time=0
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

