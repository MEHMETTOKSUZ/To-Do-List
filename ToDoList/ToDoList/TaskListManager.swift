//
//  AddListManager.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 15.11.2023.
//

import Foundation

class TaskListManager {
    
    static let shared = TaskListManager()
    private let userDefaults = UserDefaults.standard
    private let listKey = "addToList"
    var list: [ListModel] = []
    
    init() {
        if let data = userDefaults.data(forKey: listKey),
           let favorites = try? JSONDecoder().decode([ListModel].self, from: data) {
            list = favorites
        }
    }
    
    func toggleList(toDo: ListModel) {
           loadFavorites()

           if let index = list.firstIndex(where: { $0.id == toDo.id }) {
               list[index] = toDo
           } else {
               list.append(toDo)
           }
           savedtoDo()
       }
   
    func loadFavorites() {
        if let data = userDefaults.data(forKey: listKey),
           let favorite = try? JSONDecoder().decode([ListModel].self, from: data) {
            self.list = favorite
        }
    }
    
    func removeFavorites(toDo: ListModel) {
        if let index = list.firstIndex(where: {$0.id == toDo.id}) {
            list.remove(at: index)
            savedtoDo()
        }
    }
    
    func savedtoDo() {
        if let encodeData = try? JSONEncoder().encode(list) {
            userDefaults.set(encodeData, forKey: listKey)
        }
    }
}
