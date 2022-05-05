//
//  TaskViewModel.swift
//  TaskManager0505
//
//  Created by 张亚飞 on 2022/5/5.
//

import SwiftUI
import CoreData


class TaskViewModel: ObservableObject {
  
    @Published var currentTab: String = "Today"
    
    //new task properties
    @Published var openEditTask: Bool = false
    @Published var taskTitle: String = ""
    @Published var taskColor: String = "Yellow"
    @Published var taskDeadline: Date = Date()
    @Published var taskType: String = "Basic"
    @Published var showDatePicker: Bool = false
    
    func addTask(context: NSManagedObjectContext) -> Bool {
        
        let task = Task(context: context)
        
        task.title = taskTitle
        task.color = taskColor
        task.deadline = taskDeadline
        task.type = taskType
        
        if let _ = try? context.save() {
            
            return true
        }
        
        return false
    }
    
    func resetTaskData() {
        
        taskType = "Basic"
        taskColor = "Yellow"
        openEditTask = false
        taskTitle = ""
        taskDeadline = Date()
    }
}

