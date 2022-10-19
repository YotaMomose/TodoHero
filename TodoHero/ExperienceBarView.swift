//
//  ExperienceBarView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/19.
//

import SwiftUI

struct ExperienceBarView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.timestamp, ascending: true)],
                  animation: .default) var items: FetchedResults<Task>
    @EnvironmentObject var todoManager: TodoManager
    
    var body: some View {
        VStack {
            ZStack {
                Capsule().stroke(.gray)
                Capsule()
                    .foregroundColor(.green)
                    .scaleEffect(x:(todoManager.bar/100),y: 1.0,anchor: .leading)
            }
            .frame(width: 200,height: 20)
            
//            Button(action:{
//                getExp = 0
//                getEx()
//            }) {
            Text("敵を倒す\(todoManager.bar):\(todoManager.fraction)")
//            }
        }
    }
    
    
}

struct ExperienceBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceBarView()
            .environmentObject(TodoManager())
    }
}
