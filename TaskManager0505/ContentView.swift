//
//  ContentView.swift
//  TaskManager0505
//
//  Created by 张亚飞 on 2022/5/5.
//

import SwiftUI
import CoreData

struct ContentView: View {
 

    var body: some View {
        NavigationView {
           
            Home()
                .navigationTitle("Task Manager")
                .navigationBarTitleDisplayMode(.inline)
        }
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
