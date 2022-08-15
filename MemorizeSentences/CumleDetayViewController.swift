//
//  CumleDetayViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class CumleDetayViewController: UIViewController {
    @IBOutlet weak var sentenceEnglish: UILabel!
    @IBOutlet weak var sentenceGerman: UILabel!
    @IBOutlet weak var sentenceGermanV2: UILabel!
    @IBOutlet weak var sentenceTurkish: UILabel!
    
    var sentence: Sentence?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let s = sentence {
            sentenceTurkish.text = s.sentence_turkish
            sentenceEnglish.text = s.sentence_english
            sentenceGerman.text = s.sentence_german
            sentenceGermanV2.text = s.sentence_germanv2
        }
    }

}
