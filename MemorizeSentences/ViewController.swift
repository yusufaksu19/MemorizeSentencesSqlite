//
//  ViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        veritabaniKopyala()

    }
    
    func veritabaniKopyala(){
        
        let bundleYolu = Bundle.main.path(forResource: "sentences", ofType: ".sqlite")
        
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        
        let fileManager = FileManager.default
        
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("sentences.sqlite")
        
        if fileManager.fileExists(atPath: kopyalanacakYer.path) {
            print("Veritabanı zaten var.Kopyalamaya gerek yok")
        }else{
            do {
                
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
                
            }catch{
                print(error)
            }
        }
    }



}

