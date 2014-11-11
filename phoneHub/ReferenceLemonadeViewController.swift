//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Stanley Chiang on 9/22/14.
//  Copyright (c) 2014 Stanley Chiang. All rights reserved.
//

import UIKit

class ReferenceLemonadeViewController: UIViewController {
    
    //containers
    var inventory: UIView!
    var supplies: UIView!
    var mix: UIView!
    var startSelling: UIView!
    
    //constants
    let kSixth:CGFloat = 1/6
    let kFourth:CGFloat = 1/4
    let kThird:CGFloat = 1/3
    let kHalf:CGFloat = 1/2
    
    //first container: labels
    var youHaveLabel: UILabel!
    var bank: UILabel!
    var lemonInv: UILabel!
    var iceInv: UILabel!
    
    //first container: vals
    var totalmoney:Int = 10
    var totallemons:Int = 0
    var totalIceCubes:Int = 0
    
    //second container: labels
    var step1Label: UILabel!
    var lemPriceLabel: UILabel!
    var icePriceLabel: UILabel!
    var buyLemLabel: UILabel!
    var buyIceLabel: UILabel!
    
    //second container: buttons
    var moarLemsButton: UIButton!
    var lessLemsButton: UIButton!
    var moarIceButton: UIButton!
    var lessIceButton: UIButton!
    
    //second container: vals
    var lemonCart:Int = 0
    var iceCart:Int = 0
    
    //third container: labels
    var step2Label: UILabel!
    var note3: UILabel!
    var LemLabel: UILabel!
    var IceLabel: UILabel!
    var numLemLabel: UILabel!
    var numIceLabel: UILabel!
    
    //third container: buttons
    var moreLemsButton: UIButton!
    var fewwLemsButton: UIButton!
    var moreIceButton: UIButton!
    var fewwIceButton: UIButton!
    
    //third container: vals
    var mixLemons:Int = 0
    var mixIce:Int = 0
    
    //fourth container: labels
    var step3Label: UILabel!
    var note4: UILabel!
    
    //fourth container: buttons
    var startButton: UIButton!
    var buyButton: UIButton!
    var resetButton: UIButton!
    
    //fourth container: vals
    var lemonadeRatio:Float = 0.0
    var lemonadeGroup:Int = 0
    var numCust:Int = 0
    var custPref:[Int] = [0, 0, 0]
    
    //fourth container:images
    var weather: String = ""
    var weatherIcon: UIImage!
    var imageView = UIImageView()
    
    //misc
    var blackBorder:CGColor = UIColor.blackColor().CGColor
    var redBorder:CGColor = UIColor.redColor().CGColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupContainerViews()
        firstContainer(inventory)
        secondContainer(supplies)
        thirdContainer(mix)
        fourthContainer(startSelling)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupContainerViews() {
        var x = self.view.bounds.origin.x
        var y = self.view.bounds.origin.y
        var width = self.view.bounds.width
        var height = self.view.bounds.height * kFourth
        
        inventory = UIView(frame: CGRectMake(x, y, width, height))
        supplies = UIView(frame: CGRectMake(x, inventory.frame.height, width, height))
        mix = UIView(frame: CGRectMake(x, inventory.frame.height + supplies.frame.height, width, height))
        startSelling = UIView(frame: CGRectMake(x, inventory.frame.height + supplies.frame.height + mix.frame.height, width, height))
        
        self.view.addSubview(inventory)
        self.view.addSubview(supplies)
        self.view.addSubview(mix)
        self.view.addSubview(startSelling)
    }
    
