//
//  SettingsViewController.m
//  Battle-Beater
//
//  Created by Tim Stever on 10/4/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    NSLog(@"In ThirdViewController:ViewDidLoad");

    // Create or reference the app delegate object.
    theApp = [AppDelegate sharedInstance]; // Create or return the created appDelegate object.
    
    NSLog(@"Setting UI fields to match global variables.");
    [userNameTextField setText:theApp.userName];
    [maxLevelDifferenceField setText:[theApp.maxLevelDifference stringValue]];
    [allowInvitationsButton setOn:[theApp.allowInvitations boolValue]];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)enterName:(id)sender {
    NSLog(@"In enterName");
    
    // Set the userName in the appDelegate to the new entry.
    theApp.userName = [(UITextField *)sender text];
    // Store the userName in non-volatile memory.
    [theApp storeUserDefaults];
    
    return;
}

- (IBAction)enterMaxLevelDifference:(id)sender {
    NSLog(@"In enterMaxLevelDifference");
    
    // Set the maxLevelDifference in the appDelegate to the new entry.
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    theApp.maxLevelDifference = [f numberFromString:[(UITextField *)sender text]];

    // Store the maxLevelDifference in non-volatile memory.
    [theApp storeUserDefaults];

    return;
}

- (IBAction)enterAllowInvitations:(id)sender {
    NSLog(@"In enterAllowInvitations");
    
    NSNumber *tempNumber;
    
    tempNumber = [NSNumber numberWithInt:[(UISwitch *)sender isOn]];
    // Set the allowInvitations in the appDelegate to the new entry.
    theApp.allowInvitations = tempNumber;
    
    // Store the allowInvitations in non-volatile memory.
    [theApp storeUserDefaults];

    return;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
 // After the any segue has been invoked, but before it has been displayed, send it any required information.
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 
 NSLog(@"In prepareForSeque from FirstViewController.");
     
 }

@end
