//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeCountLable: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var timeCountTest: UILabel!
    
    let eggTimes = ["Soft":300 , "Medium":350 , "Hard": 720]
    
    var timeCount = 0
    var percnetCount = 0
    var zeroCount = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender : UIButton) {
        let hardness = sender.currentTitle
        let hardnessTime = eggTimes[hardness!]
        
        timeCount += Int(hardnessTime!)
        percnetCount += Int(hardnessTime!)
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
      
        
    }
    
    @objc func countTime() {
        if timeCount > 0 {
            timeCount -= 1
            timeCountTest.text = String(timeCount)
            if zeroCount <  percnetCount{
                zeroCount += 1
                timeBar.progress = Float(zeroCount) / Float(percnetCount)
                print(timeBar.progress)
            }
            
            
        }else{
            timer.invalidate()
            timeCountLable.text = "Done"
        }
        

        
    }
    


}
