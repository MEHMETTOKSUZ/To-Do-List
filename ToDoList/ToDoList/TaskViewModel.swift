//
//  ViewModel.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 18.11.2023.
//

import Foundation

class TaskViewModel {
    var didFinishLoad: (() -> Void)?
    var didFinishLoadDeleted: (() -> Void)?
    
    private(set) var list: [TaskListCell.ViewModel] = []
    private(set) var deletedList: [TaskListCell.ViewModel] = []
    
    private let taskManager = TaskListManager.shared
    
    var numberOfRows: Int {
        return list.count
    }
    
    var numberOfDeletedRows: Int {
        return deletedList.count
    }
    
    func getItem(at index: Int) -> TaskListCell.ViewModel? {
        guard index >= 0, index < list.count else {
            return nil
        }
        return list[index]
    }
    
    func getDeletedItem(at index: Int) -> TaskListCell.ViewModel? {
        guard index >= 0, index < deletedList.count else {
            return nil
        }
        return deletedList[index]
    }
    
    func loadList() {
        let items = taskManager.get()
        self.list = items.map { TaskListCell.ViewModel(toDo: $0.toDo, data: $0) }
        didFinishLoad?()
    }
    
    func loadDeletedList() {
        let items = taskManager.getDeleted()
        self.deletedList = items.map { TaskListCell.ViewModel(toDo: $0.toDo, data: $0) }
        didFinishLoadDeleted?()
    }
    
    func removeItem(at index: Int) {
        guard index >= 0, index < list.count else { return }
        let item = list[index].data
        taskManager.remove(toDo: item)
        list.remove(at: index)
        didFinishLoad?()
    }
}



