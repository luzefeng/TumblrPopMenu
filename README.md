# TumblrPopMenu
模仿tumblr的弹出菜单，效果和tumblr一样

##用法
把PopMenu文件夹拖到项目工程里
```swift
class ViewController: UIViewController, PopMenuDelegate {
    //ViewController实现PopMenuDelegate协议
    var menuView: PopMenu!
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //创建PopMenu，并添加到view
        menuView = PopMenu(frame: self.view.frame)
        menuView.delegate = self
        self.view.addSubview(menuView)
    }
    //点击显示popmenu
    @IBAction func handleTap(sender: AnyObject) {
        menuView.showMenuView()
    }
    
    //点击图标回调函数
    func didClickMenu(index: Int) {
        print("click at \(index)")
    }
```

##效果图
![](https://github.com/luzefeng/TumblrPopMenu/blob/master/Simulator%20Screen%20Shot%202016%E5%B9%B42%E6%9C%8823%E6%97%A5%20%E4%B8%8A%E5%8D%8812.20.19.png)
