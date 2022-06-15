//
//  ContentView.swift
//  Realm3
//
//  Created by SeongHoon Jang on 2022/06/14.
//

import SwiftUI
import RealmSwift
// SPM으로 설치하세용: https://github.com/realm/realm-swift.git

struct ContentView: View {
    @AppStorage("isFirstLaunch") private var isFirstLaunch: Bool = true
    let realm = try! Realm()
    
    var body: some View {
        VStack {
            VStack {
                Button {
                    print(realm.configuration.fileURL)
                } label: {
                    Text("파일 경로 출력 버튼")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.cyan)
                }
                .padding()
                
                Button {
                    for item in realm.objects(DBFood.self) {
                        print("이름: ", item.name)
                        print("1회제품: ", item.once, "총설탕: ",  item.totalSugar)
                        print("날짜: ", item.date)
                        print("----------------------------------")
                    }
                } label: {
                    Text("DB 내용 로드 버튼")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.orange)
                }
                .padding()
                
                Button {
                    print(todayString())
                } label: {
                    Text("오늘 날짜 출력")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .background(Color.green)
                }
                .padding()
            }
            
        }
        .font(.title)
        .onAppear {
            // 앱을 처음 실행했을 때만 csv를 불러온다
            if isFirstLaunch {
                print("앱을 처음 실행하시네요. csv 불러옵니다")
                csvToRealm()
                isFirstLaunch = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
