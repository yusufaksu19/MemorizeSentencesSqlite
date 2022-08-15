//
//  CumleEkleViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class CumleEkleViewController: UIViewController {

    @IBOutlet weak var sentenceEnglish: UITextView!
    @IBOutlet weak var sentenceGerman: UITextView!
    @IBOutlet weak var sentenceGermanV2: UITextView!
    @IBOutlet weak var sentenceTurkish: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.sentenceTurkish.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceEnglish.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceGerman.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceGermanV2.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }

    @IBAction func add(_ sender: Any) {
        
        if let sentenceTurkish = sentenceTurkish.text, let sentenceEnglish = sentenceEnglish.text, let sentenceGerman = sentenceGerman.text, let sentenceGermanV2 = sentenceGermanV2.text {
            
            Sentencesdao().addSentence(sentence_turkish: sentenceTurkish, sentence_english: sentenceEnglish, sentence_german: sentenceGerman, sentence_germanv2: sentenceGermanV2)
            
        }
        
    }
    
}

extension UITextView {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}
