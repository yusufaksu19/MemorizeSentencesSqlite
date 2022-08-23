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
        

        
        if (sentencesList.isEmpty){
            
            sentenceEnglish.text = ""
            sentenceGerman.text = ""
            sentenceGermanV2.text = ""
            sentenceTurkish.text = ""
            titleBar.title = "Veri yok"
            
        } else {
            
            hideSentences()
            
            
            updateSentences(sentencesNumber: 0)
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
        }

        
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if (sentencesNumber < self.sentencesList.count - 1){
            
            hideSentences()
           
            sentencesNumber += 1
            
            
            updateSentences(sentencesNumber: sentencesNumber)
            
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
        }

        
    }
    
    @IBAction func backButton(_ sender: Any) {
        
        if (sentencesNumber > 0){
            hideSentences()
            sentencesNumber -= 1
            
            print(sentencesNumber)
            
            updateSentences(sentencesNumber: sentencesNumber)
            
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
            
        }
        
    }
    
    @IBAction func badButton(_ sender: Any) {
        if(sentencesList.count != 0){
        Sentencesdao().makeItBad(sentence_id: sentencesList[sentencesNumber].sentence_id!)
        
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
        
        titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"

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

    @IBAction func giveAStar(_ sender: Any) {
       
        if (sentencesList.count != 0) {
            Sentencesdao().giveAStar(sentence_id: sentencesList[sentencesNumber].sentence_id!)
            
            sentencesList[sentencesNumber].stars! += 1
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"
            starUpdate(starCount: 4)
        }
        
        
    }
    
    func updateSentences(sentencesNumber:Int){
        sentenceEnglish.text = sentencesList[sentencesNumber].sentence_english
        sentenceGerman.text = sentencesList[sentencesNumber].sentence_german
        sentenceGermanV2.text = sentencesList[sentencesNumber].sentence_germanv2
        sentenceTurkish.text = sentencesList[sentencesNumber].sentence_turkish
    }
    
    func starUpdate(starCount:Int){
        if (sentencesList[sentencesNumber].stars! > starCount) {
            sentencesList.remove(at: sentencesNumber)
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
            
            titleBar.title = "Total Memorised: \(sentencesList.count) --> \(sentencesList[sentencesNumber].stars!)"

        }
    }

    
}
