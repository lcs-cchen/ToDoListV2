//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Cyrus Chen on 3/4/2023.
//
import Blackbird
import SwiftUI

@main
struct ToDoListApp: App {
    var body: some Scene {
        WindowGroup {
            ListView()
                .environment(\.blackbirdDatabase, AppDatabase.instance)
        }
    }
}
