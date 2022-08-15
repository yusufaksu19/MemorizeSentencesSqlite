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

    
        
        
    }
    

    @IBAction func add(_ sender: Any) {
        
        if let sentenceTurkish = sentenceTurkish.text, let sentenceEnglish = sentenceEnglish.text, let sentenceGerman = sentenceGerman.text, let sentenceGermanV2 = sentenceGermanV2.text {
            
            Sentencesdao().addSentence(sentence_turkish: sentenceTurkish, sentence_english: sentenceEnglish, sentence_german: sentenceGerman, sentence_germanv2: sentenceGermanV2)
            
        }
        
    }
    
}
