//
//  IntakeAmountView.swift
//  Record
//
//  Created by kimjimin on 2022/06/10.
//

import SwiftUI
import RealmSwift

// 임시용으로 일단 넣음
extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}

struct IntakeAmountView: View {
    //    @EnvironmentObject var store: RecordStore
    @FocusState private var isFocused: Bool
    
    @State var Today = Date.now
    @State var large_isSelected: String = "대분류"
    @State var medium_isSelected: String = "중분류"
    @State var small_isSelected: String = "소분류"
    
    @State var unitVolum: String = "200"
    
    
    // TextField에 숫자를 표시하려면 NumberFormatter 를 사용해야 합니다
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var gridItemLayout = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    //  TODO: 카테고리가 음료일 때와 아닐 때 구분해야 함
    //  TODO: serving과 연결해서 계산해야 함 (제품당 단위 ex. 음료1캔=190ml)
    let servingCategory = ["1/3컵", "1/2컵", "1컵", "2컵", "3컵", "직접입력"]
    let categoryRate : [Double] = [0.333, 0.5, 1, 2, 3, -1] // 계산하기 쉽도록 테이블 작성
    @State var isSelected = [true, false, false, false, false, false]  // 0번이 디폴트로 눌리게 설정
    @State private var showingAlert = false // 0 g/ml 입력하면 뜨게 하는 용도
    //  TODO: 데이터베이스로부터 제품 1g당 당류 불러오기 (=sugarAmount)
    var sugarAmount = 0.37
    
    @State var serving : Double = 0 // serving: 섭취량 -> 섭취량도 저장해야하는지
    @State var buttonState : Int = 0    // 현재 선택한 카테고리명
    
