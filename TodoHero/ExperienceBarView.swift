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
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle().stroke(.gray)
                Rectangle()
                    .foregroundColor(.green)
                    .scaleEffect(x:(todoManager.bar/100),y: 1.0,anchor: .leading)
                
                
            }
            .frame(width: 200,height: 20)
        }
    }
    
    
}

struct ExperienceBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceBarView()
            .environmentObject(TodoManager())
    }
}
