//
//  UnMemorisedSentencesViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 15.08.2022.
//

import UIKit

class UnMemorisedSentencesViewController: UIViewController {
    @IBOutlet weak var sentenceEnglish: UITextView!
    @IBOutlet weak var sentenceGerman: UITextView!
    @IBOutlet weak var sentenceGermanV2: UITextView!
    @IBOutlet weak var sentenceTurkish: UITextView!
    @IBOutlet weak var titleBar: UINavigationItem!
    
    var sentencesList = [Sentence]()
    var sentencesNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sentencesList = Sentencesdao().getUnMemorisedSentences().shuffled()
        
        titleBar.title = "Total: \(sentencesList.count)"
        
        if (sentencesList.isEmpty){
            
            sentenceEnglish.text = ""
            sentenceGerman.text = ""
            sentenceGermanV2.text = ""
            sentenceTurkish.text = ""
            
            
            
        } else {
            
            hideSentences()
            
            
            updateSentences(sentencesNumber: 0)
        }
        
       
        
    }
    
    @IBAction func okayButton(_ sender: Any) {
        
        if(sentencesList.count != 0){
            Sentencesdao().makeItMemorised(sentence_id: sentencesList[sentencesNumber].sentence_id!)
            
            
            
            sentencesList.remove(at: sentencesNumber)

        }
        
        
        if (sentencesList.count == 0){
            sentenceEnglish.text = "no data"
            sentenceGerman.text = "no data"
            sentenceGermanV2.text = "no data"
            sentenceTurkish.text = "no data"
            
            titleBar.title = "Total: \(sentencesList.count)"
            return
        }
        
        if (sentencesNumber != 0 && sentencesNumber == sentencesList.count){
            
            sentencesNumber -= 1
            
            print("geldiiiii")
        }
        
       
        
        updateSentences(sentencesNumber: sentencesNumber)
        
        hideSentences()
        
        titleBar.title = "Total: \(sentencesList.count)"
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if (sentencesNumber < self.sentencesList.count - 1){
            
            hideSentences()
           
            sentencesNumber += 1
            
            
            updateSentences(sentencesNumber: sentencesNumber)
            
        }
        print(sentencesNumber)
        
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        
        
        if (sentencesNumber > 0){
            hideSentences()
            sentencesNumber -= 1
            
            print(sentencesNumber)
            
          
            
            updateSentences(sentencesNumber: sentencesNumber)
            
        }

    }
    
    
    @IBAction func openSentenceButton(_ sender: Any) {
        
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
    
    func makeEditableFalse(){
        sentenceEnglish.text = ""
        sentenceGerman.text = ""
        sentenceGermanV2.text = ""
        sentenceTurkish.text = ""
        
    }
    
    func updateSentences(sentencesNumber:Int){
        sentenceEnglish.text = sentencesList[sentencesNumber].sentence_english
        sentenceGerman.text = sentencesList[sentencesNumber].sentence_german
        sentenceGermanV2.text = sentencesList[sentencesNumber].sentence_germanv2
        sentenceTurkish.text = sentencesList[sentencesNumber].sentence_turkish
    }

    
}


