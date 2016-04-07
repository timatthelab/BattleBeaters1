//
//  SHWeapon.m
//  Battle-Beater
//
//  Created by Tim Stever on 1/1/16.
//  Copyright © 2016 Tim Stever. All rights reserved.
//

#import "SHWeapon.h"

@implementation SHWeapon

- (SHWeapon *)init {
    self.weaponName = [[NSString alloc] init];
    self.weaponName = @"aweapon";
    return self;
}

- (NSArray *)getStats{
    NSArray *returnArray;
    returnArray = [NSArray arrayWithObjects:cutValue,poundValue,missileValue,mentalValue,concentrationValue,willpowerValue,nil];
    return returnArray;
}

- (void)setStatsWithFloats:(NSArray *)floatsArray{
    cutValue = [floatsArray objectAtIndex:0];
    poundValue = [floatsArray objectAtIndex:1];
    missileValue = [floatsArray objectAtIndex:2];
    mentalValue = [floatsArray objectAtIndex:3];
    concentrationValue = [floatsArray objectAtIndex:4];
    willpowerValue = [floatsArray objectAtIndex:5];
    return;
}

@end
