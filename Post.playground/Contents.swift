import UIKit

class Post {
    var author: String
    var content: String
    var likes: Int
    
    
    init(author: String, content: String, likes: Int) {
        self.author = author
        self.content = content
        self.likes = likes
    }
    
    func display() {
        print("Account: \(author)")
        print("Content: \(content)")
        print("Likes: \(likes)")
    }
}

func main() {
var post1 = Post(author: "Tony", content: "This is my post about me", likes: 20)
var post2 = Post(author: "Rey", content: "Have a great dat everyone", likes: 15)

    post1.display()
    print("------------------") //For a cleaner output
    post2.display()
}

main()
