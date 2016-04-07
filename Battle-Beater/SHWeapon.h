//
//  SHWeapon.h
//  Battle-Beater
//
//  Created by Tim Stever on 1/1/16.
//  Copyright © 2016 Tim Stever. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SHWeapon : NSObject {
    
    NSNumber *cutValue, *poundValue, *missileValue, *mentalValue, *concentrationValue, *willpowerValue;
}

@property (nonatomic, retain) NSString *weaponName;

- (NSArray *)getStats;
- (void)setStatsWithFloats:(NSArray *)floatsArray;


@end
