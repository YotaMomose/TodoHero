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
    @State var timerHandler : Timer?
    @State var fraction: CGFloat = 0
    @State var getExp:CGFloat = 0
    @State var bar: CGFloat = 0
    var body: some View {
        VStack {
            ZStack {
                Capsule().stroke(.gray)
                Capsule()
                    .foregroundColor(.green)
                    .scaleEffect(x:(bar/100),y: 1.0,anchor: .leading)
            }
            .frame(width: 200,height: 20)
            
//            Button(action:{
//                getExp = 0
//                getEx()
//            }) {
//                Text("敵を倒す\(bar):\(fraction)")
//            }
        }
    }
    
    func getEx() {
        timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            bar += 1
            getExp += 1
            if bar == 100 {
                fraction = todoManager.monsterExp - getExp
            }
            
            if getExp == todoManager.monsterExp {
                timerHandler?.invalidate()
            }
        }
    }
    
    func getFraction() {
        timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if fraction == 0 {
                timerHandler?.invalidate()
                return
            }
            bar += 1
            fraction -= 1
        }
    }
}

struct ExperienceBarView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceBarView()
            .environmentObject(TodoManager())
    }
}
