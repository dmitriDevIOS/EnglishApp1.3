//
//  CreateNewWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 12/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


protocol CreateNewWordControllerDelegate {
    func didAddNewWord(word: WordRealmModel)
}


class CreateNewWordController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    //MARK: - Properties
    
    var isEditingWord = false
    
    var word = WordRealmModel()
    
    var createWordDelegate : CreateNewWordControllerDelegate?
    
    var partOfSpeechArray = ["noun", "verb", "adjective", "adverb", "pronoun",  "conjunction", "proposition", "interjection"]
    var labelWidth: CGFloat = 100
    var labelHeight: CGFloat = 30
    var labelTextSize: CGFloat = 22
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    
    
    //MARK: - UI Views
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.backgroundColor = .white
        view.contentSize = contentViewSize
        view.frame = self.view.bounds
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    lazy  var containerView : UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame.size = contentViewSize
        return view
    }()
    
    // Labels
    lazy  var wordLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Word"
        label.isUserInteractionEnabled = true
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
        
    }()
    
    lazy  var partOfSpeechLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Speech"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var pronunciationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Pronunciation"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    lazy  var definitionLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Definition"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var antonymsLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Antonyms"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var synonymsLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Synonyms"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var examplesLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Examples"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var ruTranslationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Russian"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var deTranslationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "German"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var plTranslationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Polish"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var iwTranslationLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Hebrew"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    lazy  var wordImageLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.text = "Image"
        label.backgroundColor = .lightIndigo
        label.font = UIFont.systemFont(ofSize: labelTextSize, weight: .light)
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    
    
    // TextFields
    
    
    let wordTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "enter the word"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "enter the word", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        textField.addTarget(self, action: #selector(handleWordTextFieldChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(handleWordTextFieldChanged), for: .allEditingEvents)
        return textField
    }()
    
    let pronunciationTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "transcript"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "transcript", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    let definitionTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "word's definition"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "word's definition", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    let antonymsTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "antonyms"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "antonyms", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    let synonymsTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "synonyms"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "synonyms", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    
    let examplesTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "examples"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "examples", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    
    let russianTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "translation"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    
    let germanTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "translation"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    
    let polishTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.textAlignment = .center
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "translation"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    let hebrewTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
        textField.clearButtonMode = .whileEditing
        textField.textAlignment = .center
        textField.placeholder = "translation"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        return textField
    }()
    
    
    let selectImageButton : UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .lightAmber
        button.setTitle("select image", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .light)
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let partOfSpeechPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.backgroundColor = .lightAmber
        picker.clipsToBounds = true
        
        
        picker.layer.cornerRadius = 15
        return picker
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return partOfSpeechArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return partOfSpeechArray[row]
    }
    
    
    lazy var stackViewForLabels = UIStackView(arrangedSubviews: [
        wordLabel,
        partOfSpeechLabel,
        pronunciationLabel,
        definitionLabel,
        antonymsLabel,
        synonymsLabel,
        examplesLabel,
        wordImageLabel,
        ruTranslationLabel,
        deTranslationLabel,
        plTranslationLabel,
        iwTranslationLabel
    ])
    
    lazy var stackViewForTexfields = UIStackView(arrangedSubviews: [
        wordTextField,
        partOfSpeechPicker,
        pronunciationTextField,
        definitionTextField,
        antonymsTextField,
        synonymsTextField,
        examplesTextField,
        selectImageButton,
        russianTextField,
        germanTextField,
        polishTextField,
        hebrewTextField
        
    ])
    
    
    //MARK: --------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if isEditingWord {
            self.wordTextField.text = word.word
            self.pronunciationTextField.text = word.pronunciation
            self.definitionTextField.text = word.definition
            self.antonymsTextField.text = word.antonyms
            self.synonymsTextField.text = word.synontms
            self.examplesTextField.text = word.examples
            self.russianTextField.text = word.russianTranslation
            self.germanTextField.text = word.germanTranslation
            self.polishTextField.text = word.polishTranslation
            self.hebrewTextField.text = word.hebrewTranslation
            guard let index = partOfSpeechArray.firstIndex(of: word.partOfSpeech ?? "") else { return }
        
            
            if let imageData = word.image {
                self.selectImageButton.setBackgroundImage(UIImage(data: imageData), for: .normal)
                self.selectImageButton.setTitle("", for: .normal)
            }
            
            
            self.partOfSpeechPicker.selectRow(index, inComponent: 0, animated: true)
        }
        
        
        wordLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSuggestWordFilling)))
        
        
        partOfSpeechPicker.delegate = self
        partOfSpeechPicker.dataSource = self
        
        setupUI()
        setupLayout()
        
        
    }
    
    //MARK: SETUP UI AND LAYOUT
    
    private func setupLayout() {
        
        
        stackViewForLabels.layoutMargins = .init(top: 0, left: 10, bottom: 10, right: 6)
        stackViewForLabels.isLayoutMarginsRelativeArrangement = true
        stackViewForLabels.axis = .vertical
        stackViewForLabels.spacing = 12
        stackViewForLabels.distribution = .fillEqually
        stackViewForLabels.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewForTexfields.layoutMargins = .init(top: 0, left: 6, bottom: 10, right: 10)
        stackViewForTexfields.isLayoutMarginsRelativeArrangement = true
        stackViewForTexfields.axis = .vertical
        stackViewForTexfields.spacing = 12
        stackViewForTexfields.distribution = .fillEqually
        stackViewForTexfields.translatesAutoresizingMaskIntoConstraints = false
        
 
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(stackViewForLabels)
        containerView.addSubview(stackViewForTexfields)
        
        
        stackViewForLabels.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  20).isActive = true
        stackViewForLabels.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        stackViewForLabels.widthAnchor.constraint(equalToConstant: 165).isActive = true
        stackViewForLabels.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        stackViewForTexfields.topAnchor.constraint(equalTo: containerView.topAnchor, constant:  20).isActive = true
        stackViewForTexfields.leadingAnchor.constraint(equalTo: stackViewForLabels.trailingAnchor).isActive = true
        stackViewForTexfields.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        stackViewForTexfields.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        
        
        
    }
    
    private func setupUI() {
        
        title = "Create New Word"
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSaveNewWord))
    }
    
    //MARK: Target methods
    
    @objc fileprivate func handleSuggestWordFilling() {
        
        self.wordLabel.text = "Word"
        self.wordLabel.backgroundColor = .lightIndigo
        self.wordLabel.textAlignment = .left
        
        
        guard let text = wordTextField.text  else { return }
        let trimmedString = text.trimmingCharacters(in: .whitespaces)
        
        
        NetworkService.shared.translateSelectedWord(language: "de", word: trimmedString) { [weak self] (translatedWord) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.germanTextField.text = "\(translatedWord)"
            }
        }
        
        NetworkService.shared.translateSelectedWord(language: "ru", word: trimmedString) {[weak self] (translatedWord) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.russianTextField.text = "\(translatedWord)"
            }
        }
        
        NetworkService.shared.translateSelectedWord(language: "pl", word: trimmedString) { [weak self] (translatedWord) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.polishTextField.text = "\(translatedWord)"
            }
        }
        
        NetworkService.shared.translateSelectedWord(language: "iw", word: trimmedString) { [weak self] (translatedWord) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.hebrewTextField.text = "\(translatedWord)"
            }
        }

        NetworkService.shared.fetchSearchedWords(searchWord: trimmedString) { (word) in
            
            print(word.word)
            
            if word.word == "wrong word" {
                
                
                DispatchQueue.main.async {
                   
                    self.wordLabel.text = "No Data"
                    Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (_) in
                        self.wordLabel.text = "Word"
                        self.wordLabel.textAlignment = .left
                        self.wordLabel.backgroundColor = .lightIndigo
                    }
                    
                }
                
                return
                
            }
            
            DispatchQueue.main.async {
                self.pronunciationTextField.text = word.pronunciation["all"]
                
                
                var synonyms = String()
                word.results.forEach({ (result) in
                    result.synonyms?.forEach({ (def) in
                        guard let def = def else { return }
                        synonyms.append(def)
                        synonyms.append(" | ")
                    })
                })
                
                
                self.synonymsTextField.text = synonyms
                self.definitionTextField.text = word.results[0].definition
                
                
                var examples = String()
                word.results.forEach({ (result) in
                    result.examples?.forEach({ (def) in
                        guard let def = def else { return }
                        examples.append(def)
                        examples.append(". ")
                    })
                })
                
                
                self.examplesTextField.text = examples
                

                var antonyms = String()
                word.results.forEach({ (result) in
                    result.antonyms?.forEach({ (def) in
                        guard let def = def else { return }
                        antonyms.append(def)
                        antonyms.append(" | ")
                    })
                })
                
                self.antonymsTextField.text = antonyms
                let index = self.partOfSpeechArray.firstIndex(of: word.results[0].partOfSpeech!)
                guard let indexUnwrapped = index else { return  }
                self.partOfSpeechPicker.selectRow(indexUnwrapped, inComponent: 0, animated: true)
                
            }
            
        }
        
    }
    
    
    @objc fileprivate func handleSaveNewWord() {
        
        
        if isEditingWord {
            
            let wordToDelete = word.word
            
            word = WordRealmModel()
            
            word.word = wordTextField.text
            word.partOfSpeech = partOfSpeechArray[partOfSpeechPicker.selectedRow(inComponent: 0)]
            word.pronunciation = pronunciationTextField.text
            word.definition = definitionTextField.text
            word.synontms = synonymsTextField.text
            word.antonyms = antonymsTextField.text
            word.examples = examplesTextField.text
            word.germanTranslation = germanTextField.text
            word.russianTranslation = russianTextField.text
            word.polishTranslation = polishTextField.text
            word.hebrewTranslation = hebrewTextField.text
            
            word.image = selectImageButton.currentBackgroundImage?.pngData()
            
            if StorageManager.shared.deleteWord(word: wordToDelete
                ?? "") {
                StorageManager.shared.saveNewCreatedWord(word: self.word)
                self.createWordDelegate?.didAddNewWord(word: self.word)
                self.word = WordRealmModel()
                self.cleanUI()
                return
            } else {
                print("sdosoadoas")
            }
   
        }
        
        
        if wordTextField.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Error", message: "Cannot save an empty word \nEnter word to save", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated:  true)
            
            print("cannot save an empty word")
        } else {
            print("save new word")
            word = WordRealmModel()
            word.word = wordTextField.text
            word.partOfSpeech = partOfSpeechArray[partOfSpeechPicker.selectedRow(inComponent: 0)]
            word.pronunciation = pronunciationTextField.text
            word.definition = definitionTextField.text
            word.synontms = synonymsTextField.text
            word.antonyms = antonymsTextField.text
            word.examples = examplesTextField.text
            word.germanTranslation = germanTextField.text
            word.russianTranslation = russianTextField.text
            word.polishTranslation = polishTextField.text
            word.hebrewTranslation = hebrewTextField.text
            
            
            
            if let wordImage = selectImageButton.currentBackgroundImage {
                         let imageData = wordImage.pngData()
                         word.image = imageData
                        
                     }
        
            
            let isInLibrary = StorageManager.shared.checkIfWordExists(word: wordTextField.text ?? "")
            
            if !isInLibrary {
                let alert = UIAlertController(title: "Error", message: "You already have this word in your wordlist, want to resave it? ", preferredStyle: .alert)
                let actionNo = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                let actionEdit = UIAlertAction(title: "Re-safe", style: .default) { (_) in
                    
                    if StorageManager.shared.deleteWord(word: self.word.word ?? "") {
                        print("is deleted")
                    }
                    
                    
                    StorageManager.shared.saveNewCreatedWord(word: self.word)
                    self.createWordDelegate?.didAddNewWord(word: self.word)
                    self.word = WordRealmModel()
                    self.cleanUI()
                    
                    
                }
                alert.addAction(actionNo)
                alert.addAction(actionEdit)
                present(alert, animated:  true)
                return
            }
            
            
            StorageManager.shared.saveNewCreatedWord(word: word)
            
            self.createWordDelegate?.didAddNewWord(word: word)
            self.word = WordRealmModel()
            
            cleanUI()
            
        }
    }
    
    @objc fileprivate func handleSelectPhoto() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // allows editing a choosen photo
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.modalPresentationStyle = .overFullScreen
        imagePickerController.modalTransitionStyle = .coverVertical
        present(imagePickerController, animated: true, completion:  nil)
    }
    
    @objc fileprivate func handleWordTextFieldChanged() {
           
           if wordTextField.text == "" {
               self.wordLabel.text = "Word"
               self.wordLabel.backgroundColor = .lightIndigo
               self.wordLabel.textAlignment = .left
               return
           }
           
           Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { (_) in
               
               self.wordLabel.text = "Fill"
               self.wordLabel.backgroundColor = .lightRed
               self.wordLabel.textAlignment = .center
               
           }

       }
    
