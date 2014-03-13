//
//  BBFirstViewController.m
//  BBActionViewDemo
//
//  Created by snoopdog on 14-2-20.
//  Copyright (c) 2014年 BSBus. All rights reserved.
//

#import "BBFirstViewController.h"

#import "BB3rdViewController.h"
#import "BBActionView.h"

@interface BBFirstViewController ()

@end

@implementation BBFirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (IBAction)clicked:(id)sender {
    
    NSLog(@"into");
    
    [BBActionView showBBAlertMenuIn:self.view
                          withTitle:@"BBAlertView"
                         itemTitles:@[ @"Wedding Bell", @"I'm Yours",@"A",@"B",@"C", @"D", @"E", @"When I was your mam" ]
                      itemSubTitles:@[ @"Depapepe - Let's go!!!",@"hhh",@"bbb",@"ccc",@"ddd", @"eee", @"Jason Mraz", @"Bruno Mars" ]
                        startHandle:^(void) {
                            self.tabBarController.tabBar.hidden = YES;
                        }
                        endHandle:^(void) {
                              self.tabBarController.tabBar.hidden = NO;
                          }
                     selectedHandle:^(NSInteger index){
                         NSLog(@"index : %d", index);
                         BB3rdViewController *cc = [[BB3rdViewController alloc]init];
                         [self.navigationController pushViewController:cc animated:NO ];
                     }];

}


@end
