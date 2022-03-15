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
    
    @IBOutlet weak var timeLabelOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func startButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func clickMeButtonAction(_ sender: UIButton) {
    }
    
    func read() {
        
    }
    func write() {
        db.collection("names").document("movieArray").setData(["movie": highScore], merge: true)
    }
}

