//
//  UserPreferencesViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserPreferencesViewController : UIViewController
{
    int typeindex;
    int strengthindex;
    int preferenceindex;
    int methodindex;
    int currencyindex;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *strengthSegment;
@property (weak, nonatomic) IBOutlet UISegmentedControl *preferenceSegment;

@property (weak, nonatomic) IBOutlet UISegmentedControl *methodSegment;
- (IBAction)savePreferences:(id)sender;
- (IBAction)measurementSelect:(id)sender;
- (IBAction)concreteSelect:(id)sender;
- (IBAction)strengthSelect:(id)sender;
- (IBAction)userpreferenceSelect:(id)sender;
-(void)stringthDisplay:(int)value;
-(void)concreteTypeDisplay:(int)value;
-(void)measurementsDisplay:(int)value;
-(void)userPreferenceDisplay:(int)value;
@property (weak, nonatomic) IBOutlet UIButton *strengthbtn;
@property (weak, nonatomic) IBOutlet UIButton *quotationbtn;
@property (weak, nonatomic) IBOutlet UIButton *typebtn;
@property (weak, nonatomic) IBOutlet UIButton *methodbtn;

@end
