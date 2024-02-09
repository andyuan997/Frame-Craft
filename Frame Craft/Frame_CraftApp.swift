//
//  Frame_CraftApp.swift
//  Frame Craft
//
//  Created by 袁維謙 on 2024/2/9.
//


import SwiftUI

@main
struct Frame_CraftApp: App {
    @State private var selectedOption1080x2340: String = UserDefaults.standard.string(forKey: "SelectedOption1080x2340") ?? "iPhone 13 mini - Midnight"
    @State private var selectedOption1125x2436: String = "iPhone 11 Pro"
    @State private var selectedOption1170x2532: String = "iPhone 14 - Purple"
    @State private var selectedOption1179x2556: String = "iPhone 14 Pro - Deep Purple"
    @State private var selectedOption1242x2688: String = "iPhone 11"
    @State private var selectedOption1284x2778: String = "iPhone 13 Pro Max - Graphite"
    @State private var selectedOption1290x2796: String = "iPhone 15 Pro Max - Black Titanium"
    @State private var language: String = "English"
    
    var body: some Scene {
        WindowGroup {
            ContentView(selectedOption1080x2340: selectedOption1080x2340, selectedOption1125x2436: selectedOption1125x2436, selectedOption1170x2532: selectedOption1170x2532, selectedOption1179x2556: selectedOption1179x2556, selectedOption1242x2688: selectedOption1242x2688, selectedOption1284x2778: selectedOption1284x2778, selectedOption1290x2796: selectedOption1290x2796)
        }
        .commands {
            CustomMenu(selectedOption1080x2340: $selectedOption1080x2340, selectedOption1125x2436: $selectedOption1125x2436, selectedOption1170x2532: $selectedOption1170x2532, selectedOption1179x2556: $selectedOption1179x2556, selectedOption1242x2688: $selectedOption1242x2688, selectedOption1284x2778: $selectedOption1284x2778, selectedOption1290x2796: $selectedOption1290x2796, language: $language)
        }
    }
}

struct CustomMenu: Commands {
    @Binding var selectedOption1080x2340: String
    @Binding var selectedOption1125x2436: String
    @Binding var selectedOption1170x2532: String
    @Binding var selectedOption1179x2556: String
    @Binding var selectedOption1242x2688: String
    @Binding var selectedOption1284x2778: String
    @Binding var selectedOption1290x2796: String
    @Binding var language: String
    
