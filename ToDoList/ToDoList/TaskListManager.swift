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
    private let deletedListKey = "deletedList"
    private(set) var list: [ListModel] = []
    private(set) var deletedList: [ListModel] = []
    
    private init() {
        loadList()
        loadDeletedList()
    }
    
    func get() -> [ListModel] {
        return list
    }
    
    func getDeleted() -> [ListModel] {
        return deletedList
    }
    
    func add(toDo: ListModel) {
        if let index = list.firstIndex(where: { $0.id == toDo.id }) {
            list[index] = toDo
        } else {
            list.insert(toDo, at: 0)
        }
        saveList()
    }
    
    func remove(toDo: ListModel) {
        if let index = list.firstIndex(where: { $0.id == toDo.id }) {
           // deletedList.append(list[index])
            deletedList.insert(list[index], at: 0)
            list.remove(at: index)
            saveList()
            saveDeletedList()
        }
    }
    
    private func loadList() {
        if let data = userDefaults.data(forKey: listKey),
           let savedList = try? JSONDecoder().decode([ListModel].self, from: data) {
            list = savedList
        }
    }
    
    private func saveList() {
        if let encodedData = try? JSONEncoder().encode(list) {
            userDefaults.set(encodedData, forKey: listKey)
        }
    }
    
    private func loadDeletedList() {
        if let data = userDefaults.data(forKey: deletedListKey),
           let savedDeletedList = try? JSONDecoder().decode([ListModel].self, from: data) {
            deletedList = savedDeletedList
        }
    }
    
    private func saveDeletedList() {
        if let encodedData = try? JSONEncoder().encode(deletedList) {
            userDefaults.set(encodedData, forKey: deletedListKey)
        }
    }
}


