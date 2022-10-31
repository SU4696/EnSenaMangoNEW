//
//  CategoryCard.swift
//  EnSena
//
//  Created by 조수연 on 2022/10/30.
//
/*
import SwiftUI

@available(iOS 13.0.0, *)
struct CategoryCard: View {
   
    var category:DictionaryCategory
    var body: some View {
        VStack {
        if #available(iOS 15.0, *) {
            AsyncImage(url: URL(string: category.image)){image in image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(alignment: .bottom){
                        Text(category.name)
                            .font(.headline)
                            .foregroundColor(.white)
                            .shadow(color: .black, radius: 3, x: 0, y: 0)
                            .frame(maxWidth:132)
                            .padding()
                    }
            } placeholder: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40, alignment: .center)
                    .foregroundColor(.white.opacity(0.7))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        }
        .frame(width:160, height: 217, alignment: .top)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.gray).opacity(0.3), Color(.gray)]), startPoint: .top, endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color.black.opacity(0.3), radius: 15, x: 0, y: 10)
    }
        
    }

struct CategoryCard_Previews: PreviewProvider {
    @available(iOS 13.0.0, *)
    static var previews: some View {
        CategoryCard(category: DictionaryCategory.all[0])
    }
}
*/
