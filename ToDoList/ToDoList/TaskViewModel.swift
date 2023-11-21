//
//  ViewModel.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 18.11.2023.
//

import Foundation

class TaskViewModel {
    
    var didFinishLoad: (() -> Void)?
    var didFinishLoadWithError: ((String) -> Void)?
    var list: [TaskListCell.ViewModel] = []
    
    var numberOfInSection: Int {
        return list.count
    }
    
    func getItem(at index: Int) -> TaskListCell.ViewModel {
        return list[index]
    }
    
    func loadList() {
        if let data = UserDefaults.standard.data(forKey: "addToList"),
           let favorites = try? JSONDecoder().decode([ListModel].self, from: data) {
            self.presentList(response: favorites)
        } else {
            self.didFinishLoadWithError?("Favorites can not load")
        }
    }
    
    
    func presentList(response: [ListModel]) {
        let viewModel: [TaskListCell.ViewModel] = response.map { list in
            TaskListCell.ViewModel(response: list)
        }
        self.list = viewModel
        self.didFinishLoad?()
    }

}
