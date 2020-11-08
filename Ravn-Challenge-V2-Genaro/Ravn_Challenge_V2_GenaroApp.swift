//
//  Ravn_Challenge_V2_GenaroApp.swift
//  Ravn-Challenge-V2-Genaro
//
//  Created by Genaro Alvarenga on 11/6/20.
//

import SwiftUI

@main
struct Ravn_Challenge_V2_GenaroApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().backgroundColor = .black
    }
    
    var body: some Scene {
        WindowGroup {
            PeopleView(viewModel: PeopleViewModel())
        }
    }
}
