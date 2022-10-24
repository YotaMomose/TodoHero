//
//  ExperienceBarView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/19.
//

import SwiftUI

struct ExperienceBarView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.data, ascending: true)],
                  animation: .default) var items: FetchedResults<Task>
    @EnvironmentObject var todoManager: TodoManager
    @AppStorage("bar_exp") var bar = 0
    var body: some View {
        VStack {
            ZStack {
                
                Rectangle()
                    .foregroundColor(.green)
                    .scaleEffect(x:(CGFloat(bar)/100),y: 1.0,anchor: .leading)
                Rectangle().stroke(.brown, lineWidth: 2)
                
            }
            .frame(width: 130,height: 20)
            Text("\(bar)")
        }
    }
    
    
}

struct ExperienceBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceBarView()
            .environmentObject(TodoManager())
    }
}
