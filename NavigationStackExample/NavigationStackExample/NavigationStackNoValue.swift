//
//  NavigationStackNoValue.swift
//  NavigationStackExample
//
//  Created by 김태형 on 2023/08/11.
//

import SwiftUI

struct NavigationStackNoValue: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 20) {
                Text("Root View")
                NavigationLink("Go to Second View", value: "start")  //stack의 루트를 찾아야 하기 때문에 value는 있어야 함
                    .navigationDestination(for: String.self) { _ in
                        SecondView(path: $path)
                    }
            }
        }
    }
}

struct SecondView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("SecondView")

            NavigationLink("Go to Third Page", destination: ThirdView(path: $path))
        }
    }
}

struct ThirdView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("ThirdView")

            NavigationLink(destination: FourthView(path: $path)) {
                Text("Go to Fourth Page")
            }
            Button("Go to Root View") {
                path.removeLast()
            }
        }
    }
}

struct FourthView: View {
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("FourthView")

            Button("Go to Root View") {
                path.removeLast()
            }
        }
    }
}

struct NavigationPathNoValue_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackNoValue()
    }
}
