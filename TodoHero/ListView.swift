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
    @State var isPresented = false
    @State var isShowAction = false
    @State var taskIndex :FetchedResults<Task>.Index?
    
    var body: some View {
        NavigationStack {
            List {
                if isPresented {
                    AddTaskView()
                } else {
                    Button(action:{
                        isPresented = true
                    }) {
                        Text("＋")
                            .font(.title)
                    }
                    .onReceive(todoManager.$isEditing) { isPresented in
                        self.isPresented = isPresented
                    }
                }
                
                ForEach(items,id: \.self) { item in
                    
                    Button(action:{

                        if let index = items.firstIndex(of : item) {
                            taskIndex = index
                        }
                        isShowAction = true
                        
                    }) {
                        if item.task?.isEmpty == false {
                            ListRowView(task:item.task! , IsCheck: item.checked, monstar: Int(item.monster))
                        }
                    }
                    
                    .confirmationDialog("確認", isPresented: $isShowAction, titleVisibility: .hidden) {
                        Button("倒した！") {
                            items[taskIndex!].checked = true
                        }
                        Button("まだ倒してない") {
                            isShowAction = false
                        }
                    } message: {
                        Text("タスクを倒しましたか？").bold()
                    }
//
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
