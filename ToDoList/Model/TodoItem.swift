//
//  TodoItem.swift
//  ToDoList
//
//  Created by Cyrus Chen on 3/4/2023.
//

import Blackbird
import Foundation

struct TodoItem: Identifiable {
    var id: Int
    var description: String
    var completed: Bool
}
var existingTodoItems = [
    
    TodoItem(id: 1, description: "study for physics quiz", completed: false)
    ,
    TodoItem(id: 2, description: "Fishih Computer Science Assignment", completed: true)
    ,
    TodoItem(id: 3, description: "Go for a run", completed: false)
    ,
]
