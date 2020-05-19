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
        textField.layer.borderWidth = 1.5
        textField.attributedPlaceholder = NSAttributedString(string: "Search...", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        textField.backgroundColor = .clear
        textField.textColor = .black
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    let searchWordsTableView : UITableView = {
        
        let tableView = UITableView(frame: CGRect(x: 30, y: -1500, width: 1, height: 1))
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 20
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        hideKeyboardWhenTappedAround()
        listenForKeyBoardEvents()
        
        launchAnimations()
        
        
        searchWordsTableView.delegate = self
        searchWordsTableView.dataSource = self
        
        searchWordsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    
    var timer : Timer?
    
    @objc func textFieldDidChange() {
        
        guard let text = searchTextField.text  else { return }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            
            self.activityIndicator.startAnimating()
        
            NetworkService.shared.fetchSearchedWords(searchWord: text) { (word) in
                
                if word.word == "wrong word" {
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        if self.words.count > 0 {
                             self.searchWordsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                        }
                        
                    }
                    return
                }
    
                self.words.insert(word, at: 0)
                //  print(self.words[0].results)
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.searchWordsTableView.reloadData()
                    self.searchWordsTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            }
        })
    }
    
    
    // MARK: - Listen to keyboard events
    
    private func listenForKeyBoardEvents() {
        searchTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification , object: nil)
        
    }
    
    deinit {
        // Stop listen for keyboard events
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    
    @objc private func keyboardWillChange(notification: Notification) {
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification {
            
            view.frame.origin.y  = -keyboardRect.height + 150
            
            searchWordsTableView.isScrollEnabled = true
            
            leftAnchorWithoutInset = searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant:  -2)
            rightAnchorWithoutInset = searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 2)
            leftAnchorWithInset?.isActive = false
            rightAnchorWithInset?.isActive = false
            leftAnchorWithoutInset?.isActive = true
            rightAnchorWithoutInset?.isActive = true
            
            UIView.animate(withDuration: 0.9 , delay: 0, usingSpringWithDamping: 0.8 , initialSpringVelocity: 0.9, options: [.curveEaseOut] ,animations: {
                self.view.layoutIfNeeded()
                self.searchTextField.layer.cornerRadius = 0
                self.searchTextField.layer.borderWidth = 0.5
                self.searchWordsTableView.backgroundColor = .red
                self.searchTextField.backgroundColor = .systemPink
            }, completion: nil)
            
            
        } else {
            
            view.frame.origin.y = 0

            UIView.animate(withDuration: 0.9 , delay: 0, usingSpringWithDamping: 0.8 , initialSpringVelocity: 0.9, options: [.curveEaseOut] ,animations: {
                self.view.layoutIfNeeded()
                self.searchWordsTableView.backgroundColor = .white
                self.searchTextField.layer.borderWidth = 1.5
                self.searchTextField.backgroundColor = .clear
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
    
    var leftAnchorWithoutInset: NSLayoutConstraint?
    var rightAnchorWithoutInset: NSLayoutConstraint?
    
    private func setupUI() {
        
        view.backgroundColor = .lightGray
        
        view.addSubview(searchTextField)
        
        leftAnchorWithInset = searchTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30)
        leftAnchorWithInset?.isActive = true
        rightAnchorWithInset = searchTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -30)
        rightAnchorWithInset?.isActive = true
        searchTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant:  -150).isActive = true
        
        view.addSubview(searchWordsTableView)
        
        searchWordsTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15).isActive = true
        searchWordsTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        searchWordsTableView.bottomAnchor.constraint(equalTo: searchTextField.topAnchor, constant: -15).isActive = true
        searchWordsTableView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        
        searchWordsTableView.addSubview(activityIndicator)
        
        activityIndicator.heightAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.widthAnchor.constraint(equalToConstant: 50).isActive = true
        activityIndicator.topAnchor.constraint(equalTo: searchWordsTableView.topAnchor, constant: 5).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: searchWordsTableView.centerXAnchor ).isActive = true
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = words[indexPath.row].word
        
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
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
    
    
}
