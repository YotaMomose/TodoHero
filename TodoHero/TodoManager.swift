//
//  TodoManager.swift
//  TodoHero
//
//  Created by Apple on 2022/10/15.
//

import SwiftUI

class TodoManager: ObservableObject {
    @Published var isEditing: Bool = false
    @Published var monsterExp :CGFloat = 20
    @Published var timerHandler : Timer?
    @Published var fraction: CGFloat = 0
    @Published var getExp:CGFloat = 0
    @Published var isVaidTimer = false
}



extension Font {
    static func gameFont(size: CGFloat) -> Font {
        return Font.custom("PixelMplus12-Regular", size: size)
    }
}
