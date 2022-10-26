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
    @EnvironmentObject var todoManager: TodoManager
    @State var firstLog = false
    @AppStorage("first_login") var firstLogin = true
    @AppStorage("use_ticket") var useTicket = false
    @AppStorage("stop_data") var stopDate = Date()
    @State var ticketCount = 0

    
    var body: some View {
        NavigationStack {
            VStack {
                StatusView(ticketCount: $ticketCount)
                ListView()
            }
            .padding()
            .toolbar{
                EditButton()
                    .disabled(items.isEmpty)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: AchievementsView(), label: {Text("実績")})
                }
            }
        }
        .onAppear {
            if useTicket {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                    ticketCount = Int(stopDate.timeIntervalSinceNow)
                    if stopDate.timeIntervalSinceNow < 0 {
                        useTicket = false
                        timer.invalidate()
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $firstLogin) {
            InitializationView(isPresented: $firstLogin)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(TodoManager())
    }
}
