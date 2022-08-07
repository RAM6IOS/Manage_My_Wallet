//
//   CategoriesListView.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 6/8/2022.
//

import SwiftUI

struct CategoriesListView: View {
    
    @State private var name = ""
    @State private var color = Color.red
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)],
        animation: .default)
    private var categories: FetchedResults<TransactionCategory>
   
    @Binding var selectedCategories: Set<TransactionCategory>
    var body: some View {
        Form{
            Section(header: Text("Select a category")){
                ForEach(categories) { category in
                    Button{
                        if selectedCategories.contains(category) {
                            selectedCategories.remove(category)
                        } else {
                            selectedCategories.insert(category)
                        }
                    } label: {
                        
                    
                    HStack(spacing: 12) {
                        if let data = category.colorData, let uiColor = UIColor.color(data: data) {
                            let color = Color(uiColor)
                            Spacer()
                                .frame(width: 30, height: 10)
                                .background(color)
                        }
                        Text(category.name ?? "")
                        Spacer()
                        if selectedCategories.contains(category) {
                        Image(systemName: "checkmark")
                        }
                    }
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { i in
                        moc.delete(categories[i])
                    }
                    try? moc.save()
                }
                
            }
            Section(header: Text("Create a category")) {
                TextField("Name", text: $name)
                ColorPicker("Color", selection: $color)
                
                Button(action: handleCreate) {
                    HStack {
                        Spacer()
                        Text("Create")
                            .foregroundColor(.white)
                        Spacer()
                    }
                    .padding(.vertical, 8)
                    .background(Color.blue)
                    .cornerRadius(5)
                }.buttonStyle(PlainButtonStyle())
                
               
            }
        }
    }
    private func handleCreate() {
       
        
        let category = TransactionCategory(context: moc)
        category.name = name
        category.colorData = UIColor(color).encode()
        category.timestamp = Date()
        
        // this will hide your error
        try? moc.save()
        self.name = ""
    }
}

struct CategoriesListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesListView( selectedCategories: .constant(.init()))
    }
}
