//
//  DictController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 18/05/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit

class DictController : UIViewController, UITextFieldDelegate {
    
    
    var words = [Word]()
    
    
    let backGroundImage : UIImageView = {
        
        var image = UIImageView()
        image.image = UIImage(named: "dictBackground")!
        image.translatesAutoresizingMaskIntoConstraints = false
        
       return image
    }()
    
    
    let activityIndicator : UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .large)
        activity.color = .black
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 30, y: 1500, width: 1, height: 1))
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Search words"
        textField.textAlignment = .center
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .lightGreen
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let searchWordsTableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 30, y: -1500, width: 1, height: 1))
        tableView.backgroundColor = .almostGrey
        tableView.isScrollEnabled = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20
        tableView.rowHeight = UITableView.automaticDimension
        tableView.keyboardDismissMode = .interactive
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    let blurView : UIVisualEffectView = {
       
        let view = UIVisualEffectView()

        return view
    }()
    
    let topicWordsButton : UIButton = {

        
        let button = UIButton(type: .system)
        
        button.backgroundColor = #colorLiteral(red: 1, green: 0.9689550996, blue: 0.2619583011, alpha: 1)
        button.setTitle("Topics", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(handleTopicWordsButtonPressed), for: .touchUpInside)
        
       return button
    }()
    
    let yourWordsButton : UIButton = {
           
           let button = UIButton(type: .system)
           button.backgroundColor = #colorLiteral(red: 1, green: 0.8563192487, blue: 0.1228398755, alpha: 1)
           button.setTitle("Your Words", for: .normal)
           button.tintColor = .black
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.clipsToBounds = true
           button.layer.cornerRadius = 20
           
          return button
       }()
    
    
    let mostUsedWordsButton : UIButton = {
           
           let button = UIButton(type: .system)
           button.backgroundColor = #colorLiteral(red: 1, green: 0.7442196012, blue: 0, alpha: 1)
           button.setTitle("Most used", for: .normal)
           button.tintColor = .black
           button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 42)
           button.translatesAutoresizingMaskIntoConstraints = false
           button.clipsToBounds = true
           button.layer.cornerRadius = 20
           
          return button
       }()
    
    // called when orientation is changed
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        print("Trait collection changed; size classes may be different.")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Horizontal size class: \(traitCollection.horizontalSizeClass.rawValue)")
        print("Vertical size class: \(traitCollection.verticalSizeClass.rawValue)")
        
        self.navigationController?.isNavigationBarHidden = true
        setupUI()
       // hideKeyboardWhenTappedAround()
        listenForKeyBoardEvents()
        
        launchAnimations()
        
        
        searchWordsTableView.delegate = self
        searchWordsTableView.dataSource = self
        
        searchWordsTableView.register(SearchedWordCell.self, forCellReuseIdentifier: "SearchedWordCell")
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    var timer : Timer?
    
    @objc func textFieldDidChange() {
        
        guard let text = searchTextField.text  else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.activityIndicator.startAnimating()
        
            let trimmedString = text.trimmingCharacters(in: .whitespaces)
            
            if  trimmedString == "" {
                 self.activityIndicator.stopAnimating()
                return
            }
            
            NetworkService.shared.fetchSearchedWords(searchWord: trimmedString) { [weak self] (word) in
                guard let self = self else { return }
                if word.word == "wrong word" {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        if self.words.count > 0 {
                            self.searchWordsTableView.scrollToRow(at: IndexPath(row: self.words.count - 1, section: 0), at: .middle, animated: true)
                        }
                        
                    }
                    return
                }
    
                self.words.append(word)
               // print(self.words[0].pronunciation["all"])
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                    UIView.transition(with: self.searchWordsTableView,
                    duration: 0.35,
                    options: [.transitionCrossDissolve , .curveEaseInOut],
                    animations: { self.searchWordsTableView.reloadData() })
                    
                
                     self.searchWordsTableView.scrollToRow(at: IndexPath(row: self.words.count - 1, section: 0), at: .middle, animated: true)
                }
            }
        })
    }
    
    
    @objc private func handleTopicWordsButtonPressed() {
        
       
        let topicWordsController = TopicsWordController()
        topicWordsController.modalPresentationStyle = .automatic
        present(topicWordsController, animated:  true)
  //      navigationController?.pushViewController(topicWordsController, animated: true)
        
    }
    
    
    
    
    
    // MARK: - Listen to keyboard events
    
    private func listenForKeyBoardEvents() {
        searchTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
        
    }
    
    deinit {
        // Stop listen for keyboard events, because you will have a retain cycle
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc private func keyboardWillChange(notification: Notification) {
        
//        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification  {
            
            searchWordsTableView.isScrollEnabled = true
            
          
            
            UIView.animate(withDuration: 0.9 , delay: 0, usingSpringWithDamping: 0.8 , initialSpringVelocity: 0.9, options: [.curveEaseOut] ,animations: {
                self.view.layoutIfNeeded()
                
                self.searchTextField.backgroundColor = .greenBlueSea
                
            }, completion: nil)
            
            
        } else {
            
           
            UIView.animate(withDuration: 0.9 , delay: 0, usingSpringWithDamping: 0.8 , initialSpringVelocity: 0.9, options: [.curveEaseOut] ,animations: {
                self.view.layoutIfNeeded()
               
                self.searchTextField.backgroundColor = .lightGreen
            }, completion: nil)
            
        }

    }

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Setup UI
    
    var leftAnchorWithInset: NSLayoutConstraint?
    var rightAnchorWithInset: NSLayoutConstraint?
    

    private func setupUI() {
  
        view.backgroundColor = .darkGreen
        
        view.addSubview(backGroundImage)
        
        backGroundImage.frame = view.frame
        backGroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backGroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backGroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backGroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        view.addSubview(searchWordsTableView)
        
        searchWordsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        searchWordsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        searchWordsTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        searchWordsTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
    
        
        searchWordsTableView.addSubview(activityIndicator)
        
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: searchWordsTableView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: searchWordsTableView.centerXAnchor ).isActive = true
        
        view.addSubview(searchTextField)
              
              leftAnchorWithInset = searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15)
              leftAnchorWithInset?.isActive = true
              rightAnchorWithInset = searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15)
              rightAnchorWithInset?.isActive = true
              searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
              searchTextField.topAnchor.constraint(equalTo: searchWordsTableView.bottomAnchor, constant:  20).isActive = true
        
        
        view.addSubview(topicWordsButton)
        
        topicWordsButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        topicWordsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        topicWordsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        topicWordsButton.topAnchor.constraint(equalTo: searchWordsTableView.bottomAnchor, constant: 100).isActive = true
        
        view.addSubview(yourWordsButton)
             
             yourWordsButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
             yourWordsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
             yourWordsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
             yourWordsButton.topAnchor.constraint(equalTo: topicWordsButton.bottomAnchor, constant: 20).isActive = true
             
        
        view.addSubview(mostUsedWordsButton)
        
        mostUsedWordsButton.heightAnchor.constraint(equalToConstant: 90).isActive = true
        mostUsedWordsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15).isActive = true
        mostUsedWordsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15).isActive = true
        mostUsedWordsButton.topAnchor.constraint(equalTo: yourWordsButton.bottomAnchor, constant: 20).isActive = true
  
        
        
    }
    
    
    private func launchAnimations() {
        UIView.animate(withDuration: 0.9 , delay: 0, usingSpringWithDamping: 0.8 , initialSpringVelocity: 0.9, options: [.curveEaseOut] ,animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    
}


extension DictController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedWordCell") as! SearchedWordCell
        
        cell.word = words[indexPath.row]
        
        cell.backgroundColor = .almostGrey
        
        let lastRowIndex = tableView.numberOfRows(inSection: 0) - 1
        if indexPath.section == 0 && indexPath.row == lastRowIndex {
            cell.backgroundColor = .lightGreenFocus
        }

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let label = UILabel()
        
        label.text = "Suggested words"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return words.count == 0 ? 300 : 0
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
 
        
        let wordDetailsController = WordDetailsController()
        wordDetailsController.word = words[indexPath.row]
        
        let navVC = CustomNavigationController(rootViewController: wordDetailsController)
        navVC.modalPresentationStyle = .automatic
        present(navVC, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
