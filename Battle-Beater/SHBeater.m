//
//  SHBeater.m
//  Battle-Beater
//
//  Created by Tim Stever on 11/26/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import "SHBeater.h"

@implementation SHBeater

- (id)init {
    
    /*    healthPointsWhenHealthy = [NSNumber numberWithFloat:100.0];
     healthPoints = [NSNumber numberWithFloat:100.0];
     attackStrength = [NSNumber numberWithFloat:100.0];
     level = [NSNumber numberWithFloat:1.0];
     */
    
    self.beaterWeapons = [[NSMutableArray alloc] init];
    self.beaterDefenses = [[NSMutableArray alloc] init];
    
    self = [super init];
    
    return self;
}

- (void)generateOneBeater {
    int ikount1, kountTotal, nameRandomizerInt;
    
    NSNumber *nameRandomizer;
    
    // Physical characteristics
    
    // hairType = 0 through 9
    // eyebrowType = 0 through 4
    // eyeType = 0 through 6
    // mouthType = 0 through 9
    // headType = 0 through 9
    // All modifiers are 0 through 255
    
    self.hairType = [NSNumber numberWithInt:(arc4random()% 10)];
    self.hairModifier = [NSNumber numberWithInt:(arc4random()%256)];
    self.eyebrowType = [NSNumber numberWithInt:(arc4random()% 5)];
    self.eyebrowModifier = [NSNumber numberWithInt:(arc4random()%256)];
    self.eyeType = [NSNumber numberWithInt:(arc4random()% 7)];
    self.eyeModifier = [NSNumber numberWithInt:(arc4random()%256)];
    self.mouthType = [NSNumber numberWithInt:(arc4random()% 10)];
    self.mouthModifier = [NSNumber numberWithInt:(arc4random()%256)];
    self.headType = [NSNumber numberWithInt:(arc4random()% 10)];
    self.headModifier = [NSNumber numberWithInt:(arc4random()%256)];
    
    //[hairType retain];
    //[hairModifier retain];
    //[eyebrowType retain];
    // [eyebrowModifier retain];
    //[eyeType retain];
    //[eyeModifier retain];
    //[mouthType retain];
    //[mouthModifier retain];
    // [headType retain];
    //[headModifier retain];
    
    
    NSString *keyString, *weaponString, *defenseString;
    NSMutableArray *allWeaponsArray, *allDefensesArray;
    
    allWeaponsArray = [[NSMutableArray alloc] init];
    allDefensesArray = [[NSMutableArray alloc] init];
    
    self.level = [NSNumber numberWithFloat:1.0];
    self.healthPoints = [NSNumber numberWithFloat:100.0];
    self.healthPointsWhenHealthy = [NSNumber numberWithFloat:100.0];
    self.attackStrength = [NSNumber numberWithFloat:100.0];
    
    nameRandomizer = [NSNumber numberWithInt:(arc4random()%15)];
    nameRandomizerInt = [nameRandomizer intValue];
    
    switch (nameRandomizerInt) {
            
        case 0:
            self.beaterName = @"Max Pain";
            break;
            
        case 1:
            self.beaterName = @"Watta Watta";
            break;
            
        case 2:
            self.beaterName = @"Dreamie Pie";
            break;
            
        case 3:
            self.beaterName = @"Fuzza Maledocious";
            break;
            
        case 4:
            self.beaterName = @"Gerbil";
            break;
            
        case 5:
            self.beaterName = @"Invisijoe";
            break;
            
        case 6:
            self.beaterName = @"Dragonic";
            break;
            
        case 7:
            self.beaterName = @"Heysto";
            break;
            
        case 8:
            self.beaterName = @"Banana";
            break;
            
        case 9:
            self.beaterName = @"Kampê";
            break;
            
        case 10:
            self.beaterName = @"Jack";
            break;
            
        case 11:
            self.beaterName = @"Bremida";
            break;
            
        case 12:
            self.beaterName = @"Mice";
            break;
            
        case 13:
            self.beaterName = @"MrFoof";
            break;
            
        case 14:
            self.beaterName = @"Stonehenge";
            break;
            
        default:
            self.beaterName = @"Default Name";
            break;
    }
    
    //[beaterName retain];
    
    // Read in weapons file.
    NSString *beaterWeaponsPath = [[NSBundle mainBundle] pathForResource:@"BeaterWeapons" ofType:@"plist"];
    NSMutableDictionary* weaponsDict = [[NSMutableDictionary alloc] initWithContentsOfFile:beaterWeaponsPath];
    
    NSNumber *weaponsCount;
    weaponsCount = [weaponsDict objectForKey:@"Count"];
    kountTotal = [weaponsCount intValue];
    
    SHWeapon *weaponToAdd;
    weaponToAdd = [[SHWeapon alloc] init];
    
    for (ikount1 = 0; ikount1<kountTotal; ikount1++) {
        if (ikount1<10) keyString = [NSString stringWithFormat:@"Weapon00%d",ikount1];
        if ((ikount1>=10)&&(ikount1<100)) keyString = [NSString stringWithFormat:@"Weapon0%d",ikount1];
        if (ikount1>=100) keyString = [NSString stringWithFormat:@"Weapon%d",ikount1];
        
        weaponString = [weaponsDict objectForKey:keyString];
        
        weaponToAdd = [[SHWeapon alloc] init];
        
        weaponToAdd.weaponName = weaponString;
        
        [allWeaponsArray insertObject:weaponToAdd atIndex:ikount1];
    }
    
    // Read in defenses file.
    NSString *beaterDefensesPath = [[NSBundle mainBundle] pathForResource:@"BeaterDefenses" ofType:@"plist"];
    NSMutableDictionary* defensesDict = [[NSMutableDictionary alloc] initWithContentsOfFile:beaterDefensesPath];
    
    NSNumber *defensesCount;
    defensesCount = [defensesDict objectForKey:@"Count"];
    kountTotal = [defensesCount intValue];
    
    SHDefense *defenseToAdd;
    defenseToAdd = [[SHDefense alloc] init];
    
    for (ikount1 = 0; ikount1<kountTotal; ikount1++) {
        if (ikount1<10) keyString = [NSString stringWithFormat:@"Defense00%d",ikount1];
        if ((ikount1>=10)&&(ikount1<100)) keyString = [NSString stringWithFormat:@"Defense0%d",ikount1];
        if (ikount1>=100) keyString = [NSString stringWithFormat:@"Defense%d",ikount1];
        
        defenseString = [defensesDict objectForKey:keyString];
        
        defenseToAdd = [[SHDefense alloc] init];
        
        defenseToAdd.defenseName = defenseString;
        
        [allDefensesArray insertObject:defenseToAdd atIndex:ikount1];
    }
    
    ikount1 = 0; // Reset to count weapons.
    
    long numberOfWeaponsInArray, numberOfDefensesInArray; // This is the total number of weapons and defenses to choose from.
    numberOfWeaponsInArray = [allWeaponsArray count] - 1;
    numberOfDefensesInArray = [allDefensesArray count] - 1;
    
    int randomInteger;
    bool okayToUseObject;
    
    // Generate 6 weapons to start.
    while (ikount1 < 6) {
        okayToUseObject = NO;
        // If allWeaponsArray(randomnumber) is not already in weapons list, add it, increment ikount1.
        while (!okayToUseObject) {
            // Generate a random number between 0 and weaponsCount-1.
            weaponToAdd = [[SHWeapon alloc] init];
            randomInteger = arc4random()% numberOfWeaponsInArray;
            weaponToAdd = [allWeaponsArray objectAtIndex:randomInteger];
            
            // Check to see if weaponToAdd is already in beaterWeapons.
            okayToUseObject = ![self.beaterWeapons containsObject:weaponToAdd];
            
            if (okayToUseObject) {
                [self.beaterWeapons addObject:weaponToAdd];
                ikount1++;
            }
        }
    }
    // Generate 6 defenses to start.
    ikount1 = 0; // Reset to count defenses.
    
    while (ikount1 < 6) {
        okayToUseObject = NO;
        // If allDefensesArray(randomnumber) is not already in defenses list, add it, increment ikount1.
        while (!okayToUseObject) {
            // Generate a random number between 0 and defensesCount-1.
            defenseToAdd = [[SHDefense alloc] init];
            randomInteger = arc4random()% numberOfDefensesInArray;
            defenseToAdd = [allDefensesArray objectAtIndex:randomInteger];
            
            // Check to see if defenseToAdd is already in beaterDefenses.
            okayToUseObject = ![self.beaterDefenses containsObject:defenseToAdd];
            
            if (okayToUseObject) {
                [self.beaterDefenses addObject:defenseToAdd];
                ikount1++;
            }
        }
    }
    
    // Use the first weapon and first defense as the active ones.
    self.currentWeapon = [self.beaterWeapons objectAtIndex:0];
    self.currentDefense = [self.beaterDefenses objectAtIndex:0];
    
    //[self retain];
    
    return;
}

