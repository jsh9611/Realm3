//
//  UserRecordsView.swift
//  Realm3
//
//  Created by SeongHoon Jang on 2022/06/17.
//

import SwiftUI

// csv 내용 출력하는거 테스트하는 뷰
struct UserRecordsView: View {
    var temp = loadDumyRecord(from: "userDumyData")
    var body: some View {
        List {
            ForEach(temp) { item in
                Text("\(item.small)먹음 \(item.caculatedSugar)설탕, \(item.unit)입니다.")
            }
        }
    }
}

struct UserRecordsView_Previews: PreviewProvider {
    static var previews: some View {
        UserRecordsView()
    }
}
