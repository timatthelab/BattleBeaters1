//
//  SettingsViewController.h
//  Battle-Beater
//
//  Created by Tim Stever on 10/4/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface SettingsViewController : UIViewController {
    AppDelegate *theApp; // Create an instance of theAppDelegate in each ViewController.
    
    IBOutlet UITextField *userNameTextField;
    IBOutlet UITextField *maxLevelDifferenceField;
    IBOutlet UISwitch *allowInvitationsButton;

}

- (IBAction)enterName:(id)sender;
- (IBAction)enterMaxLevelDifference:(id)sender;
- (IBAction)enterAllowInvitations:(id)sender;

@end
