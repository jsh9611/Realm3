import SwiftUI
import RealmSwift
import Foundation

final class RecordStore: ObservableObject {
    private var recordResults: Results<RecordDB>
    
    init(realm: Realm) {
        recordResults = realm.objects(RecordDB.self)
        //.filter("date = dateFormatter(date: Date.now)")
    }
    
    var records: [Record] {
        recordResults.map(Record.init)
    }
}

// MARK: - CRUD Actions
extension RecordStore {
    func create(date: String, large: String, medium: String, small: String, sugar: Double) {
        objectWillChange.send()
        
        do {
            let realm = try Realm()
            
            let recordDB = RecordDB()
            recordDB.id = UUID().hashValue
            recordDB.large = large
            recordDB.medium = medium
            recordDB.small = small
            recordDB.date = date
            recordDB.sugar = sugar
            
            try realm.write {
                realm.add(recordDB)
            }
        } catch let error {
            // Handle error
            print(error.localizedDescription)
        }
    }
}


struct Record: Identifiable {
    let id: Int
    let date: String //Date
    let large: String
    let medium: String
    let small: String
    let sugar: Double
}

extension Record {
    init(recordDB: RecordDB) {
        id = recordDB.id
        date = recordDB.date
        large = recordDB.large
        medium = recordDB.medium
        small = recordDB.small
        sugar = recordDB.sugar
    }
}

class RecordDB: Object {
    @objc dynamic var id = 0
    @objc dynamic var date = "" //Date()
    @objc dynamic var large = ""
    @objc dynamic var medium = ""
    @objc dynamic var small = ""
    @objc dynamic var sugar = 0.0
    
    override static func primaryKey() -> String? {
        "id"
    }
}


struct MainView: View {
    @EnvironmentObject var store: RecordStore
    @State private var isPresented = false
    let records: [Record]

    var body: some View {
        VStack{
            List {
                if records.isEmpty {
                    Text("List is now empty...")
                }
                ForEach(records) { record in
                    RecordRow(record: record).environmentObject(self.store)
                }
            }
            Spacer()
            Button {
                isPresented.toggle()
            } label: {
                Image(systemName: "plus")
            }
            .fullScreenCover(isPresented: $isPresented, content: {IntakeAmountView().environmentObject(self.store)})
        }
    }
}
