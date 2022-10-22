//
//  AddTaskView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: []) var items: FetchedResults<Task>
    @State var taskText = ""
    @State var monster = 1
    @State var exp = 0
    @EnvironmentObject var todoManager : TodoManager
    
    var body: some View {
        HStack {
            TextField("タスクを追加してください",text: $taskText)
            
            Menu("追加") {
                if taskText.isEmpty {
                    Button("タスクを追加してください",action: {})
                } else {
                    Text("難易度を選ぼう")
                        
                    Button("スライム",action: {
                        monster = 1
                        exp = 5
                        self.createTask()
                        self.todoManager.isEditing = false
                    })
                    Button("オーク",action: {
                        monster = 2
                        exp = 10
                        self.createTask()
                        self.todoManager.isEditing = false
                    })
                    Button("ゴーレム",action: {
                        monster = 3
                        exp = 15
                        self.createTask()
                        self.todoManager.isEditing = false
                    })
                    Button("ドラゴン",action: {
                        monster = 4
                        exp = 25
                        self.createTask()
                        self.todoManager.isEditing = false
                    })
                    Button("魔王",action: {
                        monster = 5
                        exp = 35
                        self.createTask()
                        self.todoManager.isEditing = false
                    })
                    
                }
                
            }
            .font(.gameFont(size: 15))
        }
    }
    
    func createTask() {
        let newTask = Task(context:viewContext)
        newTask.task = self.taskText
        newTask.checked = false
        newTask.monster = Int16(monster)
        newTask.timestamp = Date()
        newTask.experience = Int16(exp)
        newTask.data = Int16(items.count)
        
        self.taskText = ""
        
        do {
            try viewContext.save()
        } catch {
            fatalError("セーブに失敗")
        }
    }
}

struct AddTaskView_Previews: PreviewProvider {
    static var previews: some View {
        AddTaskView()
            .environmentObject(TodoManager())
    }
}
