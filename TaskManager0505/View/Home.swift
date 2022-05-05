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
