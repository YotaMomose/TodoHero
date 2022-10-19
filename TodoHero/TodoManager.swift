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
}

enum monster {
    case slime
    case orc
    case golem
    case dragon
    case maou
}
