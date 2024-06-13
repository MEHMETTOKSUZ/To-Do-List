//
//  DeletedTaskViewController.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 13.06.2024.
//

import UIKit

class DeletedTasksVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private let viewModel = TaskViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
               viewModel.didFinishLoadDeleted = {
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               }
               viewModel.loadDeletedList()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadDeletedList()
        tableView.reloadData()
    }
}

extension DeletedTasksVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfDeletedRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeletedTaskCell", for: indexPath) as? DeletedTaskCell,
              let data = viewModel.getDeletedItem(at: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.itemFromCell(item: data)
        return cell
    }
}

