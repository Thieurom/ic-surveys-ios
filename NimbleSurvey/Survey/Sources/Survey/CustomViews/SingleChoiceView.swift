//
//  SingleChoiceView.swift
//  Survey
//
//  Created by Doan Thieu on 23/11/2022.
//

import Styleguide
import SwiftUI

struct SingleChoiceView: View {

    let choices: [String]
    @Binding var selectedChoice: String

    var body: some View {
        PickerView(data: choices, selection: $selectedChoice)
    }
}

#if DEBUG
struct SingleChoiceView_Previews: PreviewProvider {

    static var previews: some View {
        ZStack {
            Color.gray
                .ignoresSafeArea()

            SingleChoiceView(
                choices: ["Very fulfilled", "Somewhat fulfilled", "Somewhat unfulfilled"],
                selectedChoice: .constant("Somewhat fulfilled")
            )
        }
    }
}
#endif
