//
//  EditBeaterViewController.m
//  Battle-Beater
//
//  Created by Tim Stever on 10/10/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import "EditBeaterViewController.h"

@interface EditBeaterViewController ()

@end

@implementation EditBeaterViewController

- (void)viewDidLoad {
    NSLog(@"In EditBeaterController:ViewDidLoad");

    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)revert:(id)sender {
    // Have the delegate, the FirstViewController, handle this.
    [self.delegate editBeaterViewControllerDidRevert:self];
}

- (IBAction)save:(id)sender {
    // Have the delegate, the FirstViewController, handle this.
    [self.delegate editBeaterViewControllerDidSave:self];
}

@end
