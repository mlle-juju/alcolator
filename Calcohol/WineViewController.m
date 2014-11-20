//
//  ViewController.m
//  Calcohol
//
//  Created by Julicia on 10/16/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "WineViewController.h"

@interface WineViewController () <UITextFieldDelegate>
@property (weak, nonatomic) UILabel *numberOfBeersLabel;
@property (weak, nonatomic) UIButton *calculateButton;
@property (weak, nonatomic) UITapGestureRecognizer *hideKeyboardTapGestureRecognizer;

@end

@implementation WineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // Set our primary view's background color to light grey.
    // pretty pink color: self.view.backgroundColor = [UIColor colorWithRed:1 green:0.55 blue:0.9 alpha:1];
    //self.view.backgroundColor = [UIColor colorWithRed:0.55 green:0.7 blue:1 alpha:1];
   
    //on 11.13.14 changed the color per Bloc checkpoint. The light blue color I prefer is above.
    self.view.backgroundColor = [UIColor colorWithRed:0.741 green:0.925 blue:0.714 alpha:1]; /*#bdecb6*/

    
    
    // Tells the text field that `self`, this instance of `BLCViewController` should be treated as the text field's delegate
    self.beerPercentTextField.delegate = self;
    
    // Set the placeholder text
    self.beerPercentTextField.placeholder = NSLocalizedString(@"% Alcohol Content Per Beer", @"Beer percent placeholder text");
    
    // Tells `self.beerCountSlider` that when its value changes, it should call `[self -sliderValueDidChange:]`.
    // This is equivalent to connecting the IBAction in our previous checkpoint
    [self.beerCountSlider addTarget:self action:@selector(sliderValueDidChange:) forControlEvents:UIControlEventValueChanged];
    
    // Set the minimum and maximum number of beers
    self.beerCountSlider.minimumValue = 1;
    self.beerCountSlider.maximumValue = 10;
    
    // Tells `self.calculateButton` that when a finger is lifted from the button while still inside its bounds, to call `[self -buttonPressed:]`
    [self.calculateButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    // Set the title of the button
    [self.calculateButton setTitle:NSLocalizedString(@"Calculate!", @"Calculate command") forState:UIControlStateNormal];
    
    // Tells the tap gesture recognizer to call `[self -tapGestureDidFire:]` when it detects a tap.
    [self.hideKeyboardTapGestureRecognizer addTarget:self action:@selector(tapGestureDidFire:)];
    
    // Gets rid of the maximum number of lines on the label
    self.resultLabel.numberOfLines = 0;
    
    
    
    UIFont *newFont = [UIFont fontWithName:@"HiraKakuProN-W6" size:16];
    self.resultLabel.font = newFont;
    //UIFont *secondFont = [UIFont fontWithName:@"Marker Felt Thin" size:10];
    UIFont *secondFont = [UIFont fontWithName:@"MarkerFelt-Thin" size:20.0];
    self.beerPercentTextField.font = secondFont;
    
    //gave the slider value label a font
    //self.sliderValueLabel.font = secondFont;

//    [[UILabel appearance] setFont:newFont];

    


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)textFieldDidChange:(UITextField *)sender {
    NSString *enteredText = sender.text;
    float enteredNumber = [enteredText floatValue];
    
    if (enteredNumber == 0) {
        // The user typed 0, or something that's not a number, so clear the field
        sender.text = nil;
    }

}

- (void)sliderValueDidChange:(UISlider *)sender {
    NSLog(@"Slider value changed to %f", sender.value);
    [self.beerPercentTextField resignFirstResponder];
    [self.tabBarItem setBadgeValue:[NSString stringWithFormat:@"%d", (int) sender.value]];
    
    [self updateQuantityLabel];
}

-(IBAction)updateQuantityLabel {
    double numberOfUnits = self.beerCountSlider.value;
    
    
    //my attempt to make the label say #of beers the slider represents is below
    
   // NSString *numberOfBeersLabelText = [NSString stringWithFormat:NSLocalizedString(@"%.1f", nil), numberOfUnits];
    //NSString *titleText = [NSString stringWithFormat:NSLocalizedString(@"Wine (%.1f glasses)", nil), numberOfUnits];
    //self.sliderValueLabel.text = numberOfBeersLabelText;
    //self.title = titleText;
    //[self buttonPressed:self.calculateButton];

}



