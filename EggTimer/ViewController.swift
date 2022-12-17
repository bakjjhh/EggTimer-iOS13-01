//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeCountLable: UILabel!
    @IBOutlet weak var timeBar: UIProgressView!
    @IBOutlet weak var timeCountTest: UILabel!
    var player: AVAudioPlayer?
    
    let eggTimes = ["Soft":3 , "Medium":5 , "Hard": 7]
    
    var timeCount = 0
    var totalTime = 0
    var secondsPassed = 0
    
    var timer = Timer()
    
    @IBAction func hardnessSelected(_ sender : UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle!
        totalTime += eggTimes[hardness]!
        
        timeBar.progress = 0.0
        secondsPassed = 0
        timeCountTest.text = String(hardness)
       
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countTime), userInfo: nil, repeats: true)
      
        
    }
    
    @objc func countTime() {
        if secondsPassed < totalTime {
            
            
            secondsPassed += 1
            
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            
            timeBar.progress = percentageProgress
            
            timeCountTest.text = String(percentageProgress)
            
            
        }else{
            playSound()
            timer.invalidate()
            timeCountLable.text = "Done"
        }
        

        func playSound() {
            guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

            do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                /* iOS 10 and earlier require the following line:
                player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                guard let player = player else { return }

                player.play()

            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        
        
        
    }
    


}
