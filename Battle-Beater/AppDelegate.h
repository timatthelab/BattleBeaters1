//
//  AppDelegate.h
//  Battle-Beater
//
//  Created by Tim Stever on 7/22/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

// The AppDelegate is always available. Therefore, it should contain all global variables and serve as a message gateway between various objects in Battle Beaters.
//
// The AppDelegate should also serve as the GameKit helper and the StoreKit helper. Therefore, all purchases go through it, and the GameKit interactions, which are the actual battle messages over networks, go through it.
//
// For consistency, the AppDelegate will always be instantiated as "theApp". Therefore, all methods are [theApp methodName], all variables are [theApp getVariable], and all properties are theApp.propertyName.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h> // Framework for in-app purchases.
#import <GameKit/GameKit.h> // Framework for network competition.

#import "SHBeater.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    
    // Game Kit related variables.
    
    BOOL inCombat; // Status=YES when engaged in battle. If YES, prevents some actions.
    BOOL readyForCombat; // Status=YES to advertise availability, NO to withdraw, which allows editing or changing beaters. If readyForCombat, gameCenter will automatically try to find a match.
    BOOL isSignedIntoGameCenter; // Status=YES if device is signed into GameCenter.
    
    NSMutableArray *myBeaters; // Up to 100 (or a little more?) beaters owned by this app. This array holds just the file names for each.
    NSNumber *numberOfBeatersOwned; // Keep track of the total in stable.
    NSString *beatersFilePath; // The file path for the list of up to 100 beaters.
    
    UIAlertView *alertTwo;
}

@property (strong, nonatomic) UIWindow *window;

// Instance variables (properties) to be used as global variables.
@property (strong, nonatomic) NSString *userName;  // The user name to appear in Battles.
@property (strong, nonatomic) NSNumber *maxLevelDifference; // The maximum difference in levels for combat invitations.
@property (strong, nonatomic) NSNumber *allowInvitations; // Boolean as number (0/1) to indicate whether invitations are allowed by default (i.e., as soon as the Game Center is started).
@property (strong, nonatomic) SHBeater *activeBeater; // The beater that is currently available for review, editing, or battle.
@property (strong, nonatomic) NSNumber *inCombat, *readyForCombat; // Will use NSNumber for booleans.

+ (AppDelegate *)sharedInstance; // The singleton creator/access method.

// User defaults, load and store.
- (void)loadUserDefaults;
- (void)storeUserDefaults;

// Beater storage.
- (BOOL)loadBeatersFromFile;
- (NSString *)getBeatersFilePath;
- (void)storeBeatersToFile;
- (void)storeOneBeaterToFile;

@end

