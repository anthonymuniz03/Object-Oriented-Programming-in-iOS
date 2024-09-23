import UIKit

enum PaymentError: Error {
    case insufficientFunds(message: String)
    case invalidCard(message: String)
    case randomError(message: String)
}

protocol PaymentProcessor {
    func processPayment(amount: Double) throws
}

class CreditCardProcessor: PaymentProcessor {
    private var availableCredit: Double
    
    init(availableCredit: Double) {
        self.availableCredit = availableCredit
    }
    
    func processPayment(amount: Double) throws {
        
        let isValidCard = Bool.random() // Made it random so that it can either be true or false :)
        let justAnError = Bool.random() // Just a random error that'll sometimes happen
        
        if !isValidCard {
            throw PaymentError.invalidCard(message: "Not a valid credit card")
        }
        
        if !justAnError {
            throw PaymentError.randomError(message: "Something went wrong")
        }
        
        if amount > availableCredit {
            throw PaymentError.insufficientFunds(message: "Transaction failed: Insufficient credit")
        }
        
        availableCredit -= amount
        print("Credit payment of: $\(amount) - Successful! - Remainder: $\(availableCredit)")
    }
}

class CashProcessor: PaymentProcessor {
    private var availableCash: Double
    
    init(availableCash: Double) {
        self.availableCash = availableCash
    }
    
    func processPayment(amount: Double) throws {
        
        let justAnError = Bool.random()
        
        if !justAnError {
            throw PaymentError.randomError(message: "Something went wrong")
        }
        
        if amount > availableCash {
            throw PaymentError.insufficientFunds(message: "Insufficient funds")
        }
        
        availableCash -= amount
        print("Cash payment of: $\(amount) - Successful! - Remaining balance: $\(availableCash)")
    }
}

func processPayments() {
    let creditCardProcessor = CreditCardProcessor(availableCredit: 550.00)
    let cashProcessor = CashProcessor(availableCash: 250.00)
    
    let payments: [(PaymentProcessor, Double)] = [
        (creditCardProcessor, 320.00),
        (cashProcessor, 50.00),
        (creditCardProcessor, 250.00),
        (cashProcessor, 201.00)
    ]
    
    for (processor, amount) in payments {
        do {
            try processor.processPayment(amount: amount)
        } catch PaymentError.insufficientFunds(let message) {
            print("PAYMENT FAILED: \(message)")
        } catch PaymentError.invalidCard(let message) {
            print("PAYMENT FAILED: \(message)")
        } catch PaymentError.randomError(let message) {
            print("PAYMENT FAILED: \(message)")
        } catch {
            print("PAYMENT FAILED: \(error.localizedDescription)")
        }
    }
}

processPayments()
