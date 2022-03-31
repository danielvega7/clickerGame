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
    var temp = [User]()
    var stored = [User]()
    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //delegates and data source
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
        
        // making background and table view transparent
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "coolGradient3")!)
        tableViewOutlet.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
        tableViewOutlet.clipsToBounds = true
        tableViewOutlet.layer.cornerRadius = 25
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
        temp = StaticStuff.allUsers
       
        
        
       
        while(temp.count > 0){
            var current = temp[0]
            var index = 0
            var sort = 0
            var high = temp[0].top
            
            while(sort < temp.count) {
                if temp[sort].top > high {
                high = temp[sort].top
                current = temp[sort]
                    index = sort
            }
                else {
            
                }
                sort += 1
            }
            stored.append(current)
            temp.remove(at: index)
            
        }
        
        var quick = 0
        while(quick < stored.count){
            print("whats stored" + stored[quick].username)
            quick+=1
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //machoRead()
        tableViewOutlet.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticStuff.allUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = StaticStuff.allUsers[indexPath.row].username
        StaticStuff.allUsers[indexPath.row].findHigh()
        
        cell.detailTextLabel?.text = String(StaticStuff.allUsers[indexPath.row].top)
        
        return cell
        
       
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        StaticStuff.allUsers[indexPath.row].dateConfigure()
        writeUserArray()
        let alertController = UIAlertController(title: "Date of \(StaticStuff.allUsers[indexPath.row].username)'s High Score", message: StaticStuff.allUsers[indexPath.row].dateString, preferredStyle: .alert)
        let action = UIAlertAction(title: "Awesome", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true)
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
    func writeUserArray() {
       
        db.collection("clicker").document("users").setData(["userArray": StaticStuff.allUsersData], merge: true)

    }
    func machoRead()
        {
            let docRef = db.collection("clicker").document("users")
            docRef.getDocument { (document, error) in

                if let document = document, document.exists {
                    let dataDescription = document.data()!
                    var data = [Data]()

                    if let temp = dataDescription["userArray"] as? [Data] {
                        data = temp
                    }



                    do{
                        StaticStuff.allUsersData = data
                        let decoder = JSONDecoder()
                       
                        for each in data {
                            print("is happening")
                            StaticStuff.allUsers = try decoder.decode([User].self, from: each)
                        }
                        
                        
                        
                    } catch {
                        print("unable to encode class for loop")
                    }
                    do {
                        let decoder = JSONDecoder()
                        var c = 0
                        StaticStuff.allUsers = [User]()
                        while(c < data.count) {
                            StaticStuff.currentUser = try decoder.decode(User.self, from: data[c])
                            print("testing \(StaticStuff.currentUser.username)")
                            StaticStuff.allUsers.append(StaticStuff.currentUser)
                            c+=1
                        }
                    }
                    catch {
                        print("unable to encode class while loop")
                    }
                }
            }
            var what = 0
            while(what < StaticStuff.allUsers.count){
                print(StaticStuff.allUsers[what].username)
                what+=1
            }
        }
    

}
