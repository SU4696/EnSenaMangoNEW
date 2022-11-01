//
//  DictionaryViewController.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/29.
//

import UIKit
/*
import SwiftUI
struct DictionaryView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        NavigationView {
            List {
                ForEach(Category.allCases) { category in Text(category.rawValue + "s")}
            }
        }
    }
    
}
*/
class DictionaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var nameView: UITableView!
    
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dictionary.dummyDicCategory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = nameView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let target = Dictionary.dummyDicCategory[indexPath.row]
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
        
        NotificationCenter.default.addObserver(forName: DictionaryCompseViewController.newDicDidInsert, object: nil, queue: OperationQueue.main) { [weak self] (noti) in self?.nameView.reloadData()}

        // Do any additional setup after loading the view.
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

