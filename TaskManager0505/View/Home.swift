//
//  Home.swift
//  TaskManager0505
//
//  Created by 张亚飞 on 2022/5/5.
//

import SwiftUI

struct Home: View {
    
    @StateObject var taskModel: TaskViewModel = .init()
    
    @Namespace var animation
    
    // fetching task
    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)], predicate: nil, animation: .easeInOut) var tasks: FetchedResults<Task>
    
    @Environment(\.self) var env
    
    var body: some View {
       
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack {
                
                VStack(alignment: .leading, spacing: 8) {
                    
                    Text("Welcome Back")
                        .font(.callout)
                    Text("Here's Update Today.")
                        .font(.title2.bold())
                }
                .frame(maxWidth:.infinity, alignment: .leading)
                .padding(.vertical)
                
                CustomSegumentedBar()
                    .padding(.top, 5)
            }
            .padding()
            
            TaskView()
        }
        .overlay(alignment: .bottom) {
            
            
            Button {
                
                taskModel.openEditTask.toggle()
                
            } label: {
                
                Label {
                    
                    Text("Add Task")
                        .font(.callout)
                        .fontWeight(.semibold)
                } icon: {
                
                    Image(systemName: "plus.app.fill")
                }
                .foregroundColor(.white)
                .padding(.vertical, 12)
                .padding(.horizontal)
                .background(.black, in: Capsule())
                .background {
                    
                    LinearGradient(colors: [
                        .white.opacity(0.05),
                        .white.opacity(0.4),
                        .white.opacity(0.7),
                    ], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                }

            }

        }
        .fullScreenCover(isPresented: $taskModel.openEditTask, onDismiss: {
            
            taskModel.resetTaskData()
        }, content: {
            AddNewTask().environmentObject(taskModel)
        })
    }
    
    @ViewBuilder
    func TaskView() -> some View {
        
        LazyVStack(spacing: 20) {
            
            ForEach(tasks) { task in
                
                TaskRowView(task: task)
            }
            .padding()
        }
//        .padding(.top, 20)
    }
    
    @ViewBuilder
    func TaskRowView(task: Task) -> some View{
        
        VStack(alignment: .leading, spacing: 10) {
            
            HStack{
                
                Text(task.type ?? "")
                    .font(.callout)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    .background {
                        
                        Capsule()
                            .fill(.white.opacity(0.3))
                    }
                
                Spacer()
                
                if !task.isCompleted {
                    
                    Button {
                        
                        taskModel.editTask = task
                        taskModel.openEditTask = true
                        taskModel.setupTask()
                    } label: {
                        
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                    }
                }
            }
            
            Text(task.title ?? "")
                .font(.title2.bold())
                .padding(.vertical, 10)
                .foregroundColor(.black)
            
            HStack(alignment: .bottom, spacing: 0) {
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    Label {
                        
                        Text((task.deadline ?? Date()).formatted(date: .long, time: .omitted))
                    } icon: {
                        
                        Image(systemName: "calendar")
                    }
                    .font(.caption)
                    
                    Label {
                        
                        Text((task.deadline ?? Date()).formatted(date: .omitted, time: .shortened))
                    } icon: {
                        
                        Image(systemName: "clock")
                    }
                    .font(.caption)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                if !task.isCompleted {
                    
                    Button {
                        
                        task.isCompleted.toggle()
                        try? env.managedObjectContext.save()
                    } label: {
                        
                        Circle()
                            .strokeBorder(.black, lineWidth: 1.5)
                            .frame(width: 25, height: 25)
                            .contentShape(Circle())
                    }
                }
            }
                
        }
        .padding()
        .frame(maxWidth:.infinity)
        .background {
            
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(Color(task.color ?? "Yellow"))
        }
    }
    
    
    @ViewBuilder
    func CustomSegumentedBar() -> some View {
        
        let tabs = ["Today", "Upcoming", "Task Done"]
        HStack(spacing: 10) {
            
            ForEach(tabs, id: \.self) { tab in
                
                Text(tab)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .scaleEffect(0.9)
                    .foregroundColor(taskModel.currentTab == tab ? .white : .black)
                    .padding(.vertical, 6)
                    .frame(maxWidth: .infinity)
                    .background {
                        
                        if taskModel.currentTab == tab {
                            
                            Capsule()
                                .fill(.black)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Capsule())
                    .onTapGesture {
                        
                        withAnimation {
                            taskModel.currentTab = tab
                        }
                    }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
