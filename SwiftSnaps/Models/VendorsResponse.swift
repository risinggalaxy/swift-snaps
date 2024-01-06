//
//  VendorsResponse.swift
//  SwiftSnaps
//
//  Created by Yasser Farahi on 04/01/2024.
//

import Foundation
import ComposableArchitecture

struct VendorsResponse: Decodable, Equatable {
    let vendors: [Vendor]
    
    enum CodingKeys: String, CodingKey {
        case sources = "sources"
    }
 
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        vendors = try container.decode([Vendor].self, forKey: .sources)
    }
}

extension VendorsResponse {
    static let mock: IdentifiedArrayOf<Vendor> = [
        Vendor(
        id: "abc-news",
        name: "ABC News",
        description: "Your trusted source for breaking news, analysis, exclusive interviews, headlines, and videos at ABCNews.com."
        ),
        Vendor(
        id: "aftenposten",
        name: "Aftenposten",
        description: "Norges ledende nettavis med alltid oppdaterte nyheter innenfor innenriks, utenriks, sport og kultur."
        ),
        Vendor(
        id: "al-jazeera-english",
        name: "Al Jazeera English",
        description: "News, analysis from the Middle East and worldwide, multimedia and interactives, opinions, documentaries, podcasts, long reads and broadcast schedule."
        ),
        Vendor(
        id: "ansa",
        name: "ANSA.it",
        description: "Agenzia ANSA: ultime notizie, foto, video e approfondimenti su: cronaca, politica, economia, regioni, mondo, sport, calcio, cultura e tecnologia."
        ),
        Vendor(
        id: "argaam",
        name: "Argaam",
        description: "ارقام موقع متخصص في متابعة سوق الأسهم السعودي تداول - تاسي - مع تغطيه معمقة لشركات واسعار ومنتجات البتروكيماويات , تقارير مالية الاكتتابات الجديده "
        ),
        Vendor(
        id: "ars-technica",
        name: "Ars Technica",
        description: "The PC enthusiast's resource. Power users and the tools they love, without computing religion."
        ),
        Vendor(
        id: "blasting-news-br",
        name: "Blasting News (BR)",
        description: "Descubra a seção brasileira da Blasting News, a primeira revista feita pelo  público, com notícias globais e vídeos independentes. Junte-se a nós e torne- se um repórter."
        ),
        Vendor(
        id: "business-insider",
        name: "business-insider",
        description: "Business Insider is a fast-growing business site with deep financial, media, tech, and other industry verticals. Launched in 2007, the site is now the largest business news site on the web."
        ),
    ]
}
