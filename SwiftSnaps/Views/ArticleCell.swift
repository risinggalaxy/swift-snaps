//
//  ArticleCell.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import SwiftUI

struct ArticleCell: View {
    
    let article: Article
    
    var body: some View {
        HStack(alignment: .top) {
            if let imageURL = URL(string: article.urlToImage ?? "") {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                        .frame(maxWidth: 100, maxHeight: 100)
                        .clipShape(RoundedRectangle(cornerSize: CGSize(width: 10, height: 10)))
                        .clipped()
                } placeholder: {
                    ProgressView("Loading...")
                        .frame(maxWidth: 100, maxHeight: 100)
                }
            }
            VStack(alignment: .leading, spacing: 5, content: {
                Text(article.title)
                    .fontWeight(.bold)
                Text(article.description ?? "")
                Spacer().frame(height: 10)
                Text(article.author ?? "")
                Text(article.publishedAt)
                    .font(.system(size: 10))
            })
        }
    }
}

#Preview {
    ArticleCell(article: .mock)
}
