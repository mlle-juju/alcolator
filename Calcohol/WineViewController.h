//
//  ViewController.h
//  Calcohol
//
//  Created by Julicia on 10/16/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WineViewController : UIViewController
@property (weak, nonatomic) UITextField *beerPercentTextField;
@property (weak, nonatomic) UILabel *resultLabel;
@property (weak, nonatomic) UISlider *beerCountSlider;
@property (weak, nonatomic) UILabel *sliderValueLabel;

- (void)buttonPressed:(UIButton *)sender;
- (IBAction)updateQuantityLabel;

@end

