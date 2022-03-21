//
//  ViewControllerHomeScreen.swift
//  clickerGame
//
//  Created by Daniel Vega on 3/21/22.
//

import UIKit

class ViewControllerHomeScreen: UIViewController {

    @IBOutlet weak var usernameTextFieldOutlet: UITextField!
    @IBOutlet weak var passwordTextFieldOultet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func loginAction(_ sender: UIButton) {
        if usernameTextFieldOutlet.text != "" {
            StaticStuff.currentUser = User(u: usernameTextFieldOutlet.text!)
        }
        else {
            
        }
    }
    
   
}
