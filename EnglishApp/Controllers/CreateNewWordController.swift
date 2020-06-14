//
//  CreateNewWordController.swift
//  EnglishApp
//
//  Created by Dmitrii Timofeev on 12/06/2020.
//  Copyright © 2020 Dmitrii Timofeev. All rights reserved.
//

import UIKit


class PaddingLabel: UILabel {
    
     var topInset: CGFloat = 0
     var bottomInset: CGFloat = 0
     var leftInset: CGFloat = 8.0
     var rightInset: CGFloat = 5.0
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets.init(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
}



class CreateNewWordController : UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    

    
    
    //MARK: - Properties
    
    var partOfSpeechArray = ["Noun", "Verb", "Adjective", "Adverb", "Pronoun",  "Conjunction", "Proposition", "Interjection"]
    var labelWidth: CGFloat = 100
    var labelHeight: CGFloat = 30
    var labelTextSize: CGFloat = 22
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height)
    
    
    
    //MARK: - Views
    
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
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "enter the word"
        textField.textAlignment = .left
        textField.layer.cornerRadius = 15
        textField.clipsToBounds = true
        textField.attributedPlaceholder = NSAttributedString(string: "enter the word", attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkIndigo])
        textField.backgroundColor = .lightAmber
        textField.textColor = .black
        textField.addTarget(self, action: #selector(handleWordTextFieldChanged), for: .touchUpInside)
        return textField
    }()
    
    let pronunciationTextField: CustomTextField = {
        let textField = CustomTextField(padding: 12)
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
        picker.tintColor = .darkIndigo
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        partOfSpeechPicker.delegate = self
        partOfSpeechPicker.dataSource = self
        
        setupUI()
        setupLayout()
        
        
    }
    
    
    private func setupLayout() {
        
        let stackViewForLabels = UIStackView(arrangedSubviews: [
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
        
        let stackViewForTexfields = UIStackView(arrangedSubviews: [
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
        
        stackViewForLabels.layoutMargins = .init(top: 0, left: 10, bottom: 100, right: 6)
        stackViewForLabels.isLayoutMarginsRelativeArrangement = true
        stackViewForLabels.axis = .vertical
        stackViewForLabels.spacing = 12
        stackViewForLabels.distribution = .fillEqually
        stackViewForLabels.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewForTexfields.layoutMargins = .init(top: 0, left: 6, bottom: 100, right: 10)
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
    
    
    @objc fileprivate func handleSaveNewWord() {
       
        if wordTextField.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Error", message: "Cannot save an empty word \nEnter word to save", preferredStyle: .alert)
            let actionOK = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(actionOK)
            present(alert, animated:  true)
            
             print("cannot save an empty word")
        } else {
             print("save new word")
        }
        
    }
    
    @objc fileprivate func handleSelectPhoto() {
        print("select photo")
    }
    
    @objc fileprivate func handleWordTextFieldChanged() {
   
    }
    
    
}
