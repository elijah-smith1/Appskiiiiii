import SwiftUI
struct VendorView: View {
    @StateObject private var viewModel = VendorViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Picker(selection: $viewModel.selectedTab, label: Text("Categories")) {
                    ForEach(0..<viewModel.categories.count) { index in
                        Text(viewModel.categories[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                ForEach(viewModel.categories, id: \.self) { category in
                    VendorCategoryView(category: category, vendors: viewModel.sampleVendors.filter { $0.category == category })
                }
            }
            .padding(.horizontal)
        }
    }
}

struct VendorCategoryView: View {
    var category: String
    var vendors: [Vendor]

    var body: some View {
        VStack(alignment: .leading) {
            Text(category)
                .font(.title2)
                .padding(.leading)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(vendors) { vendor in
                        NavigationLink(destination: VendorDetailView(vendor: vendor)) {
                            VendorItemView(vendor: vendor)
                        }
                    }
                }
                .padding()
            }
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
    }
}


    

struct VendorItemView: View {
    var vendor: Vendor

    var body: some View {
        VStack {
            vendor.image
                .resizable()
                .frame(width: 140, height: 140)
                .padding()

            Text(vendor.name)
            
            Text(vendor.category)
                .font(.subheadline)
                .foregroundColor(.gray)
            HStack{
                Text(vendor.school)
                    .font(.subheadline)
                    .foregroundColor(.black)
                Text(vendor.Open)
                    .font(.subheadline)
                    .foregroundColor(.black)
            
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct VendorDetailView: View {
    var vendor: Vendor

    var body: some View {
        VStack {
            vendor.image
                .resizable()
                .frame(width: 200, height: 200)
                .padding()

            Text(vendor.name)
                .font(.title)
                .padding()

            Text(vendor.category)
                .font(.subheadline)
                .foregroundColor(.gray)
            
        }
        .navigationBarTitle(vendor.name, displayMode: .inline)
    }
}

struct VendorView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            VendorView()
        }
    }
}
