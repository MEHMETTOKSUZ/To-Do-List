//
//  AddVC.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 15.11.2023.
//

import UIKit

class AddTaskVC: UIViewController {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var addTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func clickedSaveButton(_ sender: Any) {
        
        guard let text = addTextField.text else {
            return
        }
        
        let newTask = ListModel(id: UUID(), toDo: text)
        TaskListManager.shared.add(toDo: newTask)
        navigationController?.popViewController(animated: true)
    }
}
