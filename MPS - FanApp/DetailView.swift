//
//  DetailView.swift
//  MPS - FanApp
//
//  Created by Christian Baltzer on 15.06.20.
//  Copyright © 2020 Christian Baltzer. All rights reserved.
//

import Foundation
import SwiftUI

struct BandView: View{
    var Band: Band
    var body: some View{
        HStack{
            HStack{
                Image(uiImage: Band.Bild)
                Text(Band.Name)
                    .font(.title)
                    .padding(.leading, 15)
                    .padding(.top, CGFloat(5))
            }
            Spacer()
            Text(Band.Homepage)
        }.padding(.top, CGFloat(5))
    }
}