//MARK: Clean UI for a new word
    
    fileprivate func cleanUI() {
        UIView.transition(with: wordTextField, duration: 1.2, options: [.transitionCrossDissolve], animations: {
            self.wordTextField.text = ""
            self.pronunciationTextField.text = ""
            self.definitionTextField.text = ""
            self.antonymsTextField.text = ""
            self.synonymsTextField.text = ""
            self.examplesTextField.text = ""
            self.russianTextField.text = ""
            self.germanTextField.text = ""
            self.polishTextField.text = ""
            self.hebrewTextField.text = ""
            self.selectImageButton.setBackgroundImage(UIImage(), for: .normal)
            self.selectImageButton.setTitle("Select Image", for: .normal)
            self.partOfSpeechPicker.selectRow(0, inComponent: 0, animated: true)
            
            self.wordTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.pronunciationTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            
            self.definitionTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.antonymsTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.synonymsTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.examplesTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.russianTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.germanTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.polishTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            self.hebrewTextField.attributedPlaceholder = NSAttributedString(string: "SUCCESS", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            
        }) { (_) in
            
            UIView.animate(withDuration: 0.4) {
                self.wordTextField.attributedPlaceholder = NSAttributedString(string: "enter new word", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
                self.pronunciationTextField.attributedPlaceholder = NSAttributedString(string: "transcript", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                
                self.definitionTextField.attributedPlaceholder = NSAttributedString(string: "word's definition", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.antonymsTextField.attributedPlaceholder = NSAttributedString(string: "antonyms", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.synonymsTextField.attributedPlaceholder = NSAttributedString(string: "synonyms", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.examplesTextField.attributedPlaceholder = NSAttributedString(string: "examples", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.russianTextField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.germanTextField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.polishTextField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
                self.hebrewTextField.attributedPlaceholder = NSAttributedString(string: "translation", attributes: [NSAttributedString.Key.foregroundColor: UIColor.greenBlueSea])
            }
            
            
        }
    }
    
    
    
    //MARK: Image Picker method
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
           dismiss(animated: true, completion: nil)
       }
       
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           
           if let editedImage = info[.editedImage] as? UIImage {
            selectImageButton.setBackgroundImage(editedImage, for: .normal)
            selectImageButton.setTitle("", for: .normal)
            selectImageButton.imageView?.contentMode = .scaleAspectFit
           } else if let originalImage = info[.originalImage] as? UIImage {
               selectImageButton.setBackgroundImage(originalImage, for: .normal)
            selectImageButton.setTitle("", for: .normal)
            selectImageButton.imageView?.contentMode = .scaleAspectFit
           }
           
           dismiss(animated: true, completion: nil)
           
       }
    
    
}
