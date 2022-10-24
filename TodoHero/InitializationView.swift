//
//  InitializationView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/21.
//

import SwiftUI

struct InitializationView: View {
    @State var page = 0
    @Binding var isPresented: Bool
    @AppStorage("first_login") var firstLogin = true
    @AppStorage("user_name") var userName = "未設定"
    @State var alert = false
    
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
                          Text("日常生活に溢れるやらなければならないこと。\nそんな面倒な敵を倒すべく１人の勇者が立ち上がった。")
                        } else if page == 1 {
                            Text("まずはあなたの名前を教えてください。")
                            HStack {
                                TextField("名前登録", text: $userName)
                                    .overlay(Rectangle().stroke())
                                
                                Button(action:{
                                    if userName.count > 8 {
                                        alert = true
                                        return
                                    }
                                page += 1
                                }) {
                                    Text("▶︎決定")
                                    
                                }
                            }
                            if alert {
                                Text("名前は８文字以内で設定できます")
                                    .font(.gameFont(size: 20))
                                    .foregroundColor(.white)
                            }
                        } else if page == 2 {
                            Text("ようこそ、\(userName)さん\nさっそくアプリを始めましょう！")
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
                        if page == 2 {
                            isPresented = false
                            firstLogin = false
                            
                        }
                        page += 1
                    }) {
                        Text(page == 2 ? "OK" : "次へ")
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
        InitializationView(isPresented: .constant(true))
    }
}
