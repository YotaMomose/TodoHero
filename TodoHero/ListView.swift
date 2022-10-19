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
    @State var buttonAction: Bool = true
    @State var isShoeLevelup = false
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
                        if !item.checked {
                            isShowAction = true
                        }
                        
                        
                    }) {
                        if item.task?.isEmpty == false {
                            ListRowView(task:item.task! , IsCheck: item.checked, monstar: Int(item.monster))
                        }
                    }
                    
                    .confirmationDialog("確認", isPresented: $isShowAction, titleVisibility: .hidden) {
                        Button("倒した！") {
                            items[taskIndex!].checked = true
                            todoManager.monsterExp = CGFloat(Int(items[taskIndex!].experience))
                            getEx()
                            buttonAction = true
                            do {
                                try viewContext.save()
                            } catch {
                                fatalError("セーブに失敗")
                            }
                        }
                        Button("まだ倒してない") {
                            isShowAction = false
                        }
                    } message: {
                        Text("タスクを倒しましたか？").bold()
                    }
                    
                }
                
            }
        }
        .sheet(isPresented: $isShoeLevelup) {
            LevelupView(isPresented: $isShoeLevelup)
        }
    }
        
    
    func getEx() {
        todoManager.getExp = 0
        todoManager.timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            
            todoManager.bar += 1
            todoManager.getExp += 1
            if todoManager.bar == 100 {
                todoManager.fraction = todoManager.monsterExp - todoManager.getExp
                isShoeLevelup = true
                todoManager.timerHandler?.invalidate()
            }
            
            if todoManager.getExp == todoManager.monsterExp {
                todoManager.timerHandler?.invalidate()
            }
        }
    }
    
//    func getFraction() {
//        todoManager.timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
//            if todoManager.fraction == 0 {
//                todoManager.timerHandler?.invalidate()
//                return
//            }
//            todoManager.bar += 1
//            todoManager.fraction -= 1
//        }
//    }
//
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .environmentObject(TodoManager())
    }
}
