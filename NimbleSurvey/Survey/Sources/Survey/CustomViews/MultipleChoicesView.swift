//
//  MultipleChoicesView.swift
//  Survey
//
//  Created by Doan Thieu on 24/11/2022.
//

import Styleguide
import SwiftUI

struct MultipleChoicesView<S, ID>: View where S: StringProtocol, ID: Hashable {

    let data: [S]
    private var id: KeyPath<S, ID>
    @Binding var selections: [S]

    init(data: [S], id: KeyPath<S, ID>, selections: Binding<[S]>) {
        self.data = data
        self.id = id
        self._selections = selections
    }

    var body: some View {
        VStack {
            ForEach(data, id: \.self) { item in
                Row(
                    title: item,
                    checked: Binding(
                        get: { selections.contains(item) },
                        set: { newValue in
                            if newValue {
                                if let newItem = data.first(where: { $0 == item }) {
                                    selections.append(newItem)
                                }
                            } else {
                                selections.removeAll(where: { $0 == item })
                            }
                        }
                    )
                )

                if let index = data.firstIndex(where: { $0 == item }), index != data.count - 1 {
                    Divider()
                        .frame(height: 1.0)
                        .background(Color.white)
                }
            }
        }
    }
}

extension MultipleChoicesView {

    struct Row<S: StringProtocol>: View {

        let title: S
        @Binding var checked: Bool

        var body: some View {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                checked ? Asset.Images.radioChecked.swiftUIImage : Asset.Images.radioUnchecked.swiftUIImage
            }
            .padding(.vertical, 8.0)
            .onTapGesture {
                checked.toggle()
            }
        }
    }
}

#if DEBUG
struct MultipleChoicesView_Previews: PreviewProvider {

    @State static var selections = ["Choice 1", "Choice 2"]

    static var previews: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()

            MultipleChoicesView(
                data: ["Choice 1", "Choice 2", "Choice 3"],
                id: \.self,
                selections: $selections
            )
            .padding(.horizontal, 60.0)
        }
    }
}
#endif
