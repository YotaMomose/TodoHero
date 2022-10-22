//
//  ListView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

struct ListView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.data, ascending: true)],
                  animation: .default) var items: FetchedResults<Task>
    @EnvironmentObject var todoManager : TodoManager
    @State var isPresented = false
    @State var isShowAction = false
    @State var taskIndex :FetchedResults<Task>.Index?
    @State var buttonAction: Bool = true
    @State var isShoeLevelup = false
    @AppStorage("user_level") var userLevel = 1
    @State var isVaidTimer = false
    @AppStorage("bar_exp") var bar = 0
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
                    .disabled(todoManager.isVaidTimer)
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
                .onDelete(perform: deleteItems)
                .onMove(perform: move)
            }
        }
        .fullScreenCover(isPresented: $isShoeLevelup) {
            LevelupView(isPresented: $isShoeLevelup)
        }
    }
        
    func deleteItems(offsets: IndexSet) {
       withAnimation {
           offsets.map { items[$0] }.forEach(viewContext.delete)
           for i in offsets.first! ... items.count - 1 {
               items[i].data -= 1
           }
           
           do {
               try viewContext.save()
           } catch {
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
           }
       }
   }
    
    func move(from source: IndexSet, to destination: Int) {
            //下から上に並べ替え時の挙動
            if source.first! > destination {
                items[source.first!].data = items[destination].data - 1
                for i in destination...items.count - 1 {
                    items[i].data = items[i].data + 1
                }
            }

            //上から下に並べ替え時の挙動
            if source.first! < destination {
                items[source.first!].data = items[destination - 1].data + 1
                for i in 0...destination - 1 {
                    items[i].data = items[i].data - 1
                }
            }
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        for item in items {
            item.data = Int16(items.firstIndex(of: item)!)
        }
        //アンラップ検討
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        print("###")
        for i in items {
            print(i.data)
        }
    }
    

    func getEx() {
        todoManager.getExp = 0
        todoManager.timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            todoManager.isVaidTimer = true
            bar += 1
            todoManager.getExp += 1
            if bar == 100 {
                todoManager.fraction = todoManager.monsterExp - todoManager.getExp
                isShoeLevelup = true
                todoManager.timerHandler?.invalidate()
                todoManager.isVaidTimer = false
                userLevel += 1
            }
            
            if todoManager.getExp == todoManager.monsterExp {
                todoManager.timerHandler?.invalidate()
                todoManager.isVaidTimer = false
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
