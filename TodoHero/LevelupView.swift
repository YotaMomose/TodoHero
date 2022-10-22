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
    @AppStorage("user_name") var userName = "未設定"
    @AppStorage("user_level") var userLevel = 1
    var body: some View {
        
        ZStack {
            
            Image("levelup")
                .resizable()
                .ignoresSafeArea()
            VStack {
                Text("レベルアップ!!")
                    .font(Font.gameFont(size: 40))
                    .foregroundColor(.pink)
                Image("yuusya")
                    .resizable()
                ZStack {
                    Text("Lv.\(userLevel-1) ⇨ Lv.\(userLevel)")
                        .font(.gameFont(size: 40))
                    Rectangle()
                        .stroke(lineWidth: 10)
                        .padding()
                }
                .frame(height: 100)
                Button(action:{
                    isPresented = false
                    todoManager.bar = 0
                    getFraction()
                }) {
                    Text("閉じる")
                        .font(.gameFont(size: 20))
                }
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
