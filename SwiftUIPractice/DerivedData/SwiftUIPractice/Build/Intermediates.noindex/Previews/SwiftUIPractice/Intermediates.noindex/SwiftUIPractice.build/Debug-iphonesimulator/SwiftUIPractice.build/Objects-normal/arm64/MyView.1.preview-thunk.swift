@_private(sourceFile: "MyView.swift") import SwiftUIPractice
import SwiftUI
import SwiftUI

extension MyView_Previews {
    @_dynamicReplacement(for: previews) private static var __preview__previews: some View {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/SwiftUIPractice/SwiftUIPractice/MyView.swift", line: 26)
        MyView()
    
#sourceLocation()
    }
}

extension MyView {
    @_dynamicReplacement(for: body) private var __preview__body: some View {
        #sourceLocation(file: "/Users/hansohee/Xcode/Intermediate_Project/SwiftUIPractice/SwiftUIPractice/MyView.swift", line: 12)
        VStack {
            Text(/*@START_MENU_TOKEN@*/__designTimeString("#5780.[1].[0].property.[0].[0].arg[0].value.[0].arg[0].value", fallback: "Hello, World!")/*@END_MENU_TOKEN@*/).font(.title)
            Text(__designTimeString("#5780.[1].[0].property.[0].[0].arg[0].value.[1].arg[0].value", fallback: "나는 담곰이야~"))
            HStack {
                Text(__designTimeString("#5780.[1].[0].property.[0].[0].arg[0].value.[2].arg[0].value.[0].arg[0].value", fallback: "흠..."))
                Text(__designTimeString("#5780.[1].[0].property.[0].[0].arg[0].value.[2].arg[0].value.[1].arg[0].value", fallback: "왜 안 떠!"))
            }
        }
        
    
#sourceLocation()
    }
}

import struct SwiftUIPractice.MyView
import struct SwiftUIPractice.MyView_Previews

