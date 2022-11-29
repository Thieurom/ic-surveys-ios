//
//  Survey.swift
//  SharedModels
//
//  Created by Doan Thieu on 22/11/2022.
//

import Foundation

public struct Survey: Equatable {

    public let title: String
    public let description: String
    public let coverImageURL: URL?

    public init(title: String, description: String, coverImageURL: URL? = nil) {
        self.title = title
        self.description = description
        self.coverImageURL = coverImageURL
    }
}

extension Survey {

    public static let sampleData: [Survey] = [
        .init(
            title: "Working from home Check-In",
            description: "We would like to know how you feel about our work from home",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        ),
        .init(
            title: "Career training and development",
            description: "We would like to know what are your goals and skills you wanted",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        ),
        .init(
            title: "Inclusion and belonging",
            description: "Building a workplace culture that prioritizes belonging and inclusion",
            coverImageURL: URL(string: "https://dhdbhh0jsld0o.cloudfront.net/m/1ea51560991bcb7d00d0_l")
        )
    ]
}
