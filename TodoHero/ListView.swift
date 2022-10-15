//
//  ListView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)],
                  animation: .default) var items: FetchedResults<Task>
    @EnvironmentObject var todoManager : TodoManager
    
    var body: some View {
        NavigationStack {
            List {
                if self.todoManager.isEditing {
                    AddTaskView()
                } else {
                    Button(action:{
                        self.todoManager.isEditing = true
                    }) {
                        Text("＋")
                            .font(.title)
                    }
                    
                }
                
                ForEach(items) { item in
                    Button(action:{
                        item.checked = true
                        //確認画面が出るように修正
                    }) {
                        if item.task?.isEmpty == false {
                            ListRowView(task:item.task! , IsCheck: item.checked, monstar: Int(item.monster))
                        }
                    }
                    
                }
                
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(TodoManager())
    }
}
