//
//  user class.swift
//  clickerGame
//
//  Created by Daniel Vega on 3/20/22.
//

import Foundation
import Firebase

public class User {
    var highscores = [Int]()
    var username: String
    
    init(u: String) {
        username = u
    }
}
