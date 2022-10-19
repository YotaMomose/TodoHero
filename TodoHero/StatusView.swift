//
//  StatusView.swift
//  TodoHero
//
//  Created by Apple on 2022/10/19.
//

import SwiftUI

struct StatusView: View {
    var body: some View {
        HStack {
            Text("Name")
            Image("yuusya")
                .resizable()
                .scaledToFit()
                .frame(width: 40,height: 40)
            ExperienceBarView()
            Text("Lv.1")
                
        }
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
            .environmentObject(TodoManager())
    }
}
