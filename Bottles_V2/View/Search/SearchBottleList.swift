import SwiftUI
import CoreLocation

struct SearchBottleList: View {
    // 검색어를 저장하는 변수
    var bottleName: String
    // ActionSheet
    @State private var showingActionSheet: Bool = false
    @State private var selection = "이름순"
    // 북마크 알림
    @State var bookMarkAlarm: Bool = false
    @State var bookMark: Bool = false
    
    @Binding var root: Bool
    
    // Server Data
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @EnvironmentObject var shopDataStore: ShopDataStore

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    // 정렬 기준 선택 버튼
                    Button {
                        showingActionSheet = true
                    } label: {
                        HStack {
                            Text("\(selection)")
                                .font(.bottles14)
                            Image(systemName: "chevron.down")
                                .font(.system(size: 14))
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.trailing, 20)
                }
                // 검색어를 포함하는 Data가 없을 경우
                if bottleDataStore.bottleSearchResult(bottleName: bottleName).isEmpty {
                    Text("검색 결과가 없습니다.")
                        .font(.bottles14)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 10)
                    Spacer()
                } else {
                    // TODO: 서버 Bottle 데이터 연결
                    ScrollView {
                        ForEach(shopDataStore.sortBottleData(bottleDataStore.bottleSearchResult(bottleName: bottleName), selection: selection)) { bottle in
                            SearchBottleListCell(bottleInfo: bottle, shopInfo: shopDataStore.getMatchedShopData(shopID: bottle.shopID), bookMark: $bookMark, bookMarkAlarm: $bookMarkAlarm, root: $root)
                            Divider()
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            // MARK: - 정렬 ActionSheet
            .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                // TODO: 각 버튼 별로 정렬 액션 추가해야함
                Button("이름순") {
                    selection = "이름순"
                }
                
                Button("거리순") {
                    selection = "거리순"
                }
                
                Button("낮은 가격순") {
                    selection = "낮은 가격순"
                }
                
                Button("높은 가격순") {
                    selection = "높은 가격순"
                }
            }
            
            if bookMarkAlarm {
                HStack{
                    Image(bookMark ? "BookMark.fill" : "BookMark")
                    Text(bookMark ? "북마크가 완료되었습니다." : "북마크가 해제되었습니다.")
                        .foregroundColor(.black)
                        .font(.bottles11)
                    
                }
                .zIndex(1)
                .transition(.opacity.animation(.easeIn))
                .background{
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 300, height: 30)
                        .foregroundColor(.gray_f7)
                }
                .offset(y: (UIScreen.main.bounds.height/4))
            }
        }
    }
}

struct SearchBottleListCell: View {
    // 필터링된 Bottle의 정보를 저장하는 변수
    @EnvironmentObject var userStore: UserStore
    var bottleInfo: BottleModel
    // Shop의 정보를 저장하는 변수
    var shopInfo: ShopModel
    // 북마크 알림
    @Binding var bookMark: Bool
    @Binding var bookMarkAlarm: Bool
    
    @State var destination: Destination?
    @Binding var root: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            // 이미지를 누르면 Bottle Detail View로 이동
            NavigationLink(destination: {
                BottleView(bottleData: bottleInfo)
            }) {
                // Bottle 이미지
                AsyncImage(url: URL(string: bottleInfo.itemImage)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128)
                        .cornerRadius(12)
                } placeholder: {
                    Image("ready_image")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 128, height: 128)
                        .cornerRadius(12)
                }
                .background(Color.gray_f7)
                .cornerRadius(12)
                .frame(height: 128)
                .padding(.horizontal)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                // Bottle 이름
                Text(bottleInfo.itemName)
                    .font(.bottles14)
                    .fontWeight(.medium)
                    .multilineTextAlignment(.leading)
                // Bottle 가격
                Text("\(bottleInfo.itemPrice)원")
                    .font(.bottles18)
                    .bold()
                // 해당 Bottle을 판매하는 Shop으로 이동하는 버튼
                
                NavigationLink(destination: {
                    BottleShopView(bottleShop: shopInfo)
                }) {
                    HStack {
                        Image("Maptabfill")
                            .resizable()
                            .frame(width: 14, height: 17)
                        // Shop 이름
                        Text(shopInfo.shopName)
                            .font(.bottles14)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                            .multilineTextAlignment(.leading)
                    }
                }
               
                Spacer()
            }
            .padding(.top, 10)
            
            Spacer()
            VStack {
                Button(action: {
                    withAnimation(.easeIn(duration: 1)) {
                        bookMark.toggle()
                        bookMarkAlarm.toggle()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        withAnimation(.easeIn(duration: 1)) {
                            bookMarkAlarm.toggle()
                        }
                    }
                    
                    if compareMyFollowBottleID(bottleInfo.id) == true {
                        bookMark = false
                        userStore.deleteFollowItemId(bottleInfo.id)
                    }

                    if compareMyFollowBottleID(bottleInfo.id) == false {
                        bookMark = true
                        userStore.addFollowItemId(bottleInfo.id)
                    }
                    
                }) {
                    Image(compareMyFollowBottleID(bottleInfo.id) ? "BookMark.fill" : "BookMark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 18)
                        .padding(.horizontal, 10)
                }
                Spacer()
            }
            .font(.title2)
            .padding()
            .padding(.top, -5)
        }
        .frame(minHeight: 130, maxHeight: 300)
        .padding(.vertical, 5)
    }
    
    func compareMyFollowBottleID(_ bottleId: String) -> Bool {
        return (userStore.user.followItemList.filter { $0 == bottleId }.count != 0) ? true : false
    }
}

//struct SearchBottleList_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack {
//            SearchBottleList()
//        }
//    }
//}
