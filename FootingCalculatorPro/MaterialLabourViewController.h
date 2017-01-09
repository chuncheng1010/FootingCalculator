//
//  MaterialLabourViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialLabourViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *concrete1;
@property (weak, nonatomic) IBOutlet UITextField *concrete2;
@property (weak, nonatomic) IBOutlet UITextField *concrete3;
@property (weak, nonatomic) IBOutlet UITextField *concrete4;
@property (weak, nonatomic) IBOutlet UITextField *concrete5;
@property (weak, nonatomic) IBOutlet UITextField *concrete6;
@property (weak, nonatomic) IBOutlet UITextField *concrete7;
@property (weak, nonatomic) IBOutlet UITextField *concrete8;
@property (weak, nonatomic) IBOutlet UITextField *concrete9;
@property (weak, nonatomic) IBOutlet UILabel *conunit1;
@property (weak, nonatomic) IBOutlet UILabel *conunit2;
@property (weak, nonatomic) IBOutlet UILabel *conunit3;
@property (weak, nonatomic) IBOutlet UILabel *conunit4;
@property (weak, nonatomic) IBOutlet UILabel *conunit5;
@property (weak, nonatomic) IBOutlet UILabel *conunit6;
@property (weak, nonatomic) IBOutlet UILabel *conunit7;
@property (weak, nonatomic) IBOutlet UILabel *conunit8;
@property (weak, nonatomic) IBOutlet UILabel *conunit9;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel1;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel2;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel3;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel4;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel5;
@property (weak, nonatomic) IBOutlet UITextField *conotherlabel6;
@property (weak, nonatomic) IBOutlet UITextField *conother1;
@property (weak, nonatomic) IBOutlet UITextField *conother2;
@property (weak, nonatomic) IBOutlet UITextField *conother3;
@property (weak, nonatomic) IBOutlet UITextField *conother4;
@property (weak, nonatomic) IBOutlet UITextField *conother5;
@property (weak, nonatomic) IBOutlet UITextField *conother6;
@property (weak, nonatomic) IBOutlet UITextField *labour1;
@property (weak, nonatomic) IBOutlet UITextField *labour2;
@property (weak, nonatomic) IBOutlet UITextField *labour3;
@property (weak, nonatomic) IBOutlet UITextField *labour4;
@property (weak, nonatomic) IBOutlet UITextField *labourlabel;
@property (weak, nonatomic) IBOutlet UILabel *labourunit1;
@property (weak, nonatomic) IBOutlet UILabel *labourunit2;
@property (weak, nonatomic) IBOutlet UILabel *labourunit4;

-(void)getpreferences;
-(NSString *)valueSetring:(NSString *)value max:(NSString *)max;

- (IBAction)saveMaterialCosts:(id)sender;

- (IBAction)textend:(id)sender;

@end
