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
class ViewController: UIViewController {
    @IBOutlet weak var facePic: UIImageView!
    @IBOutlet weak var minesLeft: UILabel!
    @IBOutlet weak var timer: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] (_)  in
            time += 0.1
            self!.timer.text = String(format: "%.1f", time)
        })
    }
    //what happens when game is pressed
    @IBAction func gamePressed(_ sender: Any) {
    }
    //what happens when options are pressed
    @IBAction func optionsPessed(_ sender: Any) {
    }
    //what happens when help is pressed
    @IBAction func helpPressed(_ sender: Any) {
    }
}

