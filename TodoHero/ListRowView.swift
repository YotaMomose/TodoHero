//
//  ListRowView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

struct ListRowView: View {
    let task: String
    var IsCheck: Bool
    let monstar: Int
    var body: some View {
        HStack {
            
            
            if IsCheck {
                Text("☑︎")
                Text(task)
                    .strikethrough()
                    .fontWeight(.ultraLight)
                switch monstar {
                case 1 :
                    Image("slime")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                        
                case 2 :
                    Image("orc")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                case 3 :
                    Image("golem")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                case 4 :
                    Image("dragon")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                default:
                    Image("maou")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.gray)
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                }
                // defaultをなんとかしたい
            } else {
                Text("□")
                Text(task)
                switch monstar {
                case 1 :
                    Image("slime")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                        
                case 2 :
                    Image("orc")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                case 3 :
                    Image("golem")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                case 4 :
                    Image("dragon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                default:
                    Image("maou")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40,height: 40)
                }
                // defaultをなんとかしたい
            }
            
        }
    }
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(task: "掃除", IsCheck: true, monstar: 4)
    }
}
