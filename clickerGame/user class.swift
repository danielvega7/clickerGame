//
//  user class.swift
//  clickerGame
//
//  Created by Daniel Vega on 3/20/22.
//

import Foundation
import Firebase

public class User: Codable {
    var highscores = [Int]()
    var username: String
    var top = 0
    init(u: String) {
        username = u
    }
    func findHigh() {
        var i = 0
        while(i < highscores.count) {
            if(highscores[i] > top) {
                top = highscores[i]
            }
            i+=1
        }
    }
}

public class StaticStuff: Codable {
    static var highScores = [Int]()
    
    static var currentUser = User(u: "fat")
    static var allUsers = [User]()
    static var allUsersData = [Data]()
}
