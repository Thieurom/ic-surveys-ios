//
//  SurveyView.swift
//  Survey
//
//  Created by Doan Thieu on 21/11/2022.
//

import SharedModels
import Styleguide
import SwiftUI

public struct SurveySummaryView: View {

    let survey: Survey

    public init(survey: Survey) {
        self.survey = survey
    }

    public var body: some View {
        ZStack {
            background
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 16.0) {
                Text(survey.title)
                    .adaptiveFont(.neuzeitHeavy, size: 34.0)
                    .foregroundColor(.white)

                Text(survey.description)
                    .adaptiveFont(.neuzeitBook, size: 17.0)
                    .foregroundColor(.white.opacity(0.7))

                Spacer()

                HStack {
                    Spacer()

                    Button(action: {
                        // TODO: Navigate to Survey questions
                    }, label: {
                        Text("Start Survey")
                    })
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding(.bottom, 20.0)
            }
            .padding(.horizontal, 20.0)
        }
    }
}

extension SurveySummaryView {

    private var background: some View {
        AsyncImage(url: survey.coverImageURL) { phase in
            switch phase {
            case let .success(image):
                image
                    .resizable()
                    .overlay(OverlayView(colors: [.black.opacity(0.1), .black.opacity(0.5)]))
                    .background(Color.black)
            default:
                EmptyView()
            }
        }
    }
}

#if DEBUG
struct SurveySummaryView_Previews: PreviewProvider {

    static var previews: some View {
        SurveySummaryView(survey: .sampleData[0])
    }
}
#endif
