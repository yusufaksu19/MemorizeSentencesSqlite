//
//  CumleListeViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class CumleListeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cumlelerTableView: UITableView!
    
    var sentencesList = [Sentence]()
    
    var isSearching = false
    var searchText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cumlelerTableView.delegate = self
        cumlelerTableView.dataSource = self
        
        searchBar.delegate = self
        
        self.searchBar.addDoneButton(title: "Done", target: self, selector: #selector(tapDone(sender:)))
    }
    
    @objc func tapDone(sender: Any) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if self.isSearching {
            sentencesList = Sentencesdao().search(sentence_turkish: self.searchText!)
            sentencesList.reverse()
        } else {
            sentencesList = Sentencesdao().getAllSentences()
            sentencesList.reverse()
        }
        cumlelerTableView.reloadData()

   
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indeks = sender as? Int
        
        if segue.identifier == "toGuncelle" {
            let gidilecekVC = segue.destination as! CumleGuncelleViewController
            
            gidilecekVC.sentence = sentencesList[indeks!]
        }
 
        
        if segue.identifier == "toDetay" {
            let gidilecekVC = segue.destination as! CumleDetayViewController
            
            gidilecekVC.sentence = sentencesList[indeks!]
        }
        
    }
}

extension CumleListeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sentencesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sentence = sentencesList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cumleHucre", for: indexPath) as! CumleHucreTableViewCell
        
        cell.sentenceTurkishLabel.text = sentence.sentence_turkish
        
        if (sentence.is_memorised == 1) {
            cell.backgroundColor = UIColor.green
            cell.sentenceTurkishLabel.textColor = UIColor.black
            
        } else {
            cell.backgroundColor = UIColor.red
            cell.sentenceTurkishLabel.textColor = UIColor.white
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetay", sender: indexPath.row)
    }
    

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let silAction = UIContextualAction(style: .destructive, title: "Delete", handler: {(contextualAction, view, boolValue) in
            
            
            
            let sentence = self.sentencesList[indexPath.row]
            
            Sentencesdao().deleteSentence(sentence_id: sentence.sentence_id!)
            
            if self.isSearching {
                self.sentencesList = Sentencesdao().search(sentence_turkish: self.searchText!)
                self.sentencesList.reverse()
            } else {
                self.sentencesList = Sentencesdao().getAllSentences()
                self.sentencesList.reverse()
            }
            
            
            self.cumlelerTableView.reloadData()
            
        })
        
        let guncelleAction = UIContextualAction(style: .normal, title: "Update", handler: {(contextualAction, view, boolValue) in print("Güncelle tıklandı \(self.sentencesList[indexPath.row])")
            
            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row)
        })
        silAction.backgroundColor = UIColor.black
        guncelleAction.backgroundColor = UIColor.systemOrange
        
        return UISwipeActionsConfiguration(actions: [silAction, guncelleAction])
        
    }
}

extension CumleListeViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("Arama sonuç: \(searchText)")
        
        self.searchText = searchText
        
        if searchText == "" {
            self.isSearching = false
        } else {
            self.isSearching = true
        }
        
        sentencesList = Sentencesdao().search(sentence_turkish: self.searchText!)
        sentencesList.reverse()
        
        cumlelerTableView.reloadData()
        
    }
    
}

extension UISearchBar {
    
    func addDoneButton(title: String, target: Any, selector: Selector) {
        
        let toolBar = UIToolbar(frame: CGRect(x: 0.0,
                                              y: 0.0,
                                              width: UIScreen.main.bounds.size.width,
                                              height: 44.0))//1
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)//2
        let barButton = UIBarButtonItem(title: title, style: .plain, target: target, action: selector)//3
        toolBar.setItems([flexible, barButton], animated: false)//4
        self.inputAccessoryView = toolBar//5
    }
}

//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//        let silAction = UITableViewRowAction(style: .default, title: "Delete", handler: {(action: UITableViewRowAction, indexPath: IndexPath) -> Void in print("Sil Tıklandı\(self.liste[indexPath.row])") })
//
//        let guncelleAction = UITableViewRowAction(style: .normal, title: "Update", handler: {(action: UITableViewRowAction, indexPath: IndexPath) -> Void in print("Güncelle Tıklandı\(self.liste[indexPath.row])")
//
//            self.performSegue(withIdentifier: "toGuncelle", sender: indexPath.row )
//        })
//
//        return [silAction, guncelleAction]
//
//    }
