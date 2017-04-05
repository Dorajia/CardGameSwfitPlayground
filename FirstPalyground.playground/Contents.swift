import UIKit
import PlaygroundSupport


let hostView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 500))
hostView.backgroundColor = .black
PlaygroundPage.current.liveView = hostView

var TagList: [String] = ["1","1","2","2","3","3","4","4","5"]
var image1: UIImageView!
var image2: UIImageView!
var image3: UIImageView!
var image4: UIImageView!
var image5: UIImageView!
var image6: UIImageView!
var image7: UIImageView!
var image8: UIImageView!
var image9: UIImageView!
var showingBack = true
var back = UIImage(named: "playingCard") as UIImage!
var flipnumber  = 1
var imageViewAarry = Array<UIImageView>()
var counter = 9

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}


func makeImageWith(identifier: String) -> UIImageView {
    let defaultImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 320/3, height: 500/3))
    defaultImageView.image = back
    defaultImageView.tag = 0
    defaultImageView.accessibilityIdentifier = identifier
    return defaultImageView
}


let makeView = { (color: UIColor) -> UIView in
    let view = UIView(frame: .zero)
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = color
    return view
}


func createImage(taglist: Array<String>)
{
    image1 = makeImageWith(identifier : taglist[0])
    image2 = makeImageWith(identifier : taglist[1])
    image3 = makeImageWith(identifier : taglist[2])
    image4 = makeImageWith(identifier : taglist[3])
    image5 = makeImageWith(identifier : taglist[4])
    image6 = makeImageWith(identifier : taglist[5])
    image7 = makeImageWith(identifier : taglist[6])
    image8 = makeImageWith(identifier : taglist[7])
    image9 = makeImageWith(identifier : taglist[8])
    imageViewAarry = [image1,image2,image3,image4,image5,image6,image7,image8,image9]
    let firstrow = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 320/3, height: 500/3))
    firstrow.distribution = .fillEqually
    firstrow.spacing = 0.3

    firstrow.addArrangedSubview(image1)
    firstrow.addArrangedSubview(image2)
    firstrow.addArrangedSubview(image3)
    
    
    let SecondRow = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 320/3, height: 500/3))
    SecondRow.distribution = .fillEqually
    SecondRow.spacing = 0.3
    SecondRow.addArrangedSubview(image4)
    SecondRow.addArrangedSubview(image5)
    SecondRow.addArrangedSubview(image6)
    
    let ThirdRow = UIStackView(frame: CGRect(x: 0.0, y: 0.0, width: 320/3, height: 500/3))
    ThirdRow.distribution = .fillEqually
    ThirdRow.spacing = 0.3
    ThirdRow.addArrangedSubview(image7)
    ThirdRow.addArrangedSubview(image8)
    ThirdRow.addArrangedSubview(image9)

    let buttonStackView = UIStackView(arrangedSubviews: [firstrow, SecondRow, ThirdRow])
    buttonStackView.axis = .vertical
    buttonStackView.distribution = .fillEqually
    buttonStackView.spacing = 0.3

    let hostStackView = UIStackView(arrangedSubviews: [ buttonStackView])
    hostStackView.frame = hostView.bounds
    hostStackView.axis = .vertical
    hostStackView.spacing = 0.3
    hostView.addSubview(hostStackView)
}

TagList.shuffle()
createImage(taglist:TagList)

