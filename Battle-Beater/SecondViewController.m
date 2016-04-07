//
//  SecondViewController.m
//  Battle-Beater
//
//  Created by Tim Stever on 7/22/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    NSLog(@"In SecondViewController:ViewDidLoad");

    // Create or reference the app delegate object.
    theApp = [AppDelegate sharedInstance]; // Create or return the created appDelegate object.
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// After the any segue has been invoked, but before it has been displayed, send it any required information.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"In prepareForSeque from FirstViewController.");
    
}

@end
