//
//  EditBeaterViewController.h
//  Battle-Beater
//
//  Created by Tim Stever on 10/10/15.
//  Copyright (c) 2015 Tim Stever. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EditBeaterViewController;

@protocol EditBeaterViewControllerDelegate <NSObject>

- (void)editBeaterViewControllerDidRevert:(EditBeaterViewController *)controller;

- (void)editBeaterViewControllerDidSave:(EditBeaterViewController *)controller;

@end // @protocol

// Problem - by sublcassing UIVIewController, it is hard to link back the segue, which seems to need a NavigationController.
@interface EditBeaterViewController : UIViewController

@property (nonatomic, weak) id <EditBeaterViewControllerDelegate>delegate;

- (IBAction)revert:(id)sender;

- (IBAction)save:(id)sender;

@end
