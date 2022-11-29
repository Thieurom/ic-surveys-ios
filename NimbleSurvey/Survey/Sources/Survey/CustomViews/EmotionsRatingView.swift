//
//  EmotionsRatingView.swift
//  Survey
//
//  Created by Doan Thieu on 23/11/2022.
//

import Styleguide
import SwiftUI

struct EmotionsRatingView: View {

    enum Emotion: Int, Equatable, CaseIterable {

        case angry = 1
        case frowning
        case neutral
        case slightlySmiling
        case smiling
    }

    @Binding var value: Emotion

    var body: some View {
        HStack(spacing: 12.0) {
            ForEach(Emotion.allCases, id: \.rawValue) { emotion in
                Text(emotion.icon)
                    .adaptiveFont(.neuzeitHeavy, size: 34)
                    .opacity(value == emotion ? 1.0 : 0.5)
                    .onTapGesture {
                        value = emotion
                    }
            }
        }
    }
}

extension EmotionsRatingView.Emotion {

    var icon: String {
        switch self {
        case .angry: return "😡"
        case .frowning: return "😕"
        case .neutral: return "😐"
        case .slightlySmiling: return "🙂"
        case .smiling: return "😄"
        }
    }
}

#if DEBUG
struct EmotionsRatingView_Previews: PreviewProvider {

    static var previews: some View {
        VStack(spacing: 20.0) {
            EmotionsRatingView(value: .constant(.angry))
            EmotionsRatingView(value: .constant(.neutral))
            EmotionsRatingView(value: .constant(.smiling))
        }
    }
}
#endif
