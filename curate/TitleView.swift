//
//  TitleView.swift
//  curate
//
//  Created by Cameron Chiu on 6/23/23.
//

import SwiftUI

struct TitleView: View {
    var body: some View {
        Image("curate_title")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(.horizontal, 130)
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
