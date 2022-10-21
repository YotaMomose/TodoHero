//
//  InitializationView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/21.
//

import SwiftUI

struct InitializationView: View {
    @State var page = 0
    @State var userName = "未設定"
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest (sortDescriptors: []) var user: FetchedResults<UserInfo>
    var body: some View {
        
        ZStack {
            
            Color(.black)
                .ignoresSafeArea()
            VStack {
                ZStack {
                    Rectangle()
                        .stroke(lineWidth: 10)
                        .foregroundColor(.white)
                        .frame(height: 150)
                        .padding()
                    
                    VStack {
                        if page == 0 {
                          Text("はじめまして。\n日々やることに追われて、嫌になっていませんか？\nこのアプリは日々のタスクをゲームのような感覚でこなしていくお手伝いをします。")
                        } else if page == 1 {
                            Text("まずはあなたの名前を教えてください。")
                            HStack {
                                TextField("名前登録", text: $userName)
                                    .overlay(Rectangle().stroke())
                                Button(action:{
                                    let newUser = UserInfo(context:viewContext)
                                    newUser.name = userName
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        fatalError("セーブに失敗")
                                    }
                                    page += 1
                                }) {
                                    Text("▶︎決定")
                                    
                                }
                            }
                            
                        } else if page == 2 {
                            Text("ようこそ\(userName)さん\nさっそくアプリを始めましょう！")
                        }
                        
                        
                        
                        
                    }
                    
                    .font(Font.gameFont(size: 20))
                    .frame(width: 300, height: 150)
                    .foregroundColor(.white)
                }
                HStack {
                    
                    Button(action:{
                        page -= 1
                    }) {
                        Text("戻る")
                    }
                    .opacity(page==0 ? 0 : 1)
                    Spacer()
                    Button(action:{
                        page += 1
                    }) {
                        Text("次へ")
                    }
                    .opacity(page==1 ? 0 : 1)
                    
                }
                .font(Font.gameFont(size: 20))
                .frame(width: 300, height: 150)
                .foregroundColor(.white)
                
            }
            
            
            
            
        }
        
        
        
    }
}

struct InitializationView_Previews: PreviewProvider {
    static var previews: some View {
        InitializationView()
    }
}
