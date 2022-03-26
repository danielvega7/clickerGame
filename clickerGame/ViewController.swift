//
//  ViewController.swift
//  clickerGame
//
//  Created by DANIEL VEGA on 3/15/22.
//

import UIKit
import Firebase



class ViewController: UIViewController {

    @IBOutlet weak var nameLoggedInLabelOutlet: UILabel!
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
        print("\(db.collection("clicker").path.count)")
        read()
//        write()
        timer = Timer()
        nameLoggedInLabelOutlet.text = StaticStuff.currentUser.username
//        db.collection("names").document("highscores").setData(["highscores": StaticStuff.highScores], merge: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("view did appear current user \(StaticStuff.currentUser.username)")
        nameLoggedInLabelOutlet.text = StaticStuff.currentUser.username
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
        
         if second > 30 {
             
             StaticStuff.currentUser.highscores.append(current)
             
             writeUserArray()
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

    }
    func writeUserArray() {
        do {
            let encoder = JSONEncoder()
            
            StaticStuff.allUsersData = [Data]()
            var c = 0
            while(c < StaticStuff.allUsers.count){
                let data = try encoder.encode(StaticStuff.allUsers[c])
                StaticStuff.allUsersData.append(data)
                c+=1
            }

            
           
            
        }
        catch {
           print("rip took an L")
        }
        db.collection("clicker").document("users").setData(["userArray": StaticStuff.allUsersData], merge: true)

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
