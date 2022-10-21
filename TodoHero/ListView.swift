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
                .onDelete(perform: deleteItems)
                .onMove(perform: move)
            }
        }
        .sheet(isPresented: $isShoeLevelup) {
            LevelupView(isPresented: $isShoeLevelup)
        }
    }
        
    func deleteItems(offsets: IndexSet) {
       withAnimation {
           offsets.map { items[$0] }.forEach(viewContext.delete)
           
           
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
                var destinationData = items[destination].task
                var agent = items[0].task
                print(source.first!)
                print(destination)
                items[destination].task = items[source.first!].task
                for i in destination + 1...source.first! {
                    
                   // if  {
                        agent = items[1].task
                        items[i].task = destinationData
                        destinationData = agent
                    }
//                    } else {
//                        items[i].task = items[i-1].task
//                    }
//                    if i < source.first! {
//                        items[i].task = items[i-1].task
//                    } else {
////                        items[i].task = destinationData
//                    }
                    
                }
            

            //上から下に並べ替え時の挙動
            if source.first! < destination {
                items[source.first!].id = items[destination - 1].id
                for i in 0...destination - 1 {
                    items[i].id = items[i-1].id
                }
            }
         do {
             try viewContext.save()
         } catch {
             fatalError("セーブに失敗")
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
    
////    func move(sourceIndexSet: IndexSet, destination: Int) {
//        guard let source = sourceIndexSet.first else {
//          return
//        }
//
//        // 並び替える行のIDを取得
//        let moveId = items[source].id
//
//        // source、destinationの値については、参考資料を参考にしてください。
//        // Listの行を下に移動する場合
//        if source < destination {
//          for i in (source + 1)...(destination - 1) {
//            update(id: items[i].id, order: items[i].order - 1)
//          }
//          update(id: moveId, order: destination - 1)
//
//        // Listの行を上に移動する場合
//        } else if destination < source {
//          // reversed()で逆から回さないと、一時的にorderの数値が重なり、想定外の挙動を示します。
//          for i in (destination...(source - 1)).reversed() {
//            update(id: items[i].id, order: items[i].order + 1)
//          }
//          update(id: moveId, order: destination)
//
//        } else {
//          return
//        }
//      }
    
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
