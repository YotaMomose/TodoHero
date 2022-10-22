//
//  AchievementsView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/23.
//

import SwiftUI

struct AchievementsView: View {
    @AppStorage("slime_counter") var slimeCounter = 0
    @AppStorage("orc_counter") var orcCounter = 0
    @AppStorage("golem_counter") var golemCounter = 0
    @AppStorage("dragon_counter") var dragonCounter = 0
    @AppStorage("maou_counter") var maouCounter = 0
    var body: some View {
        List {
            Section(header: Text("倒した敵の数").font(.gameFont(size: 20))) {
                HStack {
                    Image("slime")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 40,height: 40)
                    Text("スライム")
                        .font(.gameFont(size: 15))
                    Spacer()
                    Text("\(slimeCounter)")
                        .font(.gameFont(size: 20))
                }
                
                HStack {
                    Image("orc")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 40,height: 40)
                    Text("オーク")
                        .font(.gameFont(size: 15))
                    Spacer()
                    Text("\(orcCounter)")
                        .font(.gameFont(size: 20))
                }
                
                HStack {
                    Image("golem")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 40,height: 40)
                    Text("ゴーレム")
                        .font(.gameFont(size: 15))
                    Spacer()
                    Text("\(golemCounter)")
                        .font(.gameFont(size: 20))
                }
                
                HStack {
                    Image("dragon")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 40,height: 40)
                    Text("ドラゴン")
                        .font(.gameFont(size: 15))
                    Spacer()
                    Text("\(dragonCounter)")
                        .font(.gameFont(size: 20))
                }
                
                HStack {
                    Image("maou")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 40,height: 40)
                    Text("魔王")
                        .font(.gameFont(size: 15))
                    Spacer()
                    Text("\(maouCounter)")
                        .font(.gameFont(size: 20))
                }
            }
            
        }
    }
}

struct AchievementsView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementsView()
    }
}
