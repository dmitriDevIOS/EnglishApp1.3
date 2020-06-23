//
//  MenuViewController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 16/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//


import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = .yellow
        
        
    }

 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.textLabel?.text = "Menu Item: \(indexPath.row)"
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "All topics"
    }
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 130
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Futura", size: 36)
        header.textLabel?.textAlignment = NSTextAlignment.center
        header.tintColor = .orange
        header.detailTextLabel?.text = "choose what to learn next"
        
    }

}
