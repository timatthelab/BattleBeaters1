//
//  AppDelegate.m
//  Battle-Beater
//
//  Created by Tim Stever on 7/22/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.

// Made a change - this comment!
//

#import "AppDelegate.h"
#import "SHBeater.h"
#import <StoreKit/StoreKit.h> // Framework for in-app purchases.
#import <GameKit/GameKit.h> // Framework for network competition.


@interface AppDelegate ()

@end

@implementation AppDelegate

static AppDelegate *sharedAppDelegate = nil;    // static instance variable

//@synthesize userName;

+ (AppDelegate *)sharedInstance {
    NSLog(@"In AppDelegate:sharedInstance");
    
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIStoryboard *storyboard;
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    NSLog(@"In appDelegate:didFinishLaunchingWithOption");
    NSLog(@"%@",currSysVer);
    if ([currSysVer hasPrefix:@"5"]) {
        storyboard = [UIStoryboard storyboardWithName:@"Main-v5" bundle:nil];
    } else {
        storyboard = [UIStoryboard storyboardWithName:@"Main-v6" bundle:nil];
    }
    
    // Set up default status settings.
    self.inCombat = [NSNumber numberWithBool:FALSE]; // Set false until combat starts.
    self.readyForCombat = [NSNumber numberWithBool:FALSE]; // Set false until user selects ready for combat in FirstViewController.
    isSignedIntoGameCenter = FALSE; // Set false until signed in is confirmed.
    
    [self loadUserDefaults];
    
    // Create array to hold list of all beaters.
    myBeaters = [[NSMutableArray alloc] init];

    // Create placeholder for the active beater.
    self.activeBeater = [[SHBeater alloc] init];

    // Load in the last beater used.
    // Choices are:
    //   - First time; create a random beater or purchase 10; add to list.
    //   - Not first time; last active beater is okay; load last active beater.
    //   - Not first time; last active beater died without replacement; other beaters available; randomly choose one from list.
    //   - Not first time; last active beater died without replacement; no other beaters available; create a random beater or purchase 10; add to list.
    
    // Load beaters or generate a new one.
    if ([self loadBeatersFromFile]) {
        // updateUI should pull active beater out of appDelegate. Assume it will be called.
        
    } else {
        NSLog(@"loadBeatersFromFile was NO.");
        // Setup the box to force generating one or purchasing ten.
        [self Show_AlertTwoMessage];
    }

    self.window.rootViewController = [storyboard instantiateInitialViewController];
    [self.window makeKeyAndVisible];
    
    // Refresh active view.
    //[self.window setNeedsDisplay];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark USER DEFAULTS

-(void)loadUserDefaults {
    
    NSLog(@"Loading User Defaults");
    
    // Load or create the maximum level difference for combat.
    if ([[NSUserDefaults standardUserDefaults] valueForKey:@"versionString"] == nil) {
        // First time running app, standardUserDefaults is empty. Create default.
        // Hard-coded default maxLevelDifference of 1.
        self.maxLevelDifference = [NSNumber numberWithInt:1];
        
        // Write a default user name.
        self.userName = @"User Name";
        
        // Create allowInvitations default to false.
        self.allowInvitations = [NSNumber numberWithInt:0];
        
        [self storeUserDefaults];
        
    } else {
        self.maxLevelDifference = [[NSUserDefaults standardUserDefaults] valueForKey:@"maxLevelDifference"];
        self.userName = [[NSUserDefaults standardUserDefaults] valueForKey:@"userName"];
        // Read in the prior state of allowInvitations.
        self.allowInvitations = [[NSUserDefaults standardUserDefaults] valueForKey:@"allowInvitations"];
    }
    
    NSLog(@"User Name just retrieved - %@",self.userName);
    
    return;
}

- (void)storeUserDefaults {
    
    NSLog(@"Storing User Defaults");
    
    // Hard coded for now. Use for forward and/or reverse compatibility, someday.
    NSString *versionString;
    versionString = @"1.0";
    
    // Store all values in standardUserDefaults.
    [[NSUserDefaults standardUserDefaults] setObject:versionString forKey:@"versionString"];
    [[NSUserDefaults standardUserDefaults] setObject:self.maxLevelDifference forKey:@"maxLevelDifference"];
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.allowInvitations forKey:@"allowInvitations"];
    
    // Write to non-volatile memory.
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    return;
}

#pragma mark BEATER STORAGE

