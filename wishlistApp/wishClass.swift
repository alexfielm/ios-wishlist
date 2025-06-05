import Foundation
import SwiftData

@Model //model indica que será capaz de guardar datos utilizando SwiftData
class Wish {
    var wishName: String
    //init es el inicializador de la clase, aca debemos poner valores para cada propiedad de la clase
    init(wishName: String) {
        self.wishName = wishName
    }
}
