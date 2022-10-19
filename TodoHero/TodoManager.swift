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
    @Published var bar: CGFloat = 0
}

enum monster {
    case slime
    case orc
    case golem
    case dragon
    case maou
}
