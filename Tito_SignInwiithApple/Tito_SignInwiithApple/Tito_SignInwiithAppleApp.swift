//
//  Tito_SignInwiithAppleApp.swift
//  Tito_SignInwiithApple
//
//  Created by Manuel Johan Tito on 06/07/23.
//

import SwiftUI

@main
struct Tito_SignInwiithAppleApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GetNameView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
