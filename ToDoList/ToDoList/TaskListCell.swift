//
//  ListCell.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 15.11.2023.
//

import UIKit

class TaskListCell: UITableViewCell {
    
    struct ViewModel {
        let toDo: String
        let data: ListModel
    }
    
    @IBOutlet weak var deleteButtonOutlet: UIButton!
    @IBOutlet weak var ListLabel: UILabel!
    var deletebutton: (() ->Void)?
    
    func configure(list: ViewModel) {
        self.ListLabel.text = list.toDo
    }
    
    @IBAction func deleteButtonClicked(_ sender: Any) {
        deletebutton?()
           
    }
}

extension TaskListCell.ViewModel {
    init(response: ListModel) {
        
        self.init(
            toDo: response.toDo,
            data: response)
        
    }
}
