//
//  ViewModel.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 18.11.2023.
//

import Foundation

class TaskViewModel {
    var didFinishLoad: (() -> Void)?
    var list: [TaskListCell.ViewModel] = []
    private let taskManager = TaskListManager.shared
    
    var numberOfRows: Int {
        return list.count
    }
    
    func getItem(at index: Int) -> TaskListCell.ViewModel? {
        guard index >= 0, index < list.count else {
            return nil
        }
        return list[index]
    }
    
    func loadList() {
        let items = taskManager.get()
        self.list = items.map { TaskListCell.ViewModel(toDo: $0.toDo, data: $0) }
        didFinishLoad?()
    }
    
    func removeItem(at index: Int) {
        guard index >= 0, index < list.count else { return }
        let item = list[index].data
        taskManager.remove(toDo: item)
        list.remove(at: index)
        didFinishLoad?()
    }
}

