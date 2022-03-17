//
//  ViewController.swift
//  clickerGame
//
//  Created by DANIEL VEGA on 3/15/22.
//

import UIKit
import Firebase

public class StaticStuff {
    static var highScores = [Int]()
    
    
}

class ViewController: UIViewController {

    let db = Firestore.firestore()
    
    var ref = Database.database().reference()

    var infoListener: ListenerRegistration!
    
    var current = 0
    var highScore = [Int]()
    
    var timer : Timer!
    var second = 0

    
    @IBOutlet weak var timeLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // start the timer here so you can get how many seconds before you started or called your method.
        timer = Timer()
        
    }

    @objc func calculateSeconds() {
         second += 1
        timeLabelOutlet.text = String(second)
    }
    
    func stopTimerTest() {
      timer?.invalidate()
      timer = nil
    }
    
    func whatever() {
//        second = 0
         if second > 30 {
             print(second)
             
             if StaticStuff.highScores.count < 9 {
                 StaticStuff.highScores.append(current)
                 StaticStuff.highScores.sort()
             }
             else {
                 var i = 0
                 while(i < StaticStuff.highScores.count) {
                     
                         if current > StaticStuff.highScores[i] {
                             StaticStuff.highScores.remove(at: i)
                             StaticStuff.highScores.append(current)
                             StaticStuff.highScores.sort()
                         }
                         else{
                             
                         }
                     
                     i += 1
                 }
             }
             
             
             
             stopTimerTest()
         } else {
             print(second)
         }

         second = 0
         //timer.invalidate()
         timer = nil
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.calculateSeconds), userInfo: nil, repeats: true)
        whatever()
    }
    
    @IBAction func clickMeButtonAction(_ sender: UIButton) {
        current += 1
    }
    
    func read() {
        
    }
    func write() {
        db.collection("names").document("movieArray").setData(["movie": highScore], merge: true)
    }
    
    /*@objc func fireTimer() {
        var runCount = 0

        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            print("Timer fired!")
            runCount += 1

            if runCount == 3 {
                print("timer finished")
                timer.invalidate()
            }
        }
    } */
}

