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
    @EnvironmentObject var todoManager: TodoManager
    @AppStorage("user_name") var userName = "未設定"
    @AppStorage("ticket") var ticket = 0
    @AppStorage("use_ticket") var useTicket = false
    @AppStorage("stop_data") var stopDate = Date()
    @State var itemSheet = false
    @Binding var ticketCount: Int
    @State var displayedTimeFormat: TimeFormat = .hr
    
    
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
            
            
            ZStack {
                Color.yellow
                VStack {
                    if useTicket {
                        Text("\(setTime())")
                            .font(.system(size: 10))
                    }
                    
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
                            stopDate = Date(timeIntervalSinceNow: 60*60*24)
                            Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                                ticketCount = Int(stopDate.timeIntervalSinceNow)
                                if stopDate.timeIntervalSinceNow < 0 {
                                    useTicket = false
                                    timer.invalidate()
                                }
                            }
                        }) {
                            Text("使用する")
                        }
                    } message: {
                        Text("※24時間獲得経験値が２倍になります")
                    }
                    
                }
            }
            .frame(width: 60,height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            
        }
        
    }
    
    func setTime() -> String {
        
        let hr = ticketCount / 3600
        let min = ticketCount % 3600 / 60
        let sec = ticketCount % 3600 % 60
        
        return String(format: "%02d:%02d:%02d",hr,min,sec)
        
        
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView(ticketCount: .constant(10))
            .environmentObject(TodoManager())
    }
}
