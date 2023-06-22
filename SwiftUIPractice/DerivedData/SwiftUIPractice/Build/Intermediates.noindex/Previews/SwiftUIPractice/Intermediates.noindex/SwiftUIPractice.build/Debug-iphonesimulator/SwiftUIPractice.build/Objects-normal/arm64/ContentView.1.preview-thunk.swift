@_private(sourceFile: "ContentView.swift") import SwiftUIPractice
import SwiftUI
import SwiftUI

extension ContentView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/SwiftUIPractice/SwiftUIPractice/ContentView.swift", line: 25)
        ContentView()
    
#sourceLocation()
    }
}

extension ContentView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/SwiftUIPractice/SwiftUIPractice/ContentView.swift", line: 12)
        MyView(helloFont: .title)
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()
    
#sourceLocation()
    }
}

import struct SwiftUIPractice.ContentView
import struct SwiftUIPractice.ContentView_Previews

