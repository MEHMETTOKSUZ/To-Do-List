//
//  DeletedTaskCell.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 13.06.2024.
//

import UIKit

class DeletedTaskCell: UITableViewCell {

    @IBOutlet weak var deletedTaskLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func itemFromCell(item: TaskListCell.ViewModel) {
        self.deletedTaskLabel.text = item.toDo
    }

}
