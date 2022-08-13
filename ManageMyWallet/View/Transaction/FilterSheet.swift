//
//  FilterSheet.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 11/8/2022.
//

import SwiftUI

struct FilterSheet: View {
    /*
    let didSaveFilters: (Set<TransactionCategory>) -> ()
   @State var selectedCategories: Set<TransactionCategory>
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)],
        animation: .default)
    private var categories: FetchedResults<TransactionCategory>
    
    //@State var selectedCategories : Set<TransactionCategory>
 */
    
 @State var selectedCategories: Set<TransactionCategory>
 let didSaveFilters: (Set<TransactionCategory>) -> ()
 
 @Environment(\.managedObjectContext) private var viewContext

 @FetchRequest(
     sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)],
     animation: .default)
 private var categories: FetchedResults<TransactionCategory>
 @Environment(\.presentationMode) var presentationMode
     
    var body: some View {
        NavigationView {
            Form {
                ForEach(categories) { category in
                    Button {
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
                            
                                .foregroundColor(Color(.label))
                            Spacer()
                            
                            if selectedCategories.contains(category) {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }.navigationTitle("Select filters")
                .navigationBarItems(trailing: saveButton)
        }
    }
    private var saveButton: some View {
        Button {
            didSaveFilters(selectedCategories)
            presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Save")
        }

    }
}

