//
//  DictonaryDetailViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/31.
//

import UIKit

class DictonaryDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var palView: UITableView!
    var category: String = ""
    var elements = [DictionaryDetail(name: "")]
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 132
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //obtener los elementos de la misma categoria
            //TODO: Incializar de manera correcta la varaible elments
            let dictCount = DictionaryDetail.dummyPalCategory
            elements = [DictionaryDetail(name: "")]
            for item in dictCount {
                if (item.category == category)
                {
                    elements.append(item)
                }
            }
            //TODO: Una vez inicializado de manera correcta se cambia return por return elements.count
            return elements.count - 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //TODO: Una vez inicializado de manera correcta se cambia elements por elements[indexPath.row]
            let target = elements[indexPath.row + 1]
            let cell = palView.dequeueReusableCell(withIdentifier: "dicCell", for: indexPath)
            cell.textLabel?.text = target.name
            return cell
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            //nameView.reloadData()
            
           // print(#function)
        }
        var token: NSObjectProtocol?
        deinit {
            if let token = token {
                NotificationCenter.default.removeObserver(token)
                
            }
        }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            NotificationCenter.default.addObserver(forName: DicDetailCompseViewController.newPalDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.palView.reloadData()}
        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
/*
extension DictonaryDetailViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dicCell", for: indexPath)
            return cell
        default:
            fatalError()
        }
        
    }
    
    
    
}
*/
