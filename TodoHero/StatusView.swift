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
    
    var body: some View {
        HStack {
            
            Text(userName)
                .font(Font.gameFont(size: userName.count<7 ? 20 : 18))
            Image("yuusya")
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 40)
            ExperienceBarView()
            Text("Lv.\(userLevel)")
                .font(Font.gameFont(size: 20))
                
        }
        
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
            .environmentObject(TodoManager())
    }
}
