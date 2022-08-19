//
//  Sentence.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import Foundation

class Sentence {
    
    var sentence_id:Int?
    var sentence_turkish:String?
    var sentence_english:String?
    var sentence_german:String?
    var sentence_germanv2:String?
    var is_memorised:Int?
    var stars:Int?
    
    
    init() {
        
    }
    
    init(sentence_id:Int, sentence_turkish:String, sentence_english:String, sentence_german:String, sentence_germanv2:String, is_memorised:Int, stars:Int) {
        self.sentence_id = sentence_id
        self.sentence_turkish = sentence_turkish
        self.sentence_english = sentence_english
        self.sentence_german = sentence_german
        self.sentence_germanv2 = sentence_germanv2
        self.is_memorised = is_memorised
        self.stars = stars
        
    }
    
    
}
