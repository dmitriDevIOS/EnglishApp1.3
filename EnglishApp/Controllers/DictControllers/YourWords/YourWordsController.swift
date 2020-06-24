//
//  YourWordsController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 12/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit
import RealmSwift



class YourWordsController : UITableViewController, UISearchBarDelegate {
    
    //MARK: Properties
    
    var yourWords = [WordRealmModel]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //MARK: ----------
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        yourWords = StorageManager.shared.fetchYourWords()
        tableView.reloadData()

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yourWords = StorageManager.shared.fetchYourWords()
        setupSearchBar()
        setupUI()
        navigationItem.searchController = searchController
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
    }
    
    
    //MARK: Search bar methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (_) in
            
            let inputString = searchText.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            if inputString.count > 0
            {
                let filteredArray = StorageManager.shared.searchForAWord(word: "\(searchText)")
                self.yourWords = filteredArray
                self.tableView.reloadData()
            }
            else
            {
                self.yourWords = StorageManager.shared.fetchYourWords()
                self.tableView.reloadData()
            }
        })
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.yourWords = StorageManager.shared.fetchYourWords()
        self.tableView.reloadData()
    }
    
    fileprivate func setupSearchBar() {
        
        self.definesPresentationContext = true // allows us to go back and puts leftbarItem title (search in our case)
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    //MARK: Setup UI Layout
    
    fileprivate func setupUI() {

        title = "Your Words"
        view.backgroundColor = .white
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.prefersLargeTitles = false

        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "plus.square"), style: .plain, target: self, action: #selector(handleAddNewWord)), UIBarButtonItem(image: UIImage(systemName: "trash"), style: .plain, target: self, action: #selector(handleDeleteAllWords)) ]
        
    }
    
    //MARK: Target methods
    
    @objc fileprivate func handleAddNewWord() {

        let vc = CreateNewWordController()
        vc.createWordDelegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc fileprivate func handleDeleteAllWords() {
        
        let alert = UIAlertController(title: "Delete all word?", message: "Are you sure that you want to remove all your words library?", preferredStyle: .alert)
        let actionNO = UIAlertAction(title: "No", style: .default, handler: nil)
        let actionDelete = UIAlertAction(title: "Delete", style: .destructive) { (_) in
            StorageManager.shared.deleteAllYourWords()
            self.yourWords = StorageManager.shared.fetchYourWords()
            self.tableView.reloadData()
            
        }
        alert.addAction(actionNO)
        alert.addAction(actionDelete)
        present(alert, animated:  true)
        
    }
    
    
    //MARK: - Table view methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yourWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = yourWords[indexPath.row].word
        cell.backgroundColor = .lightOrange
        return cell
        
        
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
         
         let word = yourWords[indexPath.row]
         
         // DELETE ACTION
         
         let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { (action, view, bool) in
             
             // remove company from table view
             self.yourWords.remove(at: indexPath.row) // сначала удаляем с массива, иначе будет ошибка
             self.tableView.deleteRows(at: [indexPath], with: .automatic)
             // delete the company from coreData
             
            if StorageManager.shared.deleteWord(word: word.word ?? "") {
                print("saved")
            }
             
         }
         deleteAction.backgroundColor = .red
         
         
         // EDIT ACTION
         let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, bool) in

             let editCompanyController = CreateNewWordController()
            editCompanyController.word = word
            editCompanyController.isEditingWord = true 
            self.navigationController?.pushViewController(editCompanyController, animated: true)

         }
         editAction.backgroundColor = .blueSea

         let swipeActions = UISwipeActionsConfiguration(actions: [deleteAction, editAction])
         swipeActions.performsFirstActionWithFullSwipe = false
         return swipeActions
     }
    
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = SelectedWordController()
        vc.word = yourWords[indexPath.row]

        navigationController?.pushViewController(vc, animated: true)
        
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


extension YourWordsController : CreateNewWordControllerDelegate {
    func didAddNewWord(word: WordRealmModel) {
        yourWords.append(word)
        let newIndexPath = IndexPath(row: yourWords.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .fade)
        
    }
}
