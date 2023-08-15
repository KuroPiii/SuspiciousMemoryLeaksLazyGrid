//
//  TestMemoryleaksApp.swift
//  TestMemoryleaks
//
//  Created by MacOS on 15/08/2023.
//

import SwiftUI

@main
struct TestMemoryleaksApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
