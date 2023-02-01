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
    let eggTimes = ["Soft": 3, "Medium": 5, "Hard": 7]
    var player:AVAudioPlayer?
    var timer:Timer?
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var eggTitle: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBAction func hardnessSelection(_ sender: UIButton) {
        timer?.invalidate()
        player?.stop()
        let hardness = sender.currentTitle!
        totalTime = eggTimes[hardness]!
        progressBar.progress = 0.0
        secondsPassed = 0
        eggTitle.text = hardness
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                self.progressBar.setProgress(Float(self.secondsPassed) / Float( self.totalTime), animated: true)
            } else {
                Timer.invalidate()
                self.eggTitle.text = "Done."
                self.playSound()
            }
        }
        
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension:"mp3") else {
            return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint:
                                        AVFileType.wav.rawValue)
            guard let player = player else { return }
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
