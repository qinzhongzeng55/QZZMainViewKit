//
//  QZZMainViewKitViewController.m
//  QZZMainViewKit
//
//  Created by qinzhongzeng55 on 06/27/2018.
//  Copyright (c) 2018 qinzhongzeng55. All rights reserved.
//

#import "QZZMainViewKitViewController.h"

@interface QZZMainViewKitViewController ()

@end

@implementation QZZMainViewKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupNavType{
    [super setupNavType];
    [self setupNavSearchBar];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg_wode"] forBarMetrics:UIBarMetricsDefault];
}
@end
