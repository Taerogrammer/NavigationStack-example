//
//  ContentView.swift
//  NavigationStackExample
//
//  Created by 김태형 on 2023/08/11.
//

import SwiftUI

struct ContentView: View {
    var platforms: [Platform] = [.init(name: "Xbox", imageName: "xbox.logo", color: .green),
                                 .init(name: "Playstation", imageName:"playstation.logo", color: .indigo),
                                 .init(name: "PC", imageName: "pc", color: .pink),
                                 .init(name: "Mobile", imageName: "iphone", color: .mint)]

    //같은 데이터 형식을 사용한 예시 (화면을 넘길 때는 대부분 다른 뷰와 데이터를 보기 때문에 일반적인 상황은 아님)
    var games: [Game] = [.init(name: "Minecraft", rating: "99"),
                         .init(name: "LOL", rating: "100"),
                         .init(name: "FIFA", rating: "94"),
                         .init(name: "Maple Story", rating: "70")]

//    @State private var path: [Game] = []

    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            List {
                Section("Platform") {
                    ForEach(platforms, id: \.name) { platform in
                        NavigationLink(value: platform) {   //NavigationStack은 Data를 넘겨주기 때문에 value가 들어감
                            Label(platform.name, systemImage: platform.imageName)
                                .foregroundColor(platform.color)
                        }
                    }
                }

                Section("Games") {
//                    ForEach(games, id: \.name) { game in
//                        NavigationLink(value: game) {   //Navigation Destination이 존재하기 때문에 > 생성됨
//                            Text(game.name)
//                        }
//                    }
                    Button("Add Games") {
                        path.append(games.first!)   //path에 games.first!를 추가하여 이동하였음 -> '데이터'를 가지고 있음
//                        path = games    //모든 games 데이터가 추가됨
                    }
                }
            }
            .navigationTitle("Gaming")
            .navigationDestination(for: Platform.self) { platform in    //platform 데이터를 넘겨줌!
                ZStack {
                    platform.color.ignoresSafeArea()
                    VStack {
                        Label(platform.name, systemImage: platform.imageName)
                            .font(.largeTitle)
                            .bold()
                        List {
                            ForEach(games, id: \.name) { game in
                                NavigationLink(value: game) {   //Navigation Destination이 존재하기 때문에 > 생성됨
                                    Text(game.name)
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: Game.self) { game in
                VStack(spacing: 20) {
                    Text("\(game.name) - \(game.rating)")
                        .font(.largeTitle.bold())

                    //경로를 추가함
                    Button("Recommanded game") {
                        path.append(games.randomElement()!)
                    }

                    Button("Go to another platform") {
                        path.append(platforms.randomElement()!)
                    }

                    //path에 있는 데이터를 제거함으로 루트 뷰로 이동함
                    Button("Go Home") {
                        path.removeLast(path.count)
                    }
                }
            }
        }
    }
}

struct Platform: Hashable {
    let name: String
    let imageName: String
    let color: Color
}

struct Game: Hashable {
    let name: String
    let rating: String
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