    func firstContainer(cont: UIView) {
        var x:CGFloat = cont.frame.origin.x + 20
        var y:CGFloat = cont.frame.origin.y + 30
        var width = self.view.bounds.width * kHalf
        var height = self.view.bounds.height
        
        youHaveLabel = UILabel(frame: CGRectMake(x, y, width, height * kThird))
        youHaveLabel.text = "You have:"
        youHaveLabel.textColor = UIColor.redColor()
        youHaveLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        youHaveLabel.sizeToFit()
        
        bank = UILabel(frame: CGRectMake(width, y, width, height))
        bank.text = "$10"
        bank.textColor = UIColor.greenColor()
        bank.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        bank.sizeToFit()
        
        lemonInv = UILabel(frame: CGRectMake(width, y + cont.bounds.height * kThird, width, height))
        lemonInv.text = "1 Lemons"
        lemonInv.textColor = UIColor.blackColor()
        lemonInv.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        lemonInv.sizeToFit()
        
        iceInv = UILabel(frame: CGRectMake(width, y + cont.bounds.height * 2 * kThird, width, height))
        iceInv.text = "1 Ice Cubes"
        iceInv.textColor = UIColor.blackColor()
        iceInv.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        iceInv.sizeToFit()
        
        cont.addSubview(youHaveLabel)
        cont.addSubview(bank)
        cont.addSubview(lemonInv)
        cont.addSubview(iceInv)
    }
    
