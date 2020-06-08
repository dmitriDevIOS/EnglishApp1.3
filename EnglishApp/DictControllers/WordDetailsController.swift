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
            
            NetworkService.shared.translateSelectedWord(language: "de", word: word.word!) { (translatedWord) in
                DispatchQueue.main.async {
                    self.germanTranslationLabel.text = "DE: \(translatedWord)"
                }
            }
            
            NetworkService.shared.translateSelectedWord(language: "ru", word: word.word!) { (translatedWord) in
                DispatchQueue.main.async {
                    self.russianTranslationLabel.text = "RU: \(translatedWord)"
                }
            }
            
            NetworkService.shared.translateSelectedWord(language: "pl", word: word.word!) { (translatedWord) in
                DispatchQueue.main.async {
                    self.polishTranslationLabel.text = "PL: \(translatedWord)"
                }
            }
            
            NetworkService.shared.translateSelectedWord(language: "iw", word: word.word!) { (translatedWord) in
                DispatchQueue.main.async {
                    self.hebrewTranslationLabel.text = "IW: \(translatedWord)"
                }
            }
            
            let attributedText = NSMutableAttributedString(string: word.word!, attributes: [.font: UIFont.systemFont(ofSize: 44, weight: .light)])
            
            attributedText.append(NSAttributedString(string: " \(word?.pronunciation["all"] ?? "")", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .ultraLight)]))
            
            
            wordLabel.attributedText = attributedText
        }
    }
    
    
    let germanTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "DE: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let polishTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "PL: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let russianTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "RU: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    let hebrewTranslationLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "IW: "
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .natural
        label.textColor = .black
        return label
        
    }()
    
    
    let wordLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "WORD"
        label.font  = UIFont.systemFont(ofSize: 44, weight: .light)
        label.textAlignment = .center
        label.textColor = .black
        return label
        
    }()
    
    
    
    let wordDetailsTableView : UITableView = {
        
        let tableView = UITableView()
        
        tableView.clipsToBounds = true
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        
        wordDetailsTableView.delegate = self
        wordDetailsTableView.dataSource  = self
        wordDetailsTableView.register(DetailedWordCell.self, forCellReuseIdentifier: "DetailedCell")
        
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    private func setupUI() {
        
        view.setGradientBackground(colorOne: .lightAmber, colorTwo: .darkAmber)
        wordDetailsTableView.setGradientBackground(colorOne: .lightAmber, colorTwo: .darkAmber)
        
        view.addSubview(wordDetailsTableView)
        view.addSubview(wordLabel)
        view.addSubview(germanTranslationLabel)
        view.addSubview(hebrewTranslationLabel)
        view.addSubview(russianTranslationLabel)
        view.addSubview(polishTranslationLabel)
        
        
        
        
        wordDetailsTableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        wordDetailsTableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        wordDetailsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -70).isActive = true
        wordDetailsTableView.topAnchor.constraint(equalTo: wordLabel.bottomAnchor).isActive = true
        
        wordLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        wordLabel.centerXAnchor.constraint(equalTo: wordDetailsTableView.centerXAnchor).isActive = true
        wordLabel.widthAnchor.constraint(equalToConstant: view.bounds.width).isActive  = true
        wordLabel.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        russianTranslationLabel.topAnchor.constraint(equalTo: wordDetailsTableView.bottomAnchor).isActive = true
        russianTranslationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        russianTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        russianTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        germanTranslationLabel.topAnchor.constraint(equalTo: wordDetailsTableView.bottomAnchor).isActive = true
        germanTranslationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        germanTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        germanTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        polishTranslationLabel.topAnchor.constraint(equalTo: russianTranslationLabel.bottomAnchor).isActive = true
        polishTranslationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        polishTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        polishTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        hebrewTranslationLabel.topAnchor.constraint(equalTo: germanTranslationLabel.bottomAnchor).isActive = true
        hebrewTranslationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        hebrewTranslationLabel.widthAnchor.constraint(equalToConstant: view.frame.width / 2).isActive = true
        hebrewTranslationLabel.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return  word?.results.count ?? 0
        return word.results.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailedCell") as! DetailedWordCell
        cell.word = word.results[indexPath.row]
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 20
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 0
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    
}
