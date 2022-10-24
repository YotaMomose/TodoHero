//
//  StatusView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/19.
//

import SwiftUI

struct StatusView: View {
    @FetchRequest (sortDescriptors: []) var user: FetchedResults<UserInfo>
    @Environment(\.managedObjectContext) var viewContext
    @AppStorage("user_name") var userName = "未設定"
    @AppStorage("user_level") var userLevel = 1
    @AppStorage("ticket") var ticket = 0
    @AppStorage("use_ticket") var useTicket = false
    @State var itemSheet = false
    
    var body: some View {
        HStack(spacing: 10) {
            
            Text(userName)
                .font(Font.gameFont(size: userName.count<7 ? 20 : 18))
                .lineLimit(1)
            
            Image("yuusya")
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 40)
            
            ExperienceBarView()
            
            Text("Lv.\(userLevel)")
                .font(Font.gameFont(size: 20))
            
            ZStack {
                Color.yellow
                HStack {
                    Image("ticket")
                        .resizable()
                        .scaledToFit()
                    Text("\(ticket)")
                        .font(.gameFont(size: 20))
                }
                .onTapGesture {
                    if ticket > 0 {
                        itemSheet = true
                    }
                }
                .confirmationDialog("経験値２倍チケットを使用しますか？", isPresented: $itemSheet, titleVisibility: .visible) {
                    Button(action: {
                        useTicket = true
                        ticket -= 1
                    }) {
                        Text("使用する")
                    }
                } message: {
                    Text("※24時間獲得経験値が２倍になります")
                }
                
                
            }
            .frame(width: 60,height: 40)
            .clipShape(RoundedRectangle(cornerRadius: 10))
                
        }
        
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
            .environmentObject(TodoManager())
    }
}
