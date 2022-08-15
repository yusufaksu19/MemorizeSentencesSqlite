//
//  MemorisedSentencesViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 15.08.2022.
//

import UIKit

class MemorisedSentencesViewController: UIViewController {
    @IBOutlet weak var sentenceEnglish: UITextView!
    @IBOutlet weak var sentenceGerman: UITextView!
    @IBOutlet weak var sentenceGermanV2: UITextView!
    @IBOutlet weak var sentenceTurkish: UITextView!
    @IBOutlet weak var titleBar: UINavigationItem!
    
    var sentencesList = [Sentence]()
    var sentencesNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sentencesList = Sentencesdao().getMemorisedSentences().shuffled()
        
        titleBar.title = "Total Memorised: \(sentencesList.count)"
        
        if (sentencesList.isEmpty){
            
            sentenceEnglish.text = ""
            sentenceGerman.text = ""
            sentenceGermanV2.text = ""
            sentenceTurkish.text = ""
            
        } else {
            
            hideSentences()
            
            
            sentenceEnglish.text = sentencesList[0].sentence_english
            sentenceGerman.text = sentencesList[0].sentence_german
            sentenceGermanV2.text = sentencesList[0].sentence_germanv2
            sentenceTurkish.text = sentencesList[0].sentence_turkish
        }

        
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if (sentencesNumber < self.sentencesList.count - 1){
            
            hideSentences()
           
            sentencesNumber += 1
            
            
            sentenceEnglish.text = sentencesList[sentencesNumber].sentence_english
            sentenceGerman.text = sentencesList[sentencesNumber].sentence_german
            sentenceGermanV2.text = sentencesList[sentencesNumber].sentence_germanv2
            sentenceTurkish.text = sentencesList[sentencesNumber].sentence_turkish
            
        }

        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        if (sentencesNumber > 0){
            hideSentences()
            sentencesNumber -= 1
            
            print(sentencesNumber)
            
            sentenceEnglish.text = sentencesList[sentencesNumber].sentence_english
            sentenceGerman.text = sentencesList[sentencesNumber].sentence_german
            sentenceGermanV2.text = sentencesList[sentencesNumber].sentence_germanv2
            sentenceTurkish.text = sentencesList[sentencesNumber].sentence_turkish
            
        }
        
    }
    
    @IBAction func badButton(_ sender: Any) {
        
        Sentencesdao().makeItBad(sentence_id: sentencesList[sentencesNumber].sentence_id!)
        
        sentencesList.remove(at: sentencesNumber)
        
        if (sentencesNumber == 0){
            sentencesNumber = -1
        }
        
        titleBar.title = "Total: \(sentencesList.count)"
    }
    
    @IBAction func showSentencesButton(_ sender: Any) {
        showSentences()
    }
    
    func hideSentences(){
        
        sentenceEnglish.isHidden = true
        sentenceGerman.isHidden = true
        sentenceGermanV2.isHidden = true

    }
    
    func showSentences(){
        
        sentenceEnglish.isHidden = false
        sentenceGerman.isHidden = false
        sentenceGermanV2.isHidden = false

    }

    
}
