//
//  LevelupView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/19.
//

import SwiftUI

struct LevelupView: View {
    @EnvironmentObject var todoManager: TodoManager
    @Binding var isPresented:Bool
    
    var body: some View {
        
        VStack {
            Text("レベルアップ!!")
                .font(Font.gameFont(size: 40))
            
            Rectangle()
                .stroke(lineWidth: 10)
                .frame(height: 70)
                
            Button(action:{
                isPresented = false
                todoManager.bar = 0
                getFraction()
            }) {
                Text("閉じる")
            }
        }
        
    }
    func getFraction() {
        todoManager.timerHandler = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if todoManager.fraction == 0 {
                todoManager.timerHandler?.invalidate()
                return
            }
            todoManager.bar += 1
            todoManager.fraction -= 1
        }
    }
}

struct LevelupView_Previews: PreviewProvider {
    static var previews: some View {
        LevelupView(isPresented: .constant(true))
            .environmentObject(TodoManager())
    }
}