    func secondContainer(cont: UIView) {
        var x:CGFloat = cont.bounds.origin.x
        var y:CGFloat = cont.bounds.origin.y
        var width:CGFloat = cont.bounds.width
        var height:CGFloat = cont.bounds.height
        
        step1Label = UILabel(frame: CGRectMake(x + 20, y, width, height))
        step1Label.text = "Step 1: Purchase Supplies"
        step1Label.textColor = UIColor.purpleColor()
        step1Label.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        step1Label.sizeToFit()
        
        lemPriceLabel = UILabel(frame: CGRectMake(x, y + height * kThird, width * kHalf, height * kThird))
        lemPriceLabel.text = "Lemons for $2:"
        lemPriceLabel.textColor = UIColor.blackColor()
        lemPriceLabel.textAlignment = NSTextAlignment.Right
        lemPriceLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        icePriceLabel = UILabel(frame: CGRectMake(x, y + height * 2 * kThird, width * kHalf, height * kThird))
        icePriceLabel.text = "Ice Cubes for $1:"
        icePriceLabel.textColor = UIColor.blackColor()
        icePriceLabel.textAlignment = NSTextAlignment.Right
        icePriceLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        buyLemLabel = UILabel(frame: CGRectMake(x + width * 4 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        buyLemLabel.text = "0"
        buyLemLabel.textColor = UIColor.blackColor()
        buyLemLabel.textAlignment = NSTextAlignment.Center
        buyLemLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        buyIceLabel = UILabel(frame: CGRectMake(x + width * 4 * kSixth, y + height * 2 * kThird, width * kSixth, height * kThird))
        buyIceLabel.text = "0"
        buyIceLabel.textColor = UIColor.blackColor()
        buyIceLabel.textAlignment = NSTextAlignment.Center
        buyIceLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        moarLemsButton = UIButton(frame: CGRectMake(x + width * 3 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        moarLemsButton.setTitle("+", forState: UIControlState.Normal)
        moarLemsButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        moarLemsButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        moarLemsButton.center = CGPointMake(x + width * 3.5 * kSixth, y + height * 1.5 * kThird)
        moarLemsButton.addTarget(self, action: "addLemsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        lessLemsButton = UIButton(frame: CGRectMake(x + width * 5 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        lessLemsButton.setTitle("-", forState: UIControlState.Normal)
        lessLemsButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        lessLemsButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        lessLemsButton.center = CGPointMake(x + width * 5.5 * kSixth, y + height * 1.5 * kThird)
        lessLemsButton.addTarget(self, action: "subLemsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        moarIceButton = UIButton(frame: CGRectMake(x + width * 3 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        moarIceButton.setTitle("+", forState: UIControlState.Normal)
        moarIceButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        moarIceButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        moarIceButton.center = CGPointMake(x + width * 3.5 * kSixth, y + height * 2.5 * kThird)
        moarIceButton.addTarget(self, action: "addIcePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        lessIceButton = UIButton(frame: CGRectMake(x + width * 5 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        lessIceButton.setTitle("-", forState: UIControlState.Normal)
        lessIceButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        lessIceButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        lessIceButton.center = CGPointMake(x + width * 5.5 * kSixth, y + height * 2.5 * kThird)
        lessIceButton.addTarget(self, action: "subIcePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        //		lessIceButton.layer.borderColor = blackBorder
        //		lessIceButton.layer.borderWidth = 2
        
        cont.addSubview(step1Label)
        cont.addSubview(lemPriceLabel)
        cont.addSubview(icePriceLabel)
        cont.addSubview(buyLemLabel)
        cont.addSubview(buyIceLabel)
        
        cont.addSubview(moarLemsButton)
        cont.addSubview(lessLemsButton)
        cont.addSubview(moarIceButton)
        cont.addSubview(lessIceButton)
    }
    
    func thirdContainer(cont: UIView) {
        var x:CGFloat = cont.bounds.origin.x
        var y:CGFloat = cont.bounds.origin.y
        var width:CGFloat = cont.bounds.width
        var height:CGFloat = cont.bounds.height
        
        step2Label = UILabel(frame: CGRectMake(x + 20, y, width, height))
        step2Label.text = "Step 2: Mix your lemonade"
        step2Label.textColor = UIColor.purpleColor()
        step2Label.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        step2Label.sizeToFit()
        
        LemLabel = UILabel(frame: CGRectMake(x, y + height * kThird, width * kHalf, height * kThird))
        LemLabel.text = "Lemons:"
        LemLabel.textColor = UIColor.blackColor()
        LemLabel.textAlignment = NSTextAlignment.Right
        LemLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        IceLabel = UILabel(frame: CGRectMake(x, y + height * 2 * kThird, width * kHalf, height * kThird))
        IceLabel.text = "Ice Cubes:"
        IceLabel.textColor = UIColor.blackColor()
        IceLabel.textAlignment = NSTextAlignment.Right
        IceLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        numLemLabel = UILabel(frame: CGRectMake(x + width * 4 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        numLemLabel.text = "0"
        numLemLabel.textColor = UIColor.blackColor()
        numLemLabel.textAlignment = NSTextAlignment.Center
        numLemLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        numIceLabel = UILabel(frame: CGRectMake(x + width * 4 * kSixth, y + height * 2 * kThird, width * kSixth, height * kThird))
        numIceLabel.text = "0"
        numIceLabel.textColor = UIColor.blackColor()
        numIceLabel.textAlignment = NSTextAlignment.Center
        numIceLabel.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        
        moreLemsButton = UIButton(frame: CGRectMake(x + width * 3 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        moreLemsButton.setTitle("+", forState: UIControlState.Normal)
        moreLemsButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        moreLemsButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        moreLemsButton.center = CGPointMake(x + width * 3.5 * kSixth, y + height * 1.5 * kThird)
        moreLemsButton.addTarget(self, action: "mixaddLemsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        fewwLemsButton = UIButton(frame: CGRectMake(x + width * 5 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        fewwLemsButton.setTitle("-", forState: UIControlState.Normal)
        fewwLemsButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        fewwLemsButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        fewwLemsButton.center = CGPointMake(x + width * 5.5 * kSixth, y + height * 1.5 * kThird)
        fewwLemsButton.addTarget(self, action: "mixsubLemsPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        moreIceButton = UIButton(frame: CGRectMake(x + width * 3 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        moreIceButton.setTitle("+", forState: UIControlState.Normal)
        moreIceButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        moreIceButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        moreIceButton.center = CGPointMake(x + width * 3.5 * kSixth, y + height * 2.5 * kThird)
        moreIceButton.addTarget(self, action: "mixaddIcePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        fewwIceButton = UIButton(frame: CGRectMake(x + width * 5 * kSixth, y + height * kThird, width * kSixth, height * kThird))
        fewwIceButton.setTitle("-", forState: UIControlState.Normal)
        fewwIceButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        fewwIceButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        fewwIceButton.center = CGPointMake(x + width * 5.5 * kSixth, y + height * 2.5 * kThird)
        fewwIceButton.addTarget(self, action: "mixsubIcePressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        cont.addSubview(step2Label)
        //		cont.addSubview(note3)
        cont.addSubview(LemLabel)
        cont.addSubview(IceLabel)
        cont.addSubview(numLemLabel)
        cont.addSubview(numIceLabel)
        
        cont.addSubview(moreLemsButton)
        cont.addSubview(fewwLemsButton)
        cont.addSubview(moreIceButton)
        cont.addSubview(fewwIceButton)
    }
    
    func fourthContainer(cont: UIView) {
        var x:CGFloat = cont.bounds.origin.x
        var y:CGFloat = cont.bounds.origin.y
        var width:CGFloat = cont.bounds.width
        var height:CGFloat = cont.bounds.height
        var weatherIcon = UIImage(named: "")
        
        step3Label = UILabel(frame: CGRectMake(x + 20, y, width, height))
        step3Label.text = "Step 3: Start selling dat brew"
        step3Label.textColor = UIColor.purpleColor()
        step3Label.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        step3Label.sizeToFit()
        
        startButton = UIButton(frame: CGRectMake(x + width * kHalf, y + height * 2 * kThird, width * kThird, height * kThird))
        startButton.setTitle("Start Selling", forState: UIControlState.Normal)
        startButton.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)
        startButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        startButton.center = CGPointMake(x + width * kHalf, y + height * 2 * kThird)
        startButton.addTarget(self, action: "startDayPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        startButton.layer.borderColor = UIColor.yellowColor().CGColor
        startButton.layer.backgroundColor = UIColor.yellowColor().CGColor
        startButton.layer.borderWidth = 2
        
        buyButton = UIButton(frame: CGRectMake(x + width * kThird, y + height * 2 * kThird, width * kThird, height * kThird))
        buyButton.setTitle("Buy", forState: UIControlState.Normal)
        buyButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        buyButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        buyButton.center = CGPointMake(x + width * kSixth, y + height * 2 * kThird)
        buyButton.addTarget(self, action: "buyPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        buyButton.layer.borderColor = UIColor.greenColor().CGColor
        buyButton.layer.backgroundColor = UIColor.greenColor().CGColor
        buyButton.layer.borderWidth = 2
        
        resetButton = UIButton(frame: CGRectMake(x + width * 3 * kThird, y + height * 2 * kThird, width * kThird, height * kThird))
        resetButton.setTitle("Reset", forState: UIControlState.Normal)
        resetButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        resetButton.titleLabel?.font = UIFont(name: "MarkerFeld-Wide", size: 20)
        resetButton.center = CGPointMake(x + width * 5 * kSixth, y + height * 2 * kThird)
        resetButton.addTarget(self, action: "resetPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        resetButton.layer.borderColor = UIColor.redColor().CGColor
        resetButton.layer.backgroundColor = UIColor.redColor().CGColor
        resetButton.layer.borderWidth = 2
        
        weatherIcon = UIImage(named: "Mild")
        
//        imageView = UIImageView(frame: CGRectMake(x + width * 2.5 * kSixth, y + height * 0.5 * kSixth + 6, weatherIcon.size.width, weatherIcon.size.height))
        imageView.image = weatherIcon
        
        cont.addSubview(step3Label)
        //		cont.addSubview(note4)
        cont.addSubview(startButton)
        cont.addSubview(buyButton)
        cont.addSubview(resetButton)
        
        cont.addSubview(imageView)
    }
    
    func addLemsPressed(button: UIButton) {
        if totalmoney > 1 {
            buyLemLabel.text = "\(++lemonCart)"
            totalmoney -= 2
            
            bank.text = "$\(totalmoney)"
        }
    }
    
    func subLemsPressed(button: UIButton) {
        if lemonCart > 0 {
            buyLemLabel.text = "\(--lemonCart)"
            totalmoney += 2
            
            bank.text = "$\(totalmoney)"
        }
    }
    
    func addIcePressed(button: UIButton) {
        if totalmoney > 0 {
            buyIceLabel.text = "\(++iceCart)"
            totalmoney -= 1
            
            bank.text = "$\(totalmoney)"
        }
    }
    
    func subIcePressed(button: UIButton) {
        if iceCart > 0 {
            buyIceLabel.text = "\(--iceCart)"
            totalmoney += 1
            
            bank.text = "$\(totalmoney)"
        }
    }
    
    func mixaddLemsPressed(button: UIButton) {
        if totallemons > 0 {
            numLemLabel.text = "\(++mixLemons)"
            totallemons -= 1
            
            lemonInv.text = "\(totallemons) Lemons"
        }
    }
    
    func mixsubLemsPressed(button: UIButton) {
        if mixLemons > 0 {
            numLemLabel.text = "\(--mixLemons)"
            totallemons += 1
            
            lemonInv.text = "\(totallemons) Lemons"
        }
    }
    
    func mixaddIcePressed(button: UIButton) {
        if totalIceCubes > 0 {
            numIceLabel.text = "\(++mixIce)"
            totalIceCubes -= 1
            
            iceInv.text = "\(totalIceCubes) Ice Cubes"
        }
    }
    
    func mixsubIcePressed(button: UIButton) {
        if mixIce > 0 {
            numIceLabel.text = "\(--mixIce)"
            totalIceCubes += 1
            
            iceInv.text = "\(totalIceCubes) Ice Cubes"
        }
    }
    
    func startDayPressed(button: UIButton) {
        lemonadeRatio = Float(mixLemons) / Float(mixIce)
        numCust = Int(arc4random_uniform(UInt32(10))) + 1 //range is from 1-10
        adjustCust()
        custPref = [0, 0, 0]
        
        //clear mix
        mixLemons = 0
        mixIce = 0
        
        if !lemonadeRatio.isNaN {
            mixAndSell()
        }
        updateAll()
    }
    
    func buyPressed(sender: UIButton!){
        //add newly purchased supplies to inventory
        totallemons += lemonCart
        totalIceCubes += iceCart
        
        //clear carts
        lemonCart = 0
        iceCart = 0
        
        updateAll()
        
    }
    
    func resetPressed(sender: UIButton!){
        totalmoney = 10
        totallemons = 0
        totalIceCubes = 0
        lemonCart = 0
        iceCart = 0
        mixLemons = 0
        mixIce = 0
        updateAll()
    }
    
    func mixAndSell() {
        //generate lemonade group based on mix
        if lemonadeRatio > 1 {
            lemonadeGroup = 0
        } else if lemonadeRatio == 1 {
            lemonadeGroup = 1
        } else if lemonadeRatio < 1 {
            lemonadeGroup = 2
        }
        
        //catagorize customer preferences
        for var cust = 0; cust < numCust; cust++ {
            switch Float(arc4random_uniform(UInt32(12))){//range is from 0-11
            case 0...3:
                custPref[0]++
            case 4...7:
                custPref[1]++
            default:
                custPref[2]++
            }
        }
        //		println("\(totalmoney)")
        
        //collect money from ppl whose pref i can match
        totalmoney += custPref[lemonadeGroup]
        //		println("\(lemonadeRatio)")
        //		println("\(numCust)")
        //		println("\(lemonadeGroup)")
        //		println("\(custPref)")
        //		println("\(totalmoney)")
    }
    
    func updateAll() {
        bank.text = "$\(totalmoney)"
        lemonInv.text = "\(totallemons) Lemons"
        iceInv.text = "\(totalIceCubes) Ice Cubes"
        
        buyLemLabel.text = "\(lemonCart)"
        buyIceLabel.text = "\(iceCart)"
        
        numLemLabel.text = "\(mixLemons)"
        numIceLabel.text = "\(mixIce)"
        
        updateWeather()
    }
    
    func updateWeather() {
        var rando = arc4random_uniform(3)
        
        switch rando {
        case 0:
            weather = "Cold"
        case 1:
            weather = "Mild"
        default:
            weather = "Warm"
        }
        imageView.image = UIImage(named: "")
    }
    
    func adjustCust() {
        if weather == "Cold" {
            numCust = 1
        } else if weather == "Warm" {
            numCust = 10
        }
    }
}
