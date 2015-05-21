//
//  ViewController.m
//  RoyMVVM
//
//  Created by RoyGuo on 15/5/15.
//  Copyright (c) 2015年 RoyGuo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(0, 1);
//    gLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:1] CGColor],
//                     (id)[[[UIColor yellowColor] colorWithAlphaComponent:1] CGColor],
//                     (id)[[[UIColor blueColor] colorWithAlphaComponent:1] CGColor],
//                     (id)[[UIColor clearColor] CGColor],
//                     nil];
//    gLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
//                        [NSNumber numberWithFloat:0.3],
//                        [NSNumber numberWithFloat:0.8],
//                        [NSNumber numberWithFloat:1.0],
//                        nil];
    
    
    gLayer.colors = [NSArray arrayWithObjects:
                     (id)[[UIColor clearColor] CGColor],
                     (id)[[[UIColor blackColor] colorWithAlphaComponent:1] CGColor],
                     nil];
    gLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                                                [NSNumber numberWithFloat:5.0],
                                                nil];
    
    
    gLayer.frame = CGRectMake(0, 0, 320, 100);
    
    
//    [self.view.layer addSublayer:gLayer];
    
    UIImageView *im = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, 600, 600)];
    im.image = [UIImage imageNamed:@"icon_clock"];
//    [self.view addSubview:im];

    
    self.tTableView.hidden = YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
   
}


- (CAGradientLayer *)shadowAsInverse
{
    CAGradientLayer *newShadow = [CAGradientLayer layer];
    CGRect newShadowFrame = CGRectMake(0, 0, 320, self.view.frame.size.height);
    newShadow.frame = newShadowFrame;
    //添加渐变的颜色组合
    newShadow.colors = [NSArray arrayWithObjects:(id)[UIColor whiteColor].CGColor,(id)[UIColor blackColor].CGColor,nil];
    return newShadow;
}



#pragma mark - UITableView delegate and UITableView dataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tableTag = @"TableTags";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableTag];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableTag];
    }else{
        
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%d",(int)indexPath.row];
    
    CAGradientLayer *gLayer = [CAGradientLayer layer];
    gLayer.startPoint = CGPointMake(0, 0);
    gLayer.endPoint = CGPointMake(0, 1);
    gLayer.colors = [NSArray arrayWithObjects:(id)[[[UIColor blackColor] colorWithAlphaComponent:1] CGColor],
                                          (id)[[[UIColor yellowColor] colorWithAlphaComponent:1] CGColor],
                                          (id)[[[UIColor blueColor] colorWithAlphaComponent:1] CGColor],
                                          (id)[[UIColor clearColor] CGColor],
                                          nil];
                         gLayer.locations = [NSArray arrayWithObjects:[NSNumber numberWithFloat:0.0],
                                             [NSNumber numberWithFloat:0.3],
                                             [NSNumber numberWithFloat:0.8],
                                             [NSNumber numberWithFloat:1.0],
                                             nil];
    gLayer.frame = CGRectMake(0, 0, cell.size.width, 40);
    
//    [cell.contentView.layer addSublayer:gLayer];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}


@end
