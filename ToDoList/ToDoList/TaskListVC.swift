//
//  ViewController.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 15.11.2023.
//

import UIKit

class TaskListVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    let viewmodel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        viewmodel.didFinishLoad = {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        viewmodel.loadList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewmodel.loadList()
        tableView.reloadData()
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "toAddVC", sender: nil)
    }
    
    func showDeleteConfirmationAlert(for data: ListModel, at indexPath: IndexPath) {
           let alert = UIAlertController(
               title: "Delete Task",
               message: "Are you sure you want to delete this task?",
               preferredStyle: .alert
           )

           let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
               TaskListManager.shared.removeFavorites(toDo: data)
               self?.viewmodel.list.remove(at: indexPath.row)
               self?.tableView.deleteRows(at: [indexPath], with: .fade)
           }

           let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

           alert.addAction(deleteAction)
           alert.addAction(cancelAction)

           present(alert, animated: true, completion: nil)
       }
}

extension TaskListVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.numberOfInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! TaskListCell
        cell.selectionStyle = .none
        let data = viewmodel.getItem(at: indexPath.row)
        cell.configure(list: data)
        
        cell.deletebutton = {
            self.showDeleteConfirmationAlert(for: data.data, at: indexPath)
           }
        
        return cell
    }
}