class backResponder : NSObject {
    var uiImageview: UIImageView
    init(uiImageview: UIImageView) {
        self.uiImageview = uiImageview
    }
    func action() {
        
        print(flipnumber)
        if (uiImageview.image == back && flipnumber < 3) {
            let identifier = uiImageview.accessibilityIdentifier
            var image: UIImage!
            switch identifier! {
            case "1":
                image = UIImage(named: "blackheart2")! as UIImage
                
            case "2":
                image = UIImage(named: "blackheart4")! as UIImage
                
            case "3":
                image = UIImage(named: "blackheart11")! as UIImage
            case "4":
                image = UIImage(named: "diamonds12")! as UIImage
            case "5":
                image = UIImage(named: "joker")! as UIImage

            default:
                image = UIImage(named: "playingCard")! as UIImage
                
            }
            UIView.transition(with: uiImageview,
                              duration: 1,
                              options: UIViewAnimationOptions.transitionFlipFromLeft,
                              animations: {
                              self.uiImageview.image = image},
                              completion: nil)
         flipnumber = flipnumber + 1
         uiImageview.tag = 1
            
        }else if(flipnumber == 3){
            var imageViewResult = Array<UIImageView>()
            var item : UIImageView!
            for item in imageViewAarry
            {
                let tag = item.tag
                if(tag == 1 ){
                    imageViewResult.append(item)
                }
                item.tag = 0
            }
            
            if(imageViewResult.count > 1 && imageViewResult[0].accessibilityIdentifier == imageViewResult[1].accessibilityIdentifier){
                var item3 : UIImageView!
                for item3 in imageViewResult{
                    UIView.animate(withDuration: 0.5, delay: 0.3, options: UIViewAnimationOptions.curveEaseOut, animations: {
                        item3.alpha = 0.0
                    }, completion: nil)
                }
                counter = counter - 2

            }else if(imageViewResult.count > 1 && imageViewResult[0].accessibilityIdentifier != imageViewResult[1].accessibilityIdentifier){
                var item2 : UIImageView!
                for item2 in imageViewResult{
                    UIView.transition(with: item2,
                                      duration: 1,
                                      options: UIViewAnimationOptions.transitionFlipFromRight,
                                      animations: {
                                        item2.image = back},
                                      completion: nil)
                }
            }
            flipnumber = 1
        }
        
    }
}


let responderback1 = backResponder(uiImageview: image1)
let singleTapback1 = UITapGestureRecognizer(target: responderback1, action: #selector(backResponder.action))
singleTapback1.numberOfTapsRequired = 1
image1.addGestureRecognizer(singleTapback1)
image1.isUserInteractionEnabled = true

let responderback2 = backResponder(uiImageview: image2)
let singleTapback2 = UITapGestureRecognizer(target: responderback2, action: #selector(backResponder.action))
singleTapback2.numberOfTapsRequired = 1
image2.addGestureRecognizer(singleTapback2)
image2.isUserInteractionEnabled = true

let responderback3 = backResponder(uiImageview: image3)
let singleTapback3 = UITapGestureRecognizer(target: responderback3, action: #selector(backResponder.action))
singleTapback3.numberOfTapsRequired = 1
image3.addGestureRecognizer(singleTapback3)
image3.isUserInteractionEnabled = true

let responderback4 = backResponder(uiImageview: image4)
let singleTapback4 = UITapGestureRecognizer(target: responderback4, action: #selector(backResponder.action))
singleTapback4.numberOfTapsRequired = 1
image4.addGestureRecognizer(singleTapback4)
image4.isUserInteractionEnabled = true

let responderback5 = backResponder(uiImageview: image5)
let singleTapback5 = UITapGestureRecognizer(target: responderback5, action: #selector(backResponder.action))
singleTapback5.numberOfTapsRequired = 1
image5.addGestureRecognizer(singleTapback5)
image5.isUserInteractionEnabled = true

let responderback6 = backResponder(uiImageview: image6)
let singleTapback6 = UITapGestureRecognizer(target: responderback6, action: #selector(backResponder.action))
singleTapback6.numberOfTapsRequired = 1
image6.addGestureRecognizer(singleTapback6)
image6.isUserInteractionEnabled = true

let responderback7 = backResponder(uiImageview: image7)
let singleTapback7 = UITapGestureRecognizer(target: responderback7, action: #selector(backResponder.action))
singleTapback7.numberOfTapsRequired = 1
image7.addGestureRecognizer(singleTapback7)
image7.isUserInteractionEnabled = true

let responderback8 = backResponder(uiImageview: image8)
let singleTapback8 = UITapGestureRecognizer(target: responderback8, action: #selector(backResponder.action))
singleTapback8.numberOfTapsRequired = 1
image8.addGestureRecognizer(singleTapback8)
image8.isUserInteractionEnabled = true

let responderback9 = backResponder(uiImageview: image9)
let singleTapback9 = UITapGestureRecognizer(target: responderback9, action: #selector(backResponder.action))
singleTapback9.numberOfTapsRequired = 1
image9.addGestureRecognizer(singleTapback9)
image9.isUserInteractionEnabled = true

hostView
