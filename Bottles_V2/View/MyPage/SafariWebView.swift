//
//  SafariWebView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/31.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariWebView>) -> SFSafariViewController {
//        print("\(url)")
        return SFSafariViewController(url: url)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
    
struct SafariWebView_Previews: PreviewProvider {
    static var previews: some View {
        SafariWebView(url: URL(string: "https://www.apple.com/kr/")!)
    }
}
