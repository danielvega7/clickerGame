//
//  ViewControllerHomeScreen.swift
//  clickerGame
//
//  Created by Daniel Vega on 3/21/22.
//

import UIKit
import Firebase
class ViewControllerHomeScreen: UIViewController {

    let db = Firestore.firestore()
    
    var ref = Database.database().reference()
    
    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
   
    @IBOutlet weak var loginButtonOutlet: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        machoRead()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "middleBackground")!)
        loginButtonOutlet.backgroundColor = UIColor(red: 0.1255, green: 0.4, blue: 0.9333, alpha: 1)
        loginButtonOutlet.layer.cornerRadius = 25
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        //machoRead()
        
        
        var isName = false
        if usernameTextFieldOutlet.text != "" {
            var check = 0
            var index = -1
            while(check < StaticStuff.allUsers.count){
                if StaticStuff.allUsers[check].username == usernameTextFieldOutlet.text! {
                    isName = true
                    index = check
                }
                check+=1
            }
            if isName {
                StaticStuff.currentUser = StaticStuff.allUsers[index]
                print("current user is \(StaticStuff.currentUser.username)")
                presentController()
                
            }
            else {
                StaticStuff.currentUser = User(u: usernameTextFieldOutlet.text!)
                StaticStuff.allUsers.append(StaticStuff.currentUser)
                do {
                    let encoder = JSONEncoder()
                    
    //                for each in StaticStuff.allUsers {
    //                }
                    let data = try encoder.encode(StaticStuff.currentUser)
                        StaticStuff.allUsersData.append(data)

                    
                   
                    self.writeUserArray()
                }
                catch {
                   print("rip took an L")
                }
                presentController()
            }
            
        }
            
//            StaticStuff.allUsers.append(StaticStuff.currentUser)
        else{
        var please = 0
        while(please < StaticStuff.allUsers.count) {
            print(StaticStuff.allUsers[please].username)
            please+=1
        }
        }
    }
    func presentController() {
        let alertController = UIAlertController(title: "Logged In", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
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
    func writeUserArray() {
       
        db.collection("clicker").document("users").setData(["userArray": StaticStuff.allUsersData], merge: true)

    }
    func machoRead() {
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
