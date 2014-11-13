//
//  WhiskeyViewController.m
//  Calcohol
//
//  Created by Julicia on 10/23/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "WhiskeyViewController.h"

@interface WhiskeyViewController ()

@end


@implementation WhiskeyViewController
// DELETE PRE-WRITTEN METHODS: initiWithNibName:bundle:, viewDidLoad, didReceiveMemoryWarning…

- (void) viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Whiskey", @"whiskey");
    
}

- (void)buttonPressed:(UIButton *)sender;
{
    [self.beerPercentTextField resignFirstResponder];
    
    int numberOfUnit = self.beerCountSlider.value;
    int ouncesInOneBeerGlass = 12;  //assume they are 12oz beer bottles
    
    float alcoholPercentageOfBeer = 0.07;
    float ouncesOfAlcoholPerBeer = ouncesInOneBeerGlass * alcoholPercentageOfBeer;
    
    float ouncesInOneWhiskeyGlass = 1.5;  // a 1oz shot
    float alcoholPercentageOfWhiskey = 0.4;  // 40% is average
    float ouncesOfAlcoholTotal = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey * numberOfUnit;
    
//    float ouncesOfAlcoholPerWhiskeyGlass = ouncesInOneWhiskeyGlass * alcoholPercentageOfWhiskey;
    float numberOfBeersForEquivalentAlcoholAmount = ouncesOfAlcoholTotal / ouncesOfAlcoholPerBeer;
    

    NSString *beerText;
    
    if (numberOfBeersForEquivalentAlcoholAmount == 1) {
        beerText = NSLocalizedString(@"beer", @"singular beer");
    } else {
        beerText = NSLocalizedString(@"beers", @"plural of beer");
    }
 
    
    NSString *whiskeyText;
    
    if (numberOfUnit == 1) {
        whiskeyText = NSLocalizedString(@"shot", @"singular shot");
    } else {
        whiskeyText = NSLocalizedString(@"shots", @"plural of shot");
    }
    
    NSString *resultText = [NSString stringWithFormat:NSLocalizedString(@"%d %@ contains as much alcohol as %.3f %@", nil), numberOfUnit, whiskeyText, numberOfBeersForEquivalentAlcoholAmount, beerText];
    self.resultLabel.text = resultText;
}

- (void)sliderValueDidChange:(UISlider *)sender {
    [self updateQuantityLabel];
    int numberOfUnits = self.beerCountSlider.value;

    self.title = [NSString stringWithFormat:NSLocalizedString(@"Whiskey (%i shots)", nil), numberOfUnits];

    
}

@end
