//
//  WordDetailsController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 20/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class WordDetailsController : UIViewController, UITableViewDelegate, UITableViewDataSource {

    var word : Word! {
        didSet{
            wordLabel.text = word.word
        }
    }
    

    let wordLabel : UILabel = {
           let label = UILabel()
           label.translatesAutoresizingMaskIntoConstraints = false
           label.text = "WORD"
           label.font  = UIFont.boldSystemFont(ofSize: 65)
        label.textAlignment = .center
           label.textColor = .black
           return label
            
       }()
    
    
    
    let wordDetailsTableView : UITableView = {
        
        let tableView = UITableView()
        tableView.backgroundColor = .lightGreen
        tableView.separatorColor =  .lightGreenFocus
        tableView.clipsToBounds = true
        
        //tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        wordDetailsTableView.delegate = self
        wordDetailsTableView.dataSource  = self
        wordDetailsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        setupUI()
    }
    
    
    private func setupUI() {
        
         view.backgroundColor = .lightGreenFocus
        
        
        view.addSubview(wordDetailsTableView)
        
        wordDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        wordDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        wordDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        wordDetailsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true

        view.addSubview(wordLabel)
        
        wordLabel.bottomAnchor.constraint(equalTo: wordDetailsTableView.topAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: wordDetailsTableView.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive  = true
        wordLabel.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      // return  word?.results.count ?? 0
        return 20
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "Dima"
        cell?.backgroundColor = .lightGreen
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
