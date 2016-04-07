//
//  SHBeater.h
//  Battle-Beater
//
//  Created by Tim Stever on 11/26/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//
//  This is the class that describes a beater. It will be used by the AppDelegate to instantiate the currently active beater, and by FirstViewController to learn about the current opponent, and by SecondViewController to help select other beaters.

#import <Foundation/Foundation.h>
#import "SHWeapon.h"
#import "SHDefense.h"

@interface SHBeater : NSObject {

}

@property (nonatomic, retain) NSString *beaterName;
@property (nonatomic, retain) NSNumber *hairType, *hairModifier, *eyebrowType, *eyebrowModifier, *eyeType, *eyeModifier, *mouthType, *mouthModifier, *headType, *headModifier;
@property (nonatomic, retain) NSMutableArray *beaterWeapons, *beaterDefenses;
@property (nonatomic, retain) SHWeapon *currentWeapon;
@property (nonatomic, retain) SHDefense *currentDefense;
@property (nonatomic, retain) NSNumber *level,*healthPointsWhenHealthy,*healthPoints,*attackStrength;


- (void)generateOneBeater;
- (NSString *)getBeaterName;
- (SHWeapon *)getCurrentWeapon;
- (NSMutableArray *)getBeaterWeapons;
- (NSMutableArray *)getBeaterDefenses;
- (SHDefense *)getCurrentDefense;
- (void)writeBeaterToFile:(NSString *)withPath;
- (SHBeater *)readBeaterFromFile:(NSString *)withPath;

+ (SHBeater *)makeABeater;

@end
