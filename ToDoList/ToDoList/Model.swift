//
//  Model.swift
//  ToDoList
//
//  Created by Mehmet ÖKSÜZ on 15.11.2023.
//

import Foundation

struct ListModel: Codable {
    
    let id: UUID
    let toDo: String
}
