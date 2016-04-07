//
//  FirstViewController.m
//  Battle-Beater
//
//  Created by Tim Stever on 7/22/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import "FirstViewController.h"
#import "EditBeaterViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    NSLog(@"In FirstViewController:ViewDidLoad");
    
    // Create or reference the app delegate object.
    theApp = [AppDelegate sharedInstance]; // Create or return the created appDelegate object.

    // Register with the NotificationCenter to listen to "refreshView" notification.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshView:)
                                                 name:@"refreshView" object:nil];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"In FirstViewController:ViewDidAppear");
    // The view has just re-appeared, so may need to redraw the beater.
    [self.view setNeedsDisplay];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// After the any segue has been invoked, but before it has been displayed, send it any required information.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSLog(@"In prepareForSeque from FirstViewController.");
    
    // Prepare for seque to EditBeater view.
    if ([segue.identifier isEqualToString:@"EditBeater"]) {
        // Instantiate a EditBeaterViewController and link it to the seque.
        EditBeaterViewController *editBeaterViewController = segue.destinationViewController;

        // Now, tell the EditBeaterViewController that I am its delegate.
        editBeaterViewController.delegate = self;
    }
}


#pragma mark - EditBeaterViewControllerDelegate

- (void)editBeaterViewControllerDidRevert:(EditBeaterViewController *)controller {
    // For now, simply flip back to the first view.
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)editBeaterViewControllerDidSave:(EditBeaterViewController *)controller {
    // For now, simply flip back to the first view.
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)refreshView:(NSNotification *) notification {
    // Received the message that the view needs to be refreshed.
    // Reload labels from variables.
    beaterNameLabel.text = theApp.activeBeater.beaterName;
    // statusLabel, healthLabel, levelLabel, currentAttLabel, currentDefLabel
    healthLabel.text = [theApp.activeBeater.healthPoints stringValue];
    levelLabel.text = [theApp.activeBeater.level stringValue];
    currentAttLabel.text = [theApp.activeBeater.currentWeapon weaponName];
    currentDefLabel.text = [theApp.activeBeater.currentDefense defenseName];
    
    [self updateCombatStatus];

    //CODE TO REFRESH THE VIEW HERE
    [self.view setNeedsDisplay];
    
}

- (void)updateCombatStatus{
    NSLog(@"In updateCombatStatus of FirstViewController");
    // Update statusLabel, findABattleButton, attackButton, editImageButton, and readyStatusButton based on inCombat and readyForCombat.
    
    // Pull the inCombat and readyForCombat statuses from the appDelegate.
    bool inC, readyForC;
    inC = [theApp.inCombat boolValue];
    readyForC = [theApp.readyForCombat boolValue];
    
    /*
     inC = true, readyForC = true:
     disable findABattle ("In Combat")
     disable readyStatusButton ("In Combat")
     enable attackButton ("Attack")
     change statusLabel to Red and text to "Battle"
     */
    if (inC && readyForC) {
        [statusLabel setBackgroundColor:[UIColor redColor]]; // Set the status bar to green.
        [statusLabel setText:@"Battle"];
        [findABattleButton setTitle:@"In Combat" forState:UIControlStateNormal];
        [findABattleButton setEnabled:NO];
        [readyStatusButton setTitle:@"In Combat" forState:UIControlStateNormal];
        [readyStatusButton setEnabled:NO];
        [attackButton setTitle:@"Attack" forState:UIControlStateNormal];
        [attackButton setEnabled:YES];
    }
    /*
     inC = false, readyForC = true:
     enable findABattle ("Find Battle")
     enable readyStatusButton ("Rest")
     disable attackButton ("Ready")
     change statusLabel to Green and text to "Ready to Battle"
     */
    if (!inC && readyForC) {
        [statusLabel setBackgroundColor:[UIColor greenColor]]; // Set the status bar to green.
        [statusLabel setText:@"Ready To Battle"];
        [findABattleButton setTitle:@"Find Battle" forState:UIControlStateNormal];
        [findABattleButton setEnabled:YES];
        [readyStatusButton setTitle:@"Rest" forState:UIControlStateNormal];
        [readyStatusButton setEnabled:YES];
        [attackButton setTitle:@"Ready" forState:UIControlStateNormal];
        [attackButton setEnabled:NO];
    }
    /*
     inC = false, readyForC = false:
     enable findABattle ("Resting")
     enable readyStatusButton ("Enter Fray")
     disable attackButton ("Resting")
     change statusLabel to Green and text to "Resting"
     */
    if (!inC && !readyForC) {
        [statusLabel setBackgroundColor:[UIColor greenColor]]; // Set the status bar to green.
        [statusLabel setText:@"Resting"];
        [findABattleButton setTitle:@"Resting" forState:UIControlStateNormal];
        [findABattleButton setEnabled:NO];
        [readyStatusButton setTitle:@"Enter Fray" forState:UIControlStateNormal];
        [readyStatusButton setEnabled:YES];
        [attackButton setTitle:@"Resting" forState:UIControlStateNormal];
        [attackButton setEnabled:NO];
    }
    
    return;
}

@end
