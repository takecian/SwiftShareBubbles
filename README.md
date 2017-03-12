# SwiftShareBubbles
Animated Social share buttons control for iOS written in Swift.
This library is inspired [AAShareBubbles](https://github.com/mixdesign/AAShareBubbles). 

![ShareBubbles1](./Resource/ShareBubbles1.gif)

## Requirements

iOS 8.0 or later, written in Swift3.

## Installation

### Carthage

SwiftRoutes is compatible with [Carthage](https://github.com/Carthage/Carthage). Add it to your `Cartfile`:

```ruby
github "takecian/SwiftShareBubbles"
```

## Usage

1. Instantiate SwiftShareBubbles, specify center position and radius of Circle.
1. Choose social buttons to be shown.
1. Set delegate
1. Call show method.

```
class ViewController: UIViewController, SwiftShareBubblesDelegate {

    var bubbles: SwiftShareBubbles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bubbles = SwiftShareBubbles(point: CGPoint(x: view.frame.width / 2, y: view.frame.height / 2), radius: 100, in: view)
        bubbles?.showBubbleTypes = [Bubble.twitter, Bubble.line, Bubble.safari]
        bubbles?.delegate = self
    }

    func bubblesTapped(bubbles: SwiftShareBubbles, bubbleId: Int) {
        if let bubble = Bubble(rawValue: bubbleId) {
            print("\(bubble)")
            switch bubble {
            case .facebook:
                break
            case .twitter:
                if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                    guard let composer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) else { return }
                    composer.setInitialText("test test")
                    present(composer, animated: true, completion: nil)
                }
                break
            case .line:
                break
            default:
                break
            }
        } else {
            // custom case
        }
    }

    func bubblesDidHide(bubbles: SwiftShareBubbles) {
    }

    @IBAction func buttonTapped(_ sender: Any) {
        bubbles?.show()
    }
}

```

![ShareBubbles2](./Resource/ShareBubbles2.gif)

## Social buttons

* facebook
* Twitter
* LINE
* google plus
* Youtube
* Instagram
* Pintereset
* Whatsapp
* Linkedin
* Weibo
* Safari 


## License

MIT