//
//  FivePointsRatingView.swift
//  Survey
//
//  Created by Doan Thieu on 22/11/2022.
//

import Styleguide
import SwiftUI

struct FivePointsRatingView: View {

    enum RatingStyle {

        case heart
        case thumbUp
        case star
    }

    let style: RatingStyle
    @Binding var value: Int

    var body: some View {
        HStack(spacing: 12.0) {
            ForEach(0..<5) { index in
                Text(style.icon)
                    .adaptiveFont(.neuzeitHeavy, size: 34)
                    .opacity(index < value ? 1.0 : 0.5)
                    .onTapGesture {
                        value = index + 1
                    }
            }
        }
    }
}

extension FivePointsRatingView.RatingStyle {

    var icon: String {
        switch self {
        case .heart: return "❤️"
        case .thumbUp: return "👍🏻"
        case .star: return "⭐️"
        }
    }
}

#if DEBUG
struct FivePointsRatingView_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 20.0) {
            FivePointsRatingView(style: .star, value: .constant(2))
            FivePointsRatingView(style: .thumbUp, value: .constant(3))
            FivePointsRatingView(style: .heart, value: .constant(4))
        }
    }
}
#endif
