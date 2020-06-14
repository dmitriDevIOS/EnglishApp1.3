//
//  YourWordsController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 12/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class YourWordsController : UITableViewController {
    
    var yourWords = [Word]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        setupUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    
    
    fileprivate func setupUI() {
        
        title = "Your Words"
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .plain, target: self, action: #selector(handleAddNewWord))
        
    }
    

    @objc fileprivate func handleAddNewWord() {
        print("add new word")
        
        let vc = CreateNewWordController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    //MARK: - Table view methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = yourWords[indexPath.row].word
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        

            let label = UILabel()
            label.text = "Your words list is empty\n\nAdd new words"
            label.numberOfLines = 0
            label.textColor = .black
            label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 26, weight: .light)
            return label
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return yourWords.count == 0 ? 150 : 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
