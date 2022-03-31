//
//  user class.swift
//  clickerGame
//
//  Created by Daniel Vega on 3/20/22.
//

import Foundation
import Firebase

public class User: Codable {
    var dateString = "date"
    var highscores = [Int]()
    var username: String
    var top = 0
    var previous: Int
    var isNew = false
    init(u: String) {
        username = u
        previous = top
    }
    
    func findHigh() {
        var i = 0
        while(i < highscores.count) {
            if(highscores[i] > top) {
                top = highscores[i]
            }
            i+=1
        }
        if newHigh() {
            dateConfigure()
        }
    }
    func newHigh() -> Bool {
        if previous != top {
            isNew = true
        }
        else {
            isNew = false
        }
        return isNew
    }
    func dateConfigure() {
        //year
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let yearString = dateFormatter.string(from: date)
        //month
       
        dateFormatter.dateFormat = "LLLL"
        let monthString = dateFormatter.string(from: date)
        //day
       
        dateFormatter.dateFormat = "dd"
        let dayOfTheWeekString = dateFormatter.string(from: date)
        
        //together
        dateString = monthString + " " + dayOfTheWeekString + ", " + yearString
    }
}

public class StaticStuff: Codable {
    static var highScores = [Int]()
    
    static var currentUser = User(u: "fat")
    static var allUsers = [User]()
    static var allUsersData = [Data]()
}
