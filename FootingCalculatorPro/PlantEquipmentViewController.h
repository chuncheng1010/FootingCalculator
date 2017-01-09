//
//  PlantEquipmentViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlantEquipmentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *plantlabel1;
@property (weak, nonatomic) IBOutlet UITextField *plantlabel2;
@property (weak, nonatomic) IBOutlet UITextField *plantlabel3;
@property (weak, nonatomic) IBOutlet UITextField *plantlabel4;
@property (weak, nonatomic) IBOutlet UITextField *plant1;
@property (weak, nonatomic) IBOutlet UITextField *plant2;
@property (weak, nonatomic) IBOutlet UITextField *plant3;
@property (weak, nonatomic) IBOutlet UITextField *plant4;


@property (weak, nonatomic) IBOutlet UITextField *equipmentlabel1;
@property (weak, nonatomic) IBOutlet UITextField *equipmentlabel2;
@property (weak, nonatomic) IBOutlet UITextField *equipmentlabel3;
@property (weak, nonatomic) IBOutlet UITextField *equipmentlabel4;
@property (weak, nonatomic) IBOutlet UITextField *equip1;
@property (weak, nonatomic) IBOutlet UITextField *equip2;
@property (weak, nonatomic) IBOutlet UITextField *equip3;
@property (weak, nonatomic) IBOutlet UITextField *equip4;

-(void)getpreferences;
-(NSString *)valueSetring:(NSString *)value max:(NSString *)max;
- (IBAction)savePreferences:(id)sender;
- (IBAction)textend:(id)sender;

@end
