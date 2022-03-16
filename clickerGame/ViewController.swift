//
//  ViewController.swift
//  clickerGame
//
//  Created by DANIEL VEGA on 3/15/22.
//

import UIKit
import Firebase
class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    var ref = Database.database().reference()

    var infoListener: ListenerRegistration!
    
    var current = 0
    var highScore = [Int]()
    
    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)

    
    @IBOutlet weak var timeLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startButtonAction(_ sender: UIButton) {
        fireTimer()
    }
    
    @IBAction func clickMeButtonAction(_ sender: UIButton) {
        current += 1
    }
    
    func read() {
        
    }
    func write() {
        db.collection("names").document("movieArray").setData(["movie": highScore], merge: true)
    }
    
    @objc func fireTimer() {
        var runCount = 0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            runCount += 1

            if runCount == 3 {
                print("timer finished")
                timer.invalidate()
            }
        }
    }
}

