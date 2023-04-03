//
//  ListView.swift
//  ToDoList
//
//  Created by Cyrus Chen on 3/4/2023.
//

import SwiftUI

struct ListView: View {
    
    @State var todoItems: [TodoItem] = existingTodoItems
    
    @State var newItemDescription: String = ""
    
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do Item", text: $newItemDescription)
                    
                    Button(action: {
                        //Get last todo item id
                        let lastId = todoItems.last!.id
                        // Create new todo item id
                        let newId = lastId + 1
                        // Create the new todo item
                        let newTodoItem = TodoItem(id: newId,
                                                   description: newItemDescription,
                                                   completed: false)
                        
                        todoItems.append (newTodoItem)
                        
                        newItemDescription = ""
                    },
                           label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding()
                
                List(todoItems){ currentItem in
                    Label(title: {
                        Text (currentItem.description)
                    }, icon: {
                        if currentItem.completed == true {
                            Image (systemName: "checkmark.circle")
                        } else {
                            Image(systemName: "circle")
                            
                        }
                        
                    }
                          
                    )
                    
                }
            }
            .navigationTitle("To Do List")
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListView()
    }
}
