//
//  ListView.swift
//  ToDoList
//
//  Created by Cyrus Chen on 3/4/2023.
//
import Blackbird
import SwiftUI

struct ListView: View {
    
    @Environment(\.blackbirdDatabase) var db:
    Blackbird.Database?
    
    
    @BlackbirdLiveModels({ db in
        try await TodoItem.read(from: db)
        
    })var todoItems
    
    @State var newItemDescription: String = ""
    
    // MARK: Computed Propreties
    var body: some View {
        
        NavigationView{
            
            VStack {
                
                HStack {
                    
                    TextField("Enter a to-do Item", text: $newItemDescription)
                    
                    Button(action: {
//                        //Get last todo item id
//                        let lastId = todoItems.last!.id
//                        // Create new todo item id
//                        let newId = lastId + 1
//                        // Create the new todo item
//                        let newTodoItem = TodoItem(id: newId,
//                                                   description: newItemDescription,
//                                                   completed: false)
//
//                        todoItems.append (newTodoItem)
//
//                        newItemDescription = ""
                        Task{
                            try await db!.transaction{ core in
                                try core.query("INSERT INTO TodoItem (description) VALUES (?)", newItemDescription)
                            }}
                    },  label: {
                        Text("ADD")
                            .font(.caption)
                    })
                    
                }
                .padding()
                List{
                    ForEach(todoItems.results){ currentItem in
                        Label(title: {
                            Text (currentItem.description)
                        }, icon: {
                            if currentItem.completed == true {
                                Image (systemName: "checkmark.circle")
                            } else {
                                Image(systemName: "circle")
                            }
                        })
                        .onTapGesture {
                            Task{
                                try await db!.transaction{ core in
                                    try core.query("UPDATE TodoItem SET completed = (?) WHERE ID = (?)",
                                                   !currentItem.completed,currentItem.id)
                                }
                            }
                        }
                    }
                    .onDelete(perform: removeRows)
                }
            }
            .navigationTitle("To Do List")
        }
    }
    
    // MARK: Functions
    func removeRows(at offsets: IndexSet){
        
        Task{
            try await db!.transaction{ core in
                var idlist = ""
                for offset in offsets{
                    idlist += "\(todoItems.results[offset].id),"
                }
                print(idlist)
                idlist.removeLast()
                print(idlist)
                
                try core.query("DELETE FROM TodoItem Where id IN (?)",idlist)
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        
        ListView()
    }
}
