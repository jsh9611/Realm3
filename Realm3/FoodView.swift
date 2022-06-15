//
//  FoodView.swift
//  Realm3
//
//  Created by SeongHoon Jang on 2022/06/14.
//

import SwiftUI

// csv 내용 출력하는거 테스트하는 뷰
struct FoodView: View {
    var foods = loadCSV(from: "sampleData")
    var body: some View {
        List {
            ForEach(foods) { item in
                Text(item.name)
            }
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView()
    }
}
