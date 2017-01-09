//
//  CalculationViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface CalculationViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    int index;
    NSMutableArray *dataList;
    int method;
    int type;
    int main,up,down;
}
@property (assign) int index;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *totalconcrete;
@property (weak, nonatomic) IBOutlet UITextField *totallength;
-(void)calculateValue;
- (IBAction)textend:(id)sender;
- (IBAction)mailSend:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableList;
-(NSString *)display:(int)m u:(int)u d:(int)d;
-(int)checkCompleteValue1:(NSString *)edit min:(Fraction *)min max:(Fraction *)max;
@property (weak, nonatomic) IBOutlet UILabel *concreteunit;
@property (weak, nonatomic) IBOutlet UILabel *lengthunit;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
- (IBAction)textend1:(id)sender;
- (IBAction)saveData:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *header1;
@property (weak, nonatomic) IBOutlet UILabel *header2;
@property (weak, nonatomic) IBOutlet UILabel *header3;
@property (weak, nonatomic) IBOutlet UILabel *header4;

@property (weak, nonatomic) IBOutlet UILabel *header5;
@end