- (BOOL)loadBeatersFromFile {
    
    NSLog(@"In loadBeatersFromFile");
    
    // File with all beaters is beaters.btp, which includes the beater file names, 0 through 100 (if there are 100, battle is disabled, as there is no room for captured beaters). Then, each beater is in a file with that name, so there are 101 of them. If beaters.btb entry is "   " (three spaces), this indicates that the location is available.
    
    BOOL success; // YES if beaters loaded, NO if no beaters exist or file does not exist.
    success = NO; // Assume failure until success is proven.
    BOOL fileExists; // Does beaters.btb exist? If not, must be first run.
    fileExists = NO; // Assume first run.
    NSString *withPath; // Local instance of the beaters file path.
    NSString *beaterPath; // The file holding the beater of interest.
    int iKount1; // Used to index array of names.
    NSMutableArray *arrayFromFile; // Array of beater filenames.
    
    NSString *stringToCompare; // Used to compare each object in the file to "   ".
    NSString *threeSpaceString; // Used to hold "   ".
    
    numberOfBeatersOwned = [NSNumber numberWithInt:0]; // Initialize the number of beaters.
    threeSpaceString = @"   ";  // Create a blank string.
    
    // If beaters.btb does not exist, create it. Not clearly done.
    
    withPath = [self getBeatersFilePath];
    withPath = [withPath stringByAppendingString:@"beaters.btb"];
    
    // If file does not exist, skip the rest.
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:withPath];
    
    if (fileExists) {
        
        arrayFromFile = [NSMutableArray arrayWithContentsOfFile:withPath];
        
        // Load up the myBeaters array with strings from the file of beater names.
        for (iKount1=0; iKount1<101; iKount1++) {
            // Crashes here.
            [myBeaters addObject:[arrayFromFile objectAtIndex:iKount1]];
            
            // If the beater name just added is not "   ", make this the active beater.
            stringToCompare = threeSpaceString;
            if (stringToCompare != threeSpaceString) {
                // Read the beater from file "beater" + iKount1 string.
                // First, build the filename.
                beaterPath = [self getBeatersFilePath];
                beaterPath = [beaterPath stringByAppendingString:@"beater"];
                beaterPath = [beaterPath stringByAppendingString:[NSString stringWithFormat:@"%d",iKount1]];
                beaterPath = [beaterPath stringByAppendingString:@".btb"];
                // E.g., for ikount1 = 3, path is now /BattleBeaters/beater3.btb.
                
                // Now, load in the beater, including all attributes.
//                [activeBeater readBeaterFromFile:beaterPath];
                
                // If we made it here, there was at least one active beater, so change the success status.
                success = YES;
            }
        }
        
    } else {
        // If file does not exist, myBeaters should be filled with "   ".
        for (iKount1 = 0; iKount1 < 101; iKount1++) {
            [myBeaters addObject:threeSpaceString];
        }
    }
    // Active beater is now the last one in the beaters.btb file with a name not equal to "   ".
    
    return success;
}

- (NSString *)getBeatersFilePath {
    // Returns the directory in which all of the beaters are found, including beaters.btb.
    beatersFilePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/BattleBeaters/"];
    return beatersFilePath;
}

- (void)storeBeatersToFile {
    // File with all beaters is beaters.btp, which includes the beater file names, 0 through 100 (if there are 100, battle is disabled, as there is no room for captured beaters). Then, each beater is in a file with that name, so there are 101 of them. If beaters.btb entry is "   " (three spaces), this indicates that the location is available.
    NSString *withPath; // Local instance of the beaters file path.
    BOOL fileExists; // Does beaters.btb exist? If not, must be first run.
    NSString *stringToWrite; // This string is pulled from the myBeaters array and written to beaters.btb.
    
    int iKount1;
    
    NSLog(@"In storeBeatersToFile");
    withPath = [self getBeatersFilePath];
    withPath = [withPath stringByAppendingString:@"beaters.btb"];
    fileExists = [[NSFileManager defaultManager] fileExistsAtPath:withPath];
    
    // Temporarily, always run this loop.
    //if (!fileExists) {
    if (YES) {
        // First, create the file.
        [[NSFileManager defaultManager] createFileAtPath:withPath contents:nil attributes:nil];
        for (iKount1 = 0; iKount1 < 101; iKount1++){
            // Pull the next string from the array. Empty beaters will be "   ".
            stringToWrite = (NSString *)[myBeaters objectAtIndex:iKount1];
            // Write the string to the file.
            [stringToWrite writeToFile:withPath atomically:YES encoding:NSASCIIStringEncoding error:NULL];
        }
    }
    
    iKount1 = 5; // Dummy statement to provide a breakpoint.
    
    return;
}

- (void)storeOneBeaterToFile {
    NSLog(@"In storeOneBeaterToFile");
    //    [activeBeater writeBeaterToFile:;]
    return;
}

#pragma mark AlertView Methods

- (void) Show_AlertTwoMessage
{
    
    alertTwo = [[UIAlertView alloc] initWithTitle:@"No Beaters Available" message:@"You have no beaters currently available." delegate:self cancelButtonTitle:@"Generate One" otherButtonTitles: @"Purchase 10",nil];
    
    [alertTwo show];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *beaterNameToAdd; // This will be the name of the beater to add to myBeaters.
    
    if(alertView == alertTwo) {
        // AlertTwo is the generate one or purchase 10 alert.
        if (buttonIndex == 1)
        {
            int ikount1;
            NSLog(@"Try to purchase 10 Beaters");
            // Temporarily, generate 10 beaters, last one is active.
            for (ikount1 = 0;ikount1 < 10;ikount1++) {
                SHBeater *newBeater;
                NSLog(@"Generate One Beater");
                self.activeBeater = [SHBeater makeABeater];
                newBeater = self.activeBeater;
                NSLog(@"Beater Generated");
                // Assign beaterName string to be added to array in appDelegate.
                beaterNameToAdd = newBeater.beaterName;
                // Add beaterName to array in appDelegate.
                [myBeaters addObject:beaterNameToAdd];
            }
        }
        else
        {
            NSLog(@"Generate One Beater");
            self.activeBeater = [SHBeater makeABeater];
            NSLog(@"Beater Generated");
            // Assign beaterName string to be added to array in appDelegate.
            beaterNameToAdd = self.activeBeater.beaterName;
            // Add beaterName to array in appDelegate.
            [myBeaters addObject:beaterNameToAdd];
        }
        
        // Tell the appDelegate to update its files. This should actually be in the loop, as a write has to occur after each beater is added.
        [self storeBeatersToFile];
        
        // Send out message that changes were made and view needs to be refresshed.
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshView" object:nil];
    }
}

@end