    var body: some View {
        VStack{
            /*
             ZStack {
             // 위에 배경부분
             LinearGradient(gradient: Gradient(colors: [Color(hex: 0x80BBB7), Color(hex: 0x80BF88)]),
             startPoint: .top, endPoint: .bottom)
             .edgesIgnoringSafeArea(.all)
             
             HStack {
             VStack (alignment: .leading){
             Text("오렌지 주스")
             .font(.largeTitle)
             .fontWeight(.bold)
             .padding()
             
             Text("당류 \(String(format: "%.2f", sugarAmount))g")
             .font(.title2)
             .fontWeight(.bold)
             //                        Text("\(servingCategory[buttonState])")
             
             HStack {
             ZStack {
             RoundedRectangle(cornerRadius: 15)
             .fill(Color.white)
             .opacity(0.1)
             //                                    .frame(height: 60)
             .frame(width: 110, height: 60)
             .shadow(radius: 5, y: 3)
             
             TextField("섭취랴앙", value: $serving, formatter: formatter)
             .frame(width: 100, height: 60)
             
             .focused($isFocused)    // 텍스트필드를 바라보도록 활성화
             .keyboardType(.numberPad)
             .font(.title2)
             
             //                                    .background(RoundedRectangle(cornerRadius: 15)
             //                                        .fill(Color.white)
             //                                        .opacity(0.1)
             //    //                                    .frame(height: 60)
             //    //                                    .frame(width: 110, height: 60)
             //                                        .shadow(radius: 5, y: 3)
             //                                )
             }
             Text("ml")
             .font(.title2)
             .fontWeight(.bold)
             //                                .font(.title)
             
             }
             
             }
             .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 100))
             
             .foregroundColor(.white)
             
             
             
             
             
             
             VStack (alignment: .trailing){
             Image(systemName: "takeoutbag.and.cup.and.straw")
             .resizable()
             .frame(width: 100, height: 100)
             }
             }
             }
             */
            
            ZStack {
                // 위에 배경부분
                LinearGradient(gradient: Gradient(colors: [Color(hex: 0x80BBB7), Color(hex: 0x80BF88)]),
                               startPoint: .top, endPoint: .center)
                .edgesIgnoringSafeArea(.all)
                
                HStack {
                    VStack {
                        VStack {
                            HStack {
                                Text("오렌지먹은지가언젠지😭") // 최대 11글자
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                Spacer()
                            }
                                
                            
                            HStack {
                                VStack (alignment: .leading){
                                    Text("당류 \(String(format: "%.2f", sugarAmount))g")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                    HStack {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.white)
                                                .opacity(0.1)
                                                .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                                                .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                                            
                                            HStack {
                                                
                                                TextField("200",
                                                          value: $serving,
                                                          formatter: formatter)
                                                    .frame(height: 60)
                                                    .padding(.leading, 10)
                                                    .focused($isFocused)    // 텍스트필드를 바라보도록 활성화
                                                    .keyboardType(.numberPad)
                                                .font(.title2)

                                                Text("ml")
                                                    .font(.title2)
                                                    .fontWeight(.bold)
                                                    .padding(.trailing, 5)
                                                Spacer()
                                            }

                                        }.frame(width: 110, height: 60)
                                        
                                    }
                                    
                                    
                                }
//                                .padding(.leading, 20)
                                Spacer()
                                Image(systemName: "takeoutbag.and.cup.and.straw")
                                    .resizable()
                                    .frame(width: 100, height: 100)
                                    .padding(.trailing, 20)
                            }
                            
                        }
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)

                        
                    }
                }
            }
            .frame(height: 280) // 스캐치 기준 300이라 일단 이렇게함
            
            
            LazyVGrid(columns: gridItemLayout, spacing: 10) {
                ForEach((0 ..< servingCategory.count - 1), id: \.self) { num in
                    // 이전에 눌렀던 버튼을 해제한 뒤 현재 num에 대한 버튼을 활성화
                    Button {
                        // 직접입력을 눌렀다가 다른 버튼을 누르는 경우 포커스 해제
                        if isFocused { isFocused.toggle() }
                        // 이전에 눌렀던 버튼을 해제
                        self.isSelected[buttonState].toggle()
                        // 이번에 눌렀던 버튼의 index를 저장하고 버튼 활성화
                        buttonState = num
                        self.isSelected[buttonState].toggle()
                        // 각 버튼의 배수 x 개당(컵,개,덩어리) 용량 = 선택한 용량
                        serving = Double(String(format: "%.0f", categoryRate[buttonState] * Double(unitVolum)!)) ?? 0
                        print(serving)
                    } label: {
                        Text("\(servingCategory[num])")
                            .padding()
                            .foregroundColor(self.isSelected[num] ? Color.white : Color.black)
                    }
                    .frame(width: 110, height: 60)
                    .background(RoundedRectangle(cornerRadius: 15)
                    .fill(self.isSelected[num] ? Color(hex: 0x6CADA5) : Color.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5)
                                
                    )
                }
                
                Button {
                    // 직접입력
                    // 이전에 눌렀던 버튼을 해제
                    self.isSelected[buttonState].toggle()
                    buttonState = servingCategory.count - 1
                    self.isSelected[buttonState].toggle()
                    // 텍스트 필드에 대한 focus를 On
                    isFocused = true
                    print(serving)
                } label: {
                    Text("직접입력")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(Color(hex: 0x6CADA5))
                        
                }
                .frame(width: 110, height: 60)
                .background(RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 10, y: 10)
                    .shadow(color: .white.opacity(0.7), radius: 10, x: -5, y: -5))
                .overlay(RoundedRectangle(cornerRadius: 15)
                    .stroke(self.isFocused ? Color(hex: 0x6CADA5) : Color.clear, lineWidth: 2))
 
            }
            .padding(.top, 10)
            .padding(.horizontal, 10)
            // 등장과 동시에 serving에 값을 넣어준다.(디폴트로 선택한 0번 버튼의 값이 들어감)
            .onAppear {
                serving = Double(String(format: "%.0f", categoryRate[buttonState] * Double(unitVolum)!)) ?? 0
            }
            
            Spacer()
            Button {
                
                print(serving, "ml 입력받음")
                print(serving*sugarAmount, "g 설탕을 입력하기")
                
                if serving <= 0 || serving > 10000 {
                    showingAlert.toggle()
                } else {
                    saveRecord()
                }
                
//                // TODO: pop to Root
//                                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true)
            } label: {
                Text("당 \(String(format: "%.1f", serving*sugarAmount))g 추가하기")
                    .frame(width: (UIScreen.main.bounds.width)*0.9, height: 56)
                    .foregroundColor(Color.white)
//                    .padding(.horizontal, 40)
            }
            
            
            .background(RoundedRectangle(cornerRadius: 30).fill(Color(hex: 0x6CADA5)))
            .alert("범위 초과", isPresented: $showingAlert) {
                Button("넹~~") { print("힝") }
            } message: {
                Text("0~10000 사이의 값을 입력해주세용")
            }
            
        }
        
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(small_isSelected)
            }
        }
    }
}



extension IntakeAmountView {
    func saveRecord() {
        //        store.create(
        //            date: dateFormatter(date: Today),
        //            large: large_isSelected,
        //            medium: medium_isSelected,
        //            small: small_isSelected,
        //            sugar: (serving as NSString).doubleValue*sugarAmount)
    }
    
    func dateFormatter(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let converted = formatter.string(from: date)
        return converted
    }
}
