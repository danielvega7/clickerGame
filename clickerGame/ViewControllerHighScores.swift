//
//  ViewControllerHighScores.swift
//  clickerGame
//
//  Created by DANIEL VEGA on 3/16/22.
//

import UIKit

class ViewControllerHighScores: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableViewOutlet: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticStuff.highScores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell")!
        cell.textLabel?.text = "User"
        cell.detailTextLabel?.text = String(StaticStuff.highScores[indexPath.row])
        
        return cell
    }
    

}
