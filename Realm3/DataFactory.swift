//
//  DataFactory.swift
//  Realm3
//
//  Created by SeongHoon Jang on 2022/06/14.
//

import Foundation

//id,name,top,middle,bottom,once,unit,totalProduct,totalSugar

// csv 파싱한 것을 담기 위한 인스턴스
struct Food: Identifiable {
    var id: String = ""
    var name: String = ""
    var top: String = ""
    var middle: String = ""
    var bottom: String = ""
    var once: String = ""
    var unit: String = ""
    var totalProduct: String = ""
    var totalSugar: String = ""
    var uuid = UUID()
    var date: String = todayString()
    
    init (raw: [String]) {
        id = raw[0]
        name = raw[1]
        top = raw[2]
        middle = raw[3]
        bottom = raw[4]
        once = raw[5]
        unit = raw[6]
        totalProduct = raw[7]
        totalSugar = raw[8]
    }
}
//id,large,medium,small,caculatedSugar,foodAmount,
//30179,음료,두유,가공두유,5.3,230,

struct User: Identifiable {
    var id = ""
    var large: String = ""
    var medium: String = ""
    var small: String = ""
    var caculatedSugar: String = ""
    var foodAmount: String = ""
    var uuid = UUID()
    var date: String = todayString()
    
    init (raw: [String]) {
        id = raw[0]
        large = raw[1]
        medium = raw[2]
        small = raw[3]
        caculatedSugar = raw[4]
        foodAmount = raw[5]
    }
}
// csv 파일명("sample")을 받아와서 [User]로 반환
func loadDumyRecord(from csvName: String) -> [User] {
    var csvToStruct = [User]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return[]
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return[]
    }
    // 맨 첫줄 삭제
    var rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let userStruct = User.init(raw: csvColumns)
            csvToStruct.append(userStruct)
        }
    }

    return csvToStruct
}


// csv 파일명("sample")을 받아와서 [Food]로 반환
func loadCSV(from csvName: String) -> [Food] {
    var csvToStruct = [Food]()
    
    guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
        return[]
    }
    
    var data = ""
    do {
        data = try String(contentsOfFile: filePath)
    } catch {
        print(error)
        return[]
    }
    // 맨 첫줄 삭제
    var rows = data.components(separatedBy: "\n")
    
    let columnCount = rows.first?.components(separatedBy: ",").count
    rows.removeFirst()
    
    for row in rows {
        let csvColumns = row.components(separatedBy: ",")
        if csvColumns.count == columnCount {
            let foodStruct = Food.init(raw: csvColumns)
            csvToStruct.append(foodStruct)
        }
    }

    return csvToStruct
}
// https://stackoverflow.com/questions/68991238/data-from-csv-file-wont-show-up-when-called-in-list-on-swift

// MARK: [년년년년월월일일] - 현재 날짜 반환
func todayString() -> String {
    // [date 객체 사용해 현재 날짜 및 시간 24시간 형태 출력 실시]
    let nowDate = Date() // 현재의 Date 날짜 및 시간
    let dateFormatter = DateFormatter() // Date 포맷 객체 선언
    dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
    dateFormatter.dateFormat = "yyyyMMdd" // Date 포맷 타입 지정
    let date_string = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
    return date_string
}
