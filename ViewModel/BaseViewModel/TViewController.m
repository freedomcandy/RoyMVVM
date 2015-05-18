//
//  TViewController.m
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/15.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import "TViewController.h"

@interface TViewController ()

@end

@implementation TViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    BaseViewController_Swift *bc = [[BaseViewController_Swift alloc] init];
    [bc test2];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
