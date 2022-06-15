//
//  RealmModel.swift
//  Realm3
//
//  Created by SeongHoon Jang on 2022/06/14.
//

import Foundation
import RealmSwift
// id,name,top,middle,bottom,once,unit,totalProduct,totalSugar
class DBFood: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var top: String = ""
    @objc dynamic var middle: String = ""
    @objc dynamic var bottom: String = ""
    @objc dynamic var once: String = ""
    @objc dynamic var unit: String = ""
    @objc dynamic var totalProduct: String = ""
    @objc dynamic var totalSugar: String = ""
    @objc dynamic var date: String = ""
    //  let ofUser = LinkingObjects(fromType: User.self, property: "todos")
    
    //    convenience init(id: String, name: String, top: String, middle: String, bottom: String, once: String, unit: String, totalProduct: String, totalSugar: String) {
    //        self.init()
    //    }
    
    convenience init(id: String, name: String, top: String, middle: String, bottom: String, once: String, unit: String, totalProduct: String, totalSugar: String, date: String) {
        self.init()
        self.id = id
        self.name = name
        self.top = top
        self.middle = middle
        self.bottom = bottom
        self.once = once
        self.unit = unit
        self.totalProduct = totalProduct
        self.totalSugar = totalSugar
        self.date = date
    }
}

func csvToRealm() {
    let realm = try! Realm()
 
    let foods = loadCSV(from: "sampleData")
    for food in foods {
        let item = DBFood(id: food.id, name: food.name, top: food.top, middle: food.middle, bottom: food.bottom, once: food.once, unit: food.unit, totalProduct: food.totalProduct, totalSugar: food.totalSugar, date: food.date)
        try! realm.write {
            realm.add([item])
        }
    }
}


// 만약 realm 파일명을 바꾸고 싶은 경우에 사용(일단 안씀)
func setDefaultRealmForUser(fileName: String) {
        var config = Realm.Configuration()

        // Use the default directory, but replace the filename with the username
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("\(fileName).realm")

        // Set this as the configuration used for the default Realm
        Realm.Configuration.defaultConfiguration = config
    }
//출처: https://nsios.tistory.com/64 [NamS의 iOS일기:티스토리]
