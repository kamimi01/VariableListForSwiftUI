//
//  ContentView.swift
//  VariableListForSwiftUI
//
//  Created by Mika Urakawa on 2021/09/04.
//

import SwiftUI

struct ContentView: View {
    
    private let testData = ["食べ物": ["明太子パスタ", "ショートケーキ", "プロシュート", "パウンドケーキ"], "飲み物": ["コーラ", "ルイボスティー"]]
    
    @State private var selection: Set<String> = []

    var body: some View {
        let keys: [String] = testData.map { $0.key }
        let values: [[String]] = keys.compactMap { testData[$0] }
        
        VStack {
            List {
                ForEach(keys.indices) { keyIndex in
                    Section(header: sectionHeader(title: keys[keyIndex], isExpanded: self.selection.contains(keys[keyIndex]))) {
                        
                        if self.selection.contains(keys[keyIndex]) {
                            ForEach(values[keyIndex].indices) { valueIndex in
                                Text(values[keyIndex][valueIndex])
                                    .foregroundColor(Color.black)
                            }
                        }
                    }
                }
                
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}

extension ContentView {
    private func sectionHeader(title: String, isExpanded: Bool) -> some View {
        Button(action: {self.selectDeselect(selectedSection: title)}) {
            VStack {
                HStack {
                    Text(title)
                    
                    Spacer()
                    
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
                
                if !isExpanded {
                    Divider()
                } else {
                    Divider()
                        .frame(height: 0)
                }
            }
        }
        .foregroundColor(Color.gray)
    }
    
    private func selectDeselect(selectedSection: String) {
        if selection.contains(selectedSection) {
            selection.remove(selectedSection)
        } else {
            selection.insert(selectedSection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
