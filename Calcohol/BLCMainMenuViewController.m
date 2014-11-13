//
//  BLCMainMenuViewController.m
//  Calcohol
//
//  Created by Julicia on 10/30/14.
//  Copyright (c) 2014 Bloc. All rights reserved.
//

#import "BLCMainMenuViewController.h"


@interface BLCMainMenuViewController ()
@property UIButton *wineButton;
@property UIButton *whiskeyButton;

@end

@implementation BLCMainMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.whiskeyButton addTarget:self action:@selector(whiskeyPressed:) forControlEvents:UIControlEventTouchUpInside];

    [self.wineButton addTarget:self action:@selector(winePressed:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) winePressed:(UIButton *) sender {
    WineViewController *wineVC = [[WineViewController alloc] init];
    [self.navigationController pushViewController:wineVC animated:YES];
}

- (void) whiskeyPressed:(UIButton *) sender {
    WhiskeyViewController *whiskeyVC = [[WhiskeyViewController alloc] init];
    [self.navigationController pushViewController:whiskeyVC animated:YES];


}

- (void)loadView {
    self.view = [[UIView alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];

   // self.wineButton = [[];
    self.whiskeyButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.whiskeyButton setTitle:@"Whiskey" forState:UIControlStateNormal];
    [self.view addSubview:self.whiskeyButton];

    self.wineButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.wineButton setTitle:@"Wine" forState:UIControlStateNormal];
    [self.view addSubview:self.wineButton];
    
}

- (void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat viewWidth = self.view.frame.size.width;
    CGFloat padding = 20;
    CGFloat itemWidth = viewWidth - padding - padding;
    CGFloat itemHeight = 44;
    
    self.whiskeyButton.frame = CGRectMake(padding, 150+padding, itemWidth, itemHeight);
    
    self.wineButton.frame = CGRectMake (padding, 250+padding, itemWidth, itemHeight);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
