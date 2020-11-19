

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer?
    var counter: Int = 0
    var timer = Timer()
    var initialProgress: Float = 0.0
    var observedProgress: Float = 0.0

    @IBOutlet weak var HeaderText: UILabel!
    @IBOutlet weak var TimerProgress: UIProgressView!
    
    @objc func updateCounter() {
        //example functionality
        if counter > 0 {
            counter -= 1
            observedProgress = (initialProgress - Float(counter))/Float(initialProgress)
            TimerProgress.progress = observedProgress
        } else if counter == 0 {
            TimerProgress.progress = 1.0
            PlaySound()
            HeaderText.text = "DONE!"
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.HeaderText.text = "How do you like your eggs?"
                self.TimerProgress.progress = 0.0
            }
        }
    }
    
    let EggTimes = [
        "Soft": 5,
        "Medium": 7,
        "Hard": 12
    ]
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        let Hardness = sender.currentTitle!
        counter = EggTimes[Hardness]!
        initialProgress = Float(counter)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        HeaderText.text = "\(Hardness)"
        }
    
    func PlaySound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try!AVAudioPlayer(contentsOf: url!)
        player?.play()
    }
    
}
