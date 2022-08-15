//
//  CumleGuncelleViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class CumleGuncelleViewController: UIViewController {

    @IBOutlet weak var sentenceEnglish: UITextView!
    @IBOutlet weak var sentenceGerman: UITextView!
    @IBOutlet weak var sentenceGermanV2: UITextView!
    @IBOutlet weak var sentenceTurkish: UITextView!
    
    var sentence:Sentence?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let s = sentence {
            sentenceTurkish.text = s.sentence_turkish
            sentenceEnglish.text = s.sentence_english
            sentenceGerman.text = s.sentence_german
            sentenceGermanV2.text = s.sentence_germanv2
        }
        
        self.sentenceTurkish.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceEnglish.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceGerman.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
        self.sentenceGermanV2.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))

    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    @IBAction func update(_ sender: Any) {
        
        if let s = sentence, let sentenceTurkish = sentenceTurkish.text, let sentenceEnglish = sentenceEnglish.text, let sentenceGerman = sentenceGerman.text, let sentenceGermanV2 = sentenceGermanV2.text {
            
            Sentencesdao().updateSentence(sentence_id: s.sentence_id!, sentence_turkish: sentenceTurkish, sentence_english: sentenceEnglish, sentence_german: sentenceGerman, sentence_germanv2: sentenceGermanV2)
            
        }
        
    }
    
}