    var body: some Commands {
        CommandMenu("Custom Style") {
            Picker("5.8\" 1080x2340", selection: $selectedOption1080x2340) {
                            Text("iPhone 12 mini - White").tag("iPhone 12 mini - White")
                            Text("iPhone 13 mini - Midnight").tag("iPhone 13 mini - Midnight")
                            Text("iPhone 13 mini - Starlight").tag("iPhone 13 mini - Starlight")

                        }
            Picker("5.8\" 1125x2436", selection: $selectedOption1125x2436) {
                            Text("iPhone 11 Pro").tag("iPhone 11 Pro")
                        }
            Picker("5.8\" 1170x2532", selection: $selectedOption1170x2532) {
                            Text("iPhone 12 - White").tag("iPhone 12 - White")
                            Text("iPhone 12 Pro - Silver").tag("iPhone 12 Pro - Silver")
                            Text("iPhone 13 - Midnight").tag("iPhone 13 - Midnight")
                            Text("iPhone 13 - Starlight").tag("iPhone 13 - Starlight")
                            Text("iPhone 13 Pro - Graphite").tag("iPhone 13 Pro - Graphite")
                            Text("iPhone 13 Pro - Silver").tag("iPhone 13 Pro - Silver")
                            Text("iPhone 14 - Blue").tag("iPhone 14 - Blue")
                            Text("iPhone 14 - Midnight").tag("iPhone 14 - Midnight")
                            Text("iPhone 14 - Purple").tag("iPhone 14 - Purple")
                            Text("iPhone 14 - Red").tag("iPhone 14 - Red")
                            Text("iPhone 14 - Starlight").tag("iPhone 14 - Starlight")
                            Text("iPhone 14 Plus - Blue").tag("iPhone 14 Plus - Blue")
                            Text("iPhone 14 Plus - Midnight").tag("iPhone 14 Plus - Midnight")
                            Text("iPhone 14 Plus - Purple").tag("iPhone 14 Plus - Purple")
                            Text("iPhone 14 Plus - Red").tag("iPhone 14 Plus - Red")
                            Text("iPhone 14 Plus - Starlight").tag("iPhone 14 Plus - Starlight")
                        }
            Picker("6.1\" 1179x2556", selection: $selectedOption1179x2556) {
                            Text("iPhone 14 Pro - Deep Purple").tag("iPhone 14 Pro - Deep Purple")
                            Text("iPhone 14 Pro - Gold").tag("iPhone 14 Pro - Gold")
                            Text("iPhone 14 Pro - Silver").tag("iPhone 14 Pro - Silver")
                            Text("iPhone 14 Pro - Space Black").tag("iPhone 14 Pro - Space Black")
                            Text("iPhone 15 - Black").tag("iPhone 15 - Black")
                            Text("iPhone 15 - Blue").tag("iPhone 15 - Blue")
                            Text("iPhone 15 - Green").tag("iPhone 15 - Green")
                            Text("iPhone 15 - Pink").tag("iPhone 15 - Pink")
                            Text("iPhone 15 - Yellow").tag("iPhone 15 - Yello")
                            Text("iPhone 15 Pro - Black Titanium").tag("iPhone 15 Pro - Black Titanium")
                            Text("iPhone 15 Pro - Blue Titanium").tag("iPhone 15 Pro - Blue Titanium")
                            Text("iPhone 15 Pro - Natural Titanium").tag("iPhone 15 Pro - Natural Titanium")
                            Text("iPhone 15 Pro - White Titanium").tag("iPhone 15 Pro - White Titanium")
                        }
            Picker("6.5\" 1242x2688", selection: $selectedOption1242x2688) {
                            Text("iPhone 11").tag("iPhone 11")
                            Text("iPhone 11 Pro Max").tag("iPhone 11 Pro Max")
                            
                        }
            Picker("6.5\" 1284x2778", selection: $selectedOption1284x2778) {
                            Text("iPhone 12 Pro Max - Silver").tag("iPhone 12 Pro Max - Silver")
                            Text("iPhone 13 Pro Max - Graphite").tag("iPhone 13 Pro Max - Graphite")
                            Text("iPhone 13 Pro Max - Silver").tag("iPhone 13 Pro Max - Silver")
                        }
            Picker("6.7\" 1290x2796", selection: $selectedOption1290x2796) {
                            Text("iPhone 14 Pro Max - Deep Purple").tag("iPhone 14 Pro Max - Deep Purple")
                            Text("iPhone 14 Pro Max - Gold").tag("iPhone 14 Pro Max - Gold")
                            Text("iPhone 14 Pro Max - Silver").tag("iPhone 14 Pro Max - Silver")
                            Text("iPhone 14 Pro Max - Space Black").tag("iPhone 14 Pro Max - Space Black")
                            Text("iPhone 15 Plus - Black").tag("iPhone 15 Plus - Black")
                            Text("iPhone 15 Plus - Blue").tag("iPhone 15 Plus - Blue")
                            Text("iPhone 15 Plus - Green").tag("iPhone 15 Plus - Green")
                            Text("iPhone 15 Plus - Pink").tag("iPhone 15 Plus - Pink")
                            Text("iPhone 15 Plus - Yellow").tag("iPhone 15 Plus - Yellow")
                            Text("iPhone 15 Pro Max - Black Titanium").tag("iPhone 15 Pro Max - Black Titanium")
                            Text("iPhone 15 Pro Max - Blue Titanium").tag("iPhone 15 Pro Max - Blue Titanium")
                            Text("iPhone 15 Pro Max - Natural Titanium").tag("iPhone 15 Pro Max - Natural Titanium")
                            Text("iPhone 15 Pro Max - White Titanium").tag("iPhone 15 Pro Max - White Titanium")
                        }
        }

        CommandMenu("Setting") {
            Picker("Language", selection: $language) {
                            Text("English").tag("English")
                            //Text("繁體中文").tag("繁體中文")
                            //Text("简体中文").tag("简体中文")
            }
        }
    }
    
}
