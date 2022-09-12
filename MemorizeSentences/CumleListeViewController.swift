//
//  CumleListeViewController.swift
//  MemorizeSentences
//
//  Created by Yusuf Aksu on 12.08.2022.
//

import UIKit

class CumleListeViewController: UIViewController {

    @IBOutlet weak var titleBar: UINavigationItem!
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
        titleBar.title = "Sentences: \(sentencesList.count)"
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
            let stars = sentence.stars!
            if(stars < 5) {
                cell.backgroundColor = UIColor.lightGray
                cell.sentenceTurkishLabel.textColor = UIColor.black
            }
            else if (stars >= 5 && stars < 10 ){
                cell.backgroundColor = UIColor.yellow
                cell.sentenceTurkishLabel.textColor = UIColor.blue
            }
            else if (stars >= 10 && stars < 15 ){
                cell.backgroundColor = UIColor.orange
                cell.sentenceTurkishLabel.textColor = UIColor.white
            }
            else if (stars >= 15 && stars < 20 ){
                cell.backgroundColor = UIColor.systemGreen
                cell.sentenceTurkishLabel.textColor = UIColor.black
            }
            else if (stars >= 20 ){
                cell.backgroundColor = UIColor.purple
                cell.sentenceTurkishLabel.textColor = UIColor.white
            }
            
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
        let sentence = self.sentencesList[indexPath.row]

        let silAction = UIContextualAction(style: .destructive, title: "Delete", handler: {(contextualAction, view, boolValue) in
            
            let alert = UIAlertController(title: "Delete Process", message: "Do you want to delete -> \(sentence.sentence_turkish!)", preferredStyle: .alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel){ action in
                
            }
            let yesAction = UIAlertAction(title: "Yes", style: .destructive){ action in
                Sentencesdao().deleteSentence(sentence_id: sentence.sentence_id!)
                if self.isSearching {
                    self.sentencesList = Sentencesdao().search(sentence_turkish: self.searchText!)
                    self.sentencesList.reverse()
                } else {
                    self.sentencesList = Sentencesdao().getAllSentences()
                    self.sentencesList.reverse()
                }
                
                
                self.cumlelerTableView.reloadData()
            }
            
            alert.addAction(cancelAction)
            alert.addAction(yesAction)
            self.present(alert, animated: false)
            
            
            
         
            
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

