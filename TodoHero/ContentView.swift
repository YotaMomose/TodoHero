//
//  ContentView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.data, ascending: true)],
                  animation: .default) var items: FetchedResults<Task>
    
    var body: some View {
        NavigationStack {
            VStack {
                StatusView()
                ListView()
                    
            }
            
            .padding()
            .toolbar{
                EditButton()
                    
            }
        }
    }
     
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TodoManager())
    }
}
