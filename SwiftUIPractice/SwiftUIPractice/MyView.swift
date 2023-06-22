//
//  MyView.swift
//  SwiftUIPractice
//
//  Created by 한소희 on 2023/06/03.
//

import SwiftUI

struct MyView: View {
    let helloFont: Font
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/).font(helloFont)
            Text("나는 담곰이야~")
            HStack {
                Text("흠...")
                Text("왜 안 떠!")
            }
        }
        
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView(helloFont: .title)
    }
}