- (NSString *)getBeaterName {
    return self.beaterName;
}

- (SHWeapon *)getCurrentWeapon {
    return self.currentWeapon;
}

- (SHDefense *)getCurrentDefense {
    return self.currentDefense;
}

- (NSMutableArray *)getBeaterWeapons {
    return self.beaterWeapons;
}

- (NSMutableArray *)getBeaterDefenses {
    return self.beaterDefenses;
}


+ (SHBeater *)makeABeater {
    SHBeater *newBeater;
    newBeater = [[SHBeater alloc] init];
    [newBeater generateOneBeater];
    return newBeater;
}

// Turn a beater into an NSData structure for storage in an array.
- (void)writeBeaterToFile:(NSString *)withPath {
    NSMutableArray *arrayToStore;
    NSNumber *numberOfWeapons, *numberOfDefenses;
    
    // Consider adding a dummy string to read and write to future proof the beater file. Any variables not needed by this revision of Battle Beaters could be stored in the dummy string, transferred from game to game, etc. Future versions of Battle Beaters would have to know how to create this string to provide for older revisions and to parse it if they get a beater file from an older version but that was created with a newer version.
    
    numberOfWeapons = [NSNumber numberWithLong:[self.beaterWeapons count]];
    numberOfDefenses = [NSNumber numberWithLong:[self.beaterDefenses count]];
    
    [arrayToStore addObject:self.beaterName];
    [arrayToStore addObject:self.hairType];
    [arrayToStore addObject:self.hairModifier];
    [arrayToStore addObject:self.eyebrowType];
    [arrayToStore addObject:self.eyebrowModifier];
    [arrayToStore addObject:self.eyeType];
    [arrayToStore addObject:self.eyeModifier];
    [arrayToStore addObject:self.mouthType];
    [arrayToStore addObject:self.mouthModifier];
    [arrayToStore addObject:self.headType];
    [arrayToStore addObject:self.headModifier];
    [arrayToStore addObject:numberOfWeapons];
    [arrayToStore addObject:numberOfDefenses];
    [arrayToStore writeToFile:withPath atomically:YES];
    return;
}

// Turnd an NSData structure from an array into an HMBeater.
- (SHBeater *)readBeaterFromFile:(NSString *)withPath {
    NSMutableArray *arrayFromFile;
    NSNumber *numberOfWeapons, *numberOfDefenses;
    
    arrayFromFile = [NSMutableArray arrayWithContentsOfFile:withPath];
    self.beaterName = [arrayFromFile objectAtIndex:0];
    self.hairType = [arrayFromFile objectAtIndex:1];
    self.hairModifier = [arrayFromFile objectAtIndex:2];
    self.eyebrowType = [arrayFromFile objectAtIndex:3];
    self.eyebrowModifier = [arrayFromFile objectAtIndex:4];
    self.eyeType = [arrayFromFile objectAtIndex:5];
    self.eyeModifier = [arrayFromFile objectAtIndex:6];
    self.mouthType = [arrayFromFile objectAtIndex:7];
    self.mouthModifier = [arrayFromFile objectAtIndex:8];
    self.headType = [arrayFromFile objectAtIndex:9];
    self.headModifier = [arrayFromFile objectAtIndex:10];
    numberOfWeapons = [arrayFromFile objectAtIndex:11];
    numberOfDefenses = [arrayFromFile objectAtIndex:12];
    return self;
}

@end