- (void)buttonPressed:(UIButton *)sender {
    [self.beerPercentTextField resignFirstResponder];
    // first, calculate how much alcohol is in all those beers...
    
    int numberOfBeers = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = [self.beerPercentTextField.text floatValue] / 100;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    float ouncesOfAlcoholTotal = ouncesOfAlcoholPerBeer * numberOfBeers;
    
    // now, calculate the equivalent amount of wine...
    
    float ouncesInOneWineGlass = 5;  // wine glasses are usually 5oz
    float alcoholPercentageOfWine = 0.13;  // 13% is average
    
    float ouncesOfAlcoholPerWineGlass = ouncesInOneWineGlass * alcoholPercentageOfWine;
    float numberOfWineGlassesForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerWineGlass;
    
    // decide whether to use "beer"/"beers" and "glass"/"glasses"
    
    NSString *beerText;
    
    if (numberOfBeers == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
    
    NSString *wineText;
    
    if (numberOfWineGlassesForEquivalentAlcoholAmount == 1) {
        wineText = NSLocalizedString(@"glass", @"singular glass");
    } else {
        wineText = NSLocalizedString(@"glasses", @"plural of glass");
    }
    
    // generate the result text, and display it on the label
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.1f %@ of wine.", @"resultTextString"), numberOfBeers, beerText, numberOfWineGlassesForEquivalentAlcoholAmount, wineText];
    self.resultLabel.text = resultText;
    
    // Nov 6 I added the sliderValueText and called the sliderValueLabel below.
    
    //NSString *sliderValueText = [NSString stringWithFormat:@"%g", _beerCountSlider.value];
    //self.sliderValueLabel.text = sliderValueText;
    
    
}

- (instancetype) init {
    self = [super init];
    
    if (self) {
        self.title = NSLocalizedString(@"Wine", @"wine");
        // Since we don't have icons, let's move the title to the middle of the tab bar
        [self.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -18)];

    
    }
    
    return self;
}



- (void)tapGestureDidFire:(UITapGestureRecognizer *)sender {
    [self.beerPercentTextField resignFirstResponder];
    
}

- (void)loadView {
    // Allocate and initialize the all-encompassing view
    self.view = [[UIView alloc] init];
    
    // Allocate and initialize each of our views and the gesture recognizer
    UITextField *textField = [[UITextField alloc] init];
    UISlider *slider = [[UISlider alloc] init];
    UILabel *label = [[UILabel alloc] init];
    UILabel *sliderLabel = [[UILabel alloc] init];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    
    // Add each view and the gesture recognizer as the view's subviews
    [self.view addSubview:textField];
    [self.view addSubview:slider];
    [self.view addSubview:label];
    [self.view addSubview:sliderLabel];
    [self.view addSubview:button];
    [self.view addGestureRecognizer:tap];
    
    // Assign the views and gesture recognizer to our properties
    self.beerPercentTextField = textField;
    self.beerCountSlider = slider;
    self.resultLabel = label;
    //self.sliderValueLabel = sliderLabel;
    self.calculateButton = button;
    self.hideKeyboardTapGestureRecognizer = tap;
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
//    CGFloat viewWidth = 320;
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.beerPercentTextField.frame = CGRectMake(padding, 75+padding, itemWidth, itemHeight);
    
    CGFloat bottomOfTextField = CGRectGetMaxY(self.beerPercentTextField.frame);
    self.beerPercentTextField.textAlignment = UITextAlignmentCenter;
    
    //11.6.14 this is the slider that Paul helped me create
    self.beerCountSlider.frame = CGRectMake(padding, bottomOfTextField + padding, itemWidth, itemHeight);
    
    CGFloat bottomOfSlider = CGRectGetMaxY(self.beerCountSlider.frame);
    self.resultLabel.frame = CGRectMake(padding, bottomOfSlider + padding+20, itemWidth, itemHeight * 2);
//    self.resultLabel.text = @"testing";
    self.resultLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.resultLabel.textAlignment = UITextAlignmentCenter;
    self.resultLabel.adjustsFontSizeToFitWidth = YES;
    self.resultLabel.preferredMaxLayoutWidth = 50;
//    self.resultLabel.layoutMargins = UIEdgeInsetsMake(-20, -20, -20, -20);
 //   [self.resultLabel sizeToFit];

    
    /* Nov 6 my attempt to situate the label in a visible spot on the app.
    
    self.sliderValueLabel.frame = CGRectMake(padding, bottomOfSlider + padding, itemWidth/2, itemHeight);
    self.sliderValueLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.sliderValueLabel.textAlignment = UITextAlignmentCenter;
    self.sliderValueLabel.adjustsFontSizeToFitWidth = YES;
    self.sliderValueLabel.preferredMaxLayoutWidth = 50; */
    
    
    CGFloat bottomOfLabel = CGRectGetMaxY(self.resultLabel.frame);
    self.calculateButton.frame = CGRectMake(padding, bottomOfLabel + padding, itemWidth, itemHeight);


}

@end
