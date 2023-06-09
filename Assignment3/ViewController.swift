//
//  ViewController.swift
//  Assignment3
//
//  Created by Ben Hardy on 6/9/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var clockLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var countdownDatePicker: UIDatePicker!
    //@IBOutlet weak var remainingTimeLabel: UIButton!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    
    var timer: Timer?
    var currentBackground: String?
    var countdownTimer: Timer?
    var remainingTime: TimeInterval = 0
    let formatter = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        formatter.dateFormat = "E, d MMM yyyy HH:mm:ss"
        updateClock()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            self?.updateClock()
            self?.updateBackgroundImage()
        }
        
        updateBackgroundImage()
        
        
    }
        
    func updateClock() {
        let currentDateTime = Date()
        let formattedDateTime = formatter.string(from: currentDateTime)
        clockLabel.text = formattedDateTime
    }
        
    func updateBackgroundImage() {
        let calender = Calendar.current
        let currentDateTime = Date()
        let hour = calender.component(.hour, from: currentDateTime)
        let minute = calender.component(.minute, from: currentDateTime)
        let newBackground: String
        if hour < 12 {
            newBackground = "daytimeBG"
        } else {
            newBackground = "eveningBG"
        }
        
        if newBackground != currentBackground {
            currentBackground = newBackground
            backgroundImageView.image = UIImage(named: newBackground)
        }
        
    }
        
    
    @IBAction func startTimerButtonPressed(_ sender: UIButton) {
        let selectedTime = countdownDatePicker.countDownDuration
            remainingTime = selectedTime
            
            countdownTimer?.invalidate()
            countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            
            updateTimeLabel()
    }
    
    func updateTimeLabel() {
        let hours = Int(remainingTime) / 3600
            let minutes = (Int(remainingTime) % 3600) / 60
            let seconds = Int(remainingTime) % 60
            
            let timeString = String(format: "%02d:%02d:%02d", hours, minutes, seconds)
            remainingTimeLabel.text = timeString
    }
    
    
    
    func stopTimer() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    @objc func updateTimer() {
        remainingTime -= 1
        
        if remainingTime <= 0 {
            countdownTimer?.invalidate()
            
        }
        
        updateTimeLabel()
    }
}
