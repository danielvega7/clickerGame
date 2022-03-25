//
//  ViewControllerHighScores.swift
//  clickerGame
//
//  Created by DANIEL VEGA on 3/16/22.
//

import UIKit
import Firebase
class ViewControllerHighScores: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let db = Firestore.firestore()
    
    var ref = Database.database().reference()
    var infoListener: ListenerRegistration!

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tableViewOutlet.reloadData()
        
        infoListener = db.collection("clicker").document("users").addSnapshotListener { (QuerySnapshot, err) in
            if let err = err {
                print("error getting documents: \(err)")
            }
            else {
                self.read()
                let secondsToDelay = 1.0
                DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
                    self.tableViewOutlet.reloadData()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticStuff.allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = StaticStuff.allUsers[indexPath.row].username
        cell.detailTextLabel?.text = String(StaticStuff.allUsers[indexPath.row].highscores[indexPath.row])
        
        return cell
        
       
    }
    func read() {
        let docRef = db.collection("clicker").document("highscores")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let dataDescription = document.data()!
                

                print("getting called")
                StaticStuff.highScores = dataDescription.first!.value as! [Int]
          
            } else {
                print("Document does not exist")
            }
        }
    }
    func write() {
       
        db.collection("clicker").document("highscores").setData(["highscores": StaticStuff.highScores], merge: true)

    }

}
