//
//  HomeViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

@interface HomeViewController : UIViewController
{
    int main;
    int up;
    int down;
    int selectedmethod;
    NSMutableArray *dataList;
    int type;
    int method;
    UITextField *comment1;
    int selectedIndex;
}

@property (weak, nonatomic) IBOutlet UILabel *methodlabel;

@property (weak, nonatomic) IBOutlet UILabel *valuelabel1;
@property (weak, nonatomic) IBOutlet UILabel *valuelabel2;
@property (weak, nonatomic) IBOutlet UILabel *valuelabel3;
@property (weak, nonatomic) IBOutlet UITextField *value1;
@property (weak, nonatomic) IBOutlet UITextField *value2;
@property (weak, nonatomic) IBOutlet UITextField *value3;
@property (weak, nonatomic) IBOutlet UILabel *valueunit1;
@property (weak, nonatomic) IBOutlet UILabel *valueunit2;
@property (weak, nonatomic) IBOutlet UILabel *valueunit3;
- (IBAction)footingcalculate:(id)sender;
- (IBAction)deleteEntry:(id)sender;
- (IBAction)editEntry:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *result1;
@property (weak, nonatomic) IBOutlet UITextField *result2;
@property (weak, nonatomic) IBOutlet UILabel *resultunit1;
@property (weak, nonatomic) IBOutlet UILabel *resultunit2;
@property (weak, nonatomic) IBOutlet UITableView *tableList;
-(int)checkCompleteValue:(UITextField *)edit min:(Fraction *)min max:(Fraction *)max;
-(int)checkCompleteValue1:(NSString *)edit min:(Fraction *)min max:(Fraction *)max;
-(NSString *)display:(int)m u:(int)u d:(int)d;
-(void) tableRefresh;
-(void)showTable;
- (IBAction)saveDatas:(id)sender;
-(void)savepreferences;
- (IBAction)textend:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *header1;
@property (weak, nonatomic) IBOutlet UILabel *header2;
@property (weak, nonatomic) IBOutlet UILabel *header3;
@property (weak, nonatomic) IBOutlet UILabel *header4;
@property (weak, nonatomic) IBOutlet UILabel *header5;
@end
