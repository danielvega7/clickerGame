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
        
        read()
//        write()
        timer = Timer()
        
//        db.collection("names").document("highscores").setData(["highscores": StaticStuff.highScores], merge: true)
    }

    @objc func calculateSeconds() {
         second += 1
        timerEvent()
        timeLabelOutlet.text = String(second)
        write()
    }
    
    func stopTimerTest() {
      timer?.invalidate()
      timer = nil
      second = 0
    }
    
    func timerEvent() {
        
         if second > 5 {
             print(second)
             
             if StaticStuff.highScores.count < 9 {
                 StaticStuff.highScores.append(current)
                 StaticStuff.highScores.sort()
                 write()
             }
             else {
                 var i = 0
                 while(i < StaticStuff.highScores.count) {
                     print("is loop happening")
                         if current > StaticStuff.highScores[i] {
                             StaticStuff.highScores.remove(at: i)
                             StaticStuff.highScores.append(current)
                             StaticStuff.highScores.sort()
                             
                             write()
                         }
                         else{
                             
                         }
                     
                     i += 1
                 }
             }
             
             current = 0
             
             stopTimerTest()
             print("timer stopped ig")
             
            
         } else {
             print(second)
             //stopTimerTest()
         }

        
         
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.calculateSeconds), userInfo: nil, repeats: true)
        current = 0
        timerEvent()
    }
    
    @IBAction func clickMeButtonAction(_ sender: UIButton) {
        current += 1
    }
    
    func read() {
        let docRef = db.collection("clicker").document("highscores")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                
//                if StaticStuff.highScores.count > 0 {
                print("getting called")
                StaticStuff.highScores = dataDescription.first!.value as! [Int]
                //}
//                else {
//                    print("reading getting called")
//                }
//                self.textViewOutlet.text = dataDescription.f
                //print("Document data: \(dataDescription)")
            } else {
                print("Document does not exist")
            }
        }
    }
    func write() {
       
        db.collection("clicker").document("highscores").setData(["highscores": StaticStuff.highScores], merge: true)
//        db.collection("clicker").document("new").setData(["new": StaticStuff.highScores], merge: true)
//        db.collection("clicker").document("again").setData(["please": "urFat"], merge: true)
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

//please
