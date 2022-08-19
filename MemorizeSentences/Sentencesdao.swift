//
//  Sentencesdao.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import Foundation

class Sentencesdao {
    
    let db:FMDatabase?
    
    init() {
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("sentences.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func getAllSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    
    func search(sentence_turkish:String) -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE sentence_turkish like '%\(sentence_turkish)%'", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }

    func addSentence(sentence_turkish:String, sentence_english:String, sentence_german:String, sentence_germanv2:String, is_memorised:Int = 0, stars:Int = 0){
        
        
        
        db?.open()
        
        do {

            try db!.executeUpdate("INSERT INTO sentences (sentence_turkish, sentence_english, sentence_german, sentence_germanv2, stars, is_memorised) VALUES (?,?,?,?,?,?)", values: [sentence_turkish, sentence_english, sentence_german, sentence_germanv2, stars, is_memorised])

                
        } catch {
            print("olmadı")
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func updateSentence(sentence_id:Int, sentence_turkish:String, sentence_english:String, sentence_german:String, sentence_germanv2:String, is_memorised:Int = 0, stars:Int = 0){
        
        db?.open()
        
        do {

            try db!.executeUpdate("UPDATE sentences SET sentence_turkish = ? , sentence_english = ? , sentence_german = ? , sentence_germanv2 = ?, is_memorised = ?, stars = ? WHERE sentence_id = ?", values: [sentence_turkish, sentence_english, sentence_german, sentence_germanv2, is_memorised, stars, sentence_id])

                
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func deleteSentence(sentence_id:Int){
        
        db?.open()
        
        do {

            try db!.executeUpdate("DELETE FROM sentences WHERE sentence_id = ?", values: [sentence_id])

                
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func getMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 1 AND stars < 5", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    
    func getUnMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 0", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getFiveStarsMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 1 AND stars >= 5 AND stars < 10", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getTenStarsMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 1 AND stars >= 10 AND stars < 15", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getFifteenStarsMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 1 AND stars >= 15 AND stars < 20", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }
    
    func getTwentyStarsMemorisedSentences() -> [Sentence] {
         var liste = [Sentence]()
        
        db?.open()
        
        do {
            let rs = try db!.executeQuery("SELECT * FROM sentences WHERE is_memorised = 1 AND stars >= 20", values: nil)
            
            while rs.next() {
                let sentence = Sentence(sentence_id: Int(rs.string(forColumn:"sentence_id"))!, sentence_turkish: rs.string(forColumn:"sentence_turkish"), sentence_english: rs.string(forColumn:"sentence_english"), sentence_german: rs.string(forColumn:"sentence_german"), sentence_germanv2: rs.string(forColumn:"sentence_germanv2"), is_memorised: Int(rs.string(forColumn: "is_memorised"))!, stars: Int(rs.string(forColumn: "stars"))!)
                
                liste.append(sentence)
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
        
        return liste
    }




    func makeItMemorised(sentence_id:Int){
        
        db?.open()
        
        do {

            try db!.executeUpdate("UPDATE sentences SET is_memorised = 1 WHERE sentence_id = ?", values: [sentence_id])

                
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func makeItBad(sentence_id:Int){
        
        db?.open()
        
        do {

            try db!.executeUpdate("UPDATE sentences SET is_memorised = 0 WHERE sentence_id = ?", values: [sentence_id])
            
            try db!.executeUpdate("UPDATE sentences SET stars = 0 WHERE sentence_id = ?", values: [sentence_id])

                
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func giveAStar(sentence_id:Int){
        
        db?.open()
        
        do {

            try db!.executeUpdate("UPDATE sentences SET stars = stars + 1 WHERE sentence_id = ?", values: [sentence_id])

                
        } catch {
            print(error.localizedDescription)
        }
        
        db?.close()
    }

    
    func Deneme(sentence_id:Int){

        db?.open()

        do {

            try db!.executeUpdate("ALTER TABLE sentences ADD COLUMN stars INTEGER", values: [sentence_id])
            

        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }

    func Deneme2(sentence_id:Int){

        db?.open()

        do {

            try db!.executeUpdate("UPDATE sentences SET stars = 0 WHERE sentence_id < 1000", values: [sentence_id])
            

        } catch {
            print(error.localizedDescription)
        }

        db?.close()
    }




}

