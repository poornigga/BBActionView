//
//  BBSecondViewController.m
//  BBActionViewDemo
//
//  Created by snoopdog on 14-2-20.
//  Copyright (c) 2014年 BSBus. All rights reserved.
//

#import "BBSecondViewController.h"
#import "BBActionView.h"

#import "BB3rdViewController.h"

@interface BBSecondViewController ()

@end

@implementation BBSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(IBAction)btnClicked:(id)sender {
    NSLog(@"btnclicked");
    [BBActionView showBBImageMenuIn:self.view subTitle:@"subtitle" imagePath:@"kulu.jpg"
                        startHandle:^(void) {
                            self.tabBarController.tabBar.hidden = YES;
                        }
                          endHandle:^(void) {
                              self.tabBarController.tabBar.hidden = NO;
                          }
                     selectedHandle:^(NSInteger index){
                         NSLog(@"index : %d", index);
                         BB3rdViewController *cc = [[BB3rdViewController alloc]init];
                         [self.navigationController pushViewController:cc animated:YES ];
                     }
     ];
}

@end
