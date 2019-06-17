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
var totLeft = 0
var mineField: [Bool] = []
var indexPicked = 0
var alive = true
var mineResult = 0
class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    @IBOutlet weak var facePic: UIImageView!
    @IBOutlet weak var minesLeft: UILabel!
    @IBOutlet weak var timer: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        alive = true
        setUp()
        minesLeft.text = "Total Mines:\(mines)"
        facePic.image = UIImage(named: "happy")
        totLeft=length*width
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
        mineResult = checkNearby(index: indexPicked)
        totLeft-=1
        if(!alive){
            endGame()
        }
        if(totLeft == mines){
            basicAlert(title: "You Won!", message: "You were alive for \(timer.text!) seconds. Hit reset to try again!")
        }
    }
    //removes space (horizontally) between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    // removes space (vertically) between items
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
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
    //makes an alert with 3 text fields
    func threeTextField(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addTextField()
        alert.addTextField()
        alert.addTextField()
        alert.textFields![0].placeholder = "Enter width"
        alert.textFields![1].placeholder = "Enter length"
        alert.textFields![2].placeholder = "Enter mines"
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {(action) in
            //sets values entered
            let tempWidth = alert.textFields![0].text
            let tempLength = alert.textFields![1].text
            let tempMines = alert.textFields![2].text
            width = Int(tempWidth!)!
            length = Int(tempLength!)!
            mines = Int(tempMines!)!
        }))
        self.present(alert, animated: true)
    }
    //resets game with new mine spots
    func reset(){
        mineField.removeAll()
        //resets mine placement after old mines are removed
        viewDidLoad()
        //resets visuals of minefield after mines are replaced in random locations
        collectionView.reloadData()
        //resets time when game is reset
        time=0
    }
    //checks for nearby mines and returns the amount
    func checkNearby(index: Int) -> Int{
        var surMines = 0
        //if a mine
        if(mineField[index]){
            surMines+=9
        }
        //if on top row
        else if(index<=width){
            //if the first one, else if last one, else other
            if(index==0) {
                //right
                if(mineField[index+1]){
                    surMines+=1
                }
                //down
                if(mineField[index+width]){
                   surMines+=1
                }
                //down right
                if(mineField[index+width+1]){
                    surMines+=1
                } //END OF FIRST
            } else if (index==width-1) {
                //left
                if(mineField[index-1]){
                    surMines+=1
                }
                //down
                if(mineField[index+width]){
                    surMines+=1
                }
                //down left
                if(mineField[index+width-1]){
                    surMines+=1
                } //END OF LAST
            } else {
                //left
                if(mineField[index-1]){
                    surMines+=1
                }
                //right
                if(mineField[index+1]){
                    surMines+=1
                }
                //down
                if(mineField[index+width]){
                    surMines+=1
                }
                //down left
                if(mineField[index+width-1]){
                    surMines+=1
                }
                //down right
                if(mineField[index+width+1]){
                    surMines+=1
                }
            }
        }//if on bottom row
        else if(index>=((width*length)-width)){
            //if the first one, else if last one, else other
            if((index % width) == 0){
                //right
                if(mineField[index+1]){
                    surMines+=1
                }
                //up
                if(mineField[index-width]){
                    surMines+=1
                }
                //up right
                if(mineField[index-width+1]){
                    surMines+=1
                } //END OF FIRST
            } else if (index==width*length-1) {
                //left
                if(mineField[index-1]){
                    surMines+=1
                }
                //up
                if(mineField[index-width]){
                    surMines+=1
                }
                //up left
                if(mineField[index-width-1]){
                    surMines+=1
                } //END OF LAST
            } else {
                //left
                if(mineField[index-1]){
                    surMines+=1
                }
                //right
                if(mineField[index+1]){
                    surMines+=1
                }
                //up
                if(mineField[index-width]){
                    surMines+=1
                }
                //up left
                if(mineField[index-width-1]){
                    surMines+=1
                }
                //up right
                if(mineField[index-width+1]){
                    surMines+=1
                }
            } //if anywhere else
        } else {
            if((index % width) == 0){ //LEFT
                //right
                if(mineField[index+1]){
                    surMines+=1
                }
                //up
                if(mineField[index-width]){
                    surMines+=1
                }
                //up right
                if(mineField[index-width+1]){
                    surMines+=1
                } //END OF FIRST
                //down
                if(mineField[index+width]){
                    surMines+=1
                }
                //down right
                if(mineField[index+width+1]){
                    surMines+=1
                }
            } else if (index % width == width-1) { //RIGHT
                //left
                if(mineField[index-1]){
                    surMines+=1
                }
                //up
                if(mineField[index-width]){
                    surMines+=1
                }
                //up left
                if(mineField[index-width-1]){
                    surMines+=1
                }
                //down
                if(mineField[index+width]){
                    surMines+=1
                }
                //down left
                if(mineField[index+width-1]){
                    surMines+=1
                } //END OF SECOND
            }else{
            //left
            if(mineField[index-1]){
                surMines+=1
            }
            //right
            if(mineField[index+1]){
                surMines+=1
            }
            //up
            if(mineField[index-width]){
                surMines+=1
            }
            //up left
            if(mineField[index-width-1]){
                surMines+=1
            }
            //up right
            if(mineField[index-width+1]){
                surMines+=1
            }
            //down
            if(mineField[index+width]){
                surMines+=1
            }
            //down left
            if(mineField[index+width-1]){
                surMines+=1
            }
            //down right
            if(mineField[index+width+1]){
                surMines+=1
            }
            }
        }
        //returns mines found
        print(mineField[index])
        return surMines
    }
    //BUTTONS AT TOP
    //what happens when reset is pressed (used to be called game)
    @IBAction func gamePressed(_ sender: Any) {
       reset()
    }
    //what happens when options are pressed
    @IBAction func optionsPessed(_ sender: Any) {
        threeTextField(title: "Set up your custom board", message: "Depending on size, app may not function well (try to keep dimenstions under 10:10)")
        reset()
    }
    //what happens when help is pressed
    @IBAction func helpPressed(_ sender: Any) {
        let app = UIApplication.shared
        //opens udacity signup page
        app.open(URL(string: "https://www.instructables.com/id/How-to-play-minesweeper/")!, options: [:], completionHandler: nil)
    }
}

