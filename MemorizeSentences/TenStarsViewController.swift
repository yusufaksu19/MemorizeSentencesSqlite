//
//  TenStarsViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 19.08.2022.
//

import UIKit

class TenStarsViewController: UIViewController {
    @IBOutlet weak var sentenceEnglish: UITextView!
    @IBOutlet weak var sentenceGerman: UITextView!
    @IBOutlet weak var sentenceGermanV2: UITextView!
    @IBOutlet weak var sentenceTurkish: UITextView!
    @IBOutlet weak var titleBar: UINavigationItem!
    
    var sentencesList = [Sentence]()
    var sentencesNumber = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()

        sentencesList = Sentencesdao().getTenStarsMemorisedSentences().shuffled()
        
        if (sentencesList.isEmpty){
            
            sentenceEnglish.text = ""
            sentenceGerman.text = ""
            sentenceGermanV2.text = ""
            sentenceTurkish.text = ""
            titleBar.title = "Veri yok"
            
        } else {
            
            hideSentences()
            
            
            sentenceEnglish.text = sentencesList[0].sentence_english
            sentenceGerman.text = sentencesList[0].sentence_german
            sentenceGermanV2.text = sentencesList[0].sentence_germanv2
            sentenceTurkish.text = sentencesList[0].sentence_turkish
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
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
            
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
            
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
    @IBAction func nextButton(_ sender: Any) {
        
        if (sentencesNumber < self.sentencesList.count - 1){
            
            hideSentences()
           
            sentencesNumber += 1
            
            
            sentenceEnglish.text = sentencesList[sentencesNumber].sentence_english
            sentenceGerman.text = sentencesList[sentencesNumber].sentence_german
            sentenceGermanV2.text = sentencesList[sentencesNumber].sentence_germanv2
            sentenceTurkish.text = sentencesList[sentencesNumber].sentence_turkish
            
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
        }

        
    }
    @IBAction func giveAStar(_ sender: Any) {
        
        Sentencesdao().giveAStar(sentence_id: sentencesList[sentencesNumber].sentence_id!)
        
        sentencesList[sentencesNumber].stars! += 1
        
        titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"

        
    }
    @IBAction func showButton(_ sender: Any) {
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
