//
//  FirstViewController.h
//  Battle-Beater
//
//  Created by Tim Stever on 7/22/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditBeaterViewController.h"
#import "AppDelegate.h"

@interface FirstViewController : UIViewController <EditBeaterViewControllerDelegate> {
    AppDelegate *theApp; // Create an instance of theAppDelegate in each ViewController.
    
    IBOutlet UILabel *beaterNameLabel, *statusLabel;
    IBOutlet UILabel *levelLabel, *healthLabel, *currentAttLabel, *currentDefLabel;
    IBOutlet UIButton *findABattleButton, *attackButton, *readyStatusButton;

}

- (void)updateCombatStatus;


@end

