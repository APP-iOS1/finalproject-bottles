//
//  SafariWebView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/31.
//

import SwiftUI
import SafariServices

struct SafariWebView: UIViewControllerRepresentable {
//    var url: URL
    @Binding var selectedUrl: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariWebView>) -> SFSafariViewController {
//        print("\(url)")
        return SFSafariViewController(url: selectedUrl)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        
    }
}
    
//struct SafariWebView_Previews: PreviewProvider {
//    static var previews: some View {
//        SafariWebView(selectedUrl: URL(string: "https://www.apple.com/kr/"))
//    }
//}
