import UIKit

class Product: CustomStringConvertible {
    var name: String
    var price: Double
    var quantity: Int
    
    var description: String {
        return "Product(name: \(name), price: \(price), quantity: \(quantity))"
    }
    
    init(name: String, price: Double, quantity: Int) {
        self.name = name
        self.price = price
        self.quantity = quantity
    }
}

protocol DiscountStrategy {
    func applyDiscount(to total: Double) -> Double
}

class NoDiscountStrategy: DiscountStrategy {
    func applyDiscount(to total: Double) -> Double {
        return total
    }
}

class PercentageDiscountStrategy: DiscountStrategy {
    private let discountPercentage: Double
    
    init(percentage: Double) {
        self.discountPercentage = percentage
    }
    
    func applyDiscount(to total: Double) -> Double {
        return total - (total * discountPercentage / 100)
    }
}

class ShoppingCartSingleton {
    static var sharedInstance = ShoppingCartSingleton()
    
    var shoppingCollection: [Product] = []
    
    var discountStrategy: DiscountStrategy = NoDiscountStrategy()
    
    func addProduct(product: Product, quantity: Int) {
        if let index = shoppingCollection.firstIndex(where: { productInArray in productInArray.name == product.name }) {
            shoppingCollection[index].quantity += quantity
        } else {
            let newProduct = Product(name: product.name, price: product.price, quantity: quantity)
            shoppingCollection.append(newProduct)
        }
    }
    
    func removeProduct(product: Product) {
        if let index = shoppingCollection.firstIndex(where: {productInArray in productInArray.name == product.name}) {
            shoppingCollection.remove(at: index)
        }
            
    }
    
    func clearCart() {
        shoppingCollection.removeAll()
    }
    
    func getTotalPrice() -> Double {
        let total = shoppingCollection.reduce(0) { total, product in
            total + (product.price * Double(product.quantity))
        }
        return discountStrategy.applyDiscount(to: total)
    }
    
}



let cart = ShoppingCartSingleton.sharedInstance

var apple = Product(name: "Apple", price: 1.04, quantity: 0)
var oranges = Product(name: "Orange", price: 1.20, quantity: 0)
var peaches = Product(name: "Peaches", price: 1.02, quantity: 0)

cart.addProduct(product: apple, quantity: 3)
cart.addProduct(product: oranges, quantity: 2)
print(cart.shoppingCollection)

print("-----------------------------") // Separator

cart.removeProduct(product: oranges)
print(cart.shoppingCollection)

print("-----------------------------") // Separator

cart.clearCart()
print("Making sure it has been emptied \(cart.shoppingCollection)")

print("-----------------------------") // Separator

cart.addProduct(product: peaches, quantity: 5)
cart.addProduct(product: apple, quantity: 3)
print(cart.shoppingCollection)
print(cart.getTotalPrice()) // Without the format
print(String(format: "%.2f", cart.getTotalPrice())) // Didn't like how it was formatted so I found this as a solution!

print("-----------------------------") // Separator

// Using discount strategy

cart.discountStrategy = PercentageDiscountStrategy(percentage: 10)
print(String(format: "%.2f", cart.getTotalPrice()))

print("-----------------------------") // Separator
// Removing discount
cart.discountStrategy = NoDiscountStrategy()
print(String(format: "%.2f", cart.getTotalPrice()))

cart.clearCart()
