//
//  NavigationStackWithValue.swift
//  NavigationStackExample
//
//  Created by 김태형 on 2023/08/11.
//

import SwiftUI

struct NavigationStackWithValue: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            NavigationLink("Go to Child View", value: "Second")
                .navigationDestination(for: String.self) { value in
                    SecondPage(viewNumber: value, path: $path)
                }
        }
    }
}

struct SecondPage: View {
    let viewNumber: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("This view is \(viewNumber)")

            NavigationLink("Go to Third Page", destination: ThirdPage(viewNumber: "Third", path: $path))
        }
        .onAppear { print(path)}
    }
}

struct ThirdPage: View {
    let viewNumber: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("This view is \(viewNumber)")

            NavigationLink(destination: FourthPage(viewNumber: "Fourth", path: $path)) {
                Text("Go to Fourth Page")
            }
            Button("Go to Root View") {
                path.removeLast()
            }
        }
        .onAppear { print(path)}
    }
}

struct FourthPage: View {
    let viewNumber: String
    @Binding var path: NavigationPath

    var body: some View {
        VStack(spacing: 20) {
            Text("This view is \(viewNumber)")

            Button("Go to Root View") {
                path.removeLast()
            }
        }
        .onAppear { print(path)}
    }
}


struct NavigationPathExample_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStackWithValue()
    }
}
