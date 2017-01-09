//
//  QuotationViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Fraction.h"

#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>

@interface QuotationViewController : UIViewController<MFMailComposeViewControllerDelegate>
{
    int index;
    NSMutableArray *dataList;
    int method;
    int type;
    int main,up,down;
    NSString *concrete20,*concrete25,*concrete32,*concrete40,*concrete50,*concrete60,*concrete65,*concrete80,*concrete100;
    double labourpiers,labourpadings,labourfootings;
}
@property (assign) int index;


@property (weak, nonatomic) IBOutlet UITextField *quote;
@property (weak, nonatomic) IBOutlet UITextField *date;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *plant;
@property (weak, nonatomic) IBOutlet UITextField *plantother1;
@property (weak, nonatomic) IBOutlet UITextField *plantother2;
@property (weak, nonatomic) IBOutlet UITextField *plantother3;
@property (weak, nonatomic) IBOutlet UITextField *netplant;

@property (weak, nonatomic) IBOutlet UITextField *equipment;
@property (weak, nonatomic) IBOutlet UITextField *equipmentother1;
@property (weak, nonatomic) IBOutlet UITextField *equipmentother2;
@property (weak, nonatomic) IBOutlet UITextField *equipmentother3;
@property (weak, nonatomic) IBOutlet UITextField *netequipment;

@property (weak, nonatomic) IBOutlet UITextField *concrete20;
@property (weak, nonatomic) IBOutlet UITextField *concrete25;
@property (weak, nonatomic) IBOutlet UITextField *concrete32;
@property (weak, nonatomic) IBOutlet UITextField *concrete40;
@property (weak, nonatomic) IBOutlet UITextField *concrete50;
@property (weak, nonatomic) IBOutlet UITextField *concrete60;
@property (weak, nonatomic) IBOutlet UITextField *concrete65;
@property (weak, nonatomic) IBOutlet UITextField *concrete80;
@property (weak, nonatomic) IBOutlet UITextField *concrete100;
@property (weak, nonatomic) IBOutlet UITextField *concreteother1;
@property (weak, nonatomic) IBOutlet UITextField *concreteother2;
@property (weak, nonatomic) IBOutlet UITextField *concreteother3;
@property (weak, nonatomic) IBOutlet UITextField *concreteother4;
@property (weak, nonatomic) IBOutlet UITextField *concreteother5;
@property (weak, nonatomic) IBOutlet UITextField *concreteother6;
@property (weak, nonatomic) IBOutlet UITextField *netmaterial;
@property (weak, nonatomic) IBOutlet UITextField *labourpies;
@property (weak, nonatomic) IBOutlet UITextField *labourpads;
@property (weak, nonatomic) IBOutlet UITextField *labourfootings;
@property (weak, nonatomic) IBOutlet UITextField *labourother;
@property (weak, nonatomic) IBOutlet UITextField *netlabour;

@property (weak, nonatomic) IBOutlet UITextField *totalnetcosts;
@property (weak, nonatomic) IBOutlet UITextField *mymargin1;
@property (weak, nonatomic) IBOutlet UITextField *mymargin2;
@property (weak, nonatomic) IBOutlet UITextField *subtotal;
@property (weak, nonatomic) IBOutlet UITextField *taxamount1;
@property (weak, nonatomic) IBOutlet UITextField *taxamount2;
@property (weak, nonatomic) IBOutlet UITextField *total;

@property (weak, nonatomic) IBOutlet UILabel *plantother1label;
@property (weak, nonatomic) IBOutlet UILabel *plantother2label;
@property (weak, nonatomic) IBOutlet UILabel *plantother3label;
@property (weak, nonatomic) IBOutlet UILabel *equipmentother1label;
@property (weak, nonatomic) IBOutlet UILabel *equipmentother2label;
@property (weak, nonatomic) IBOutlet UILabel *equipmentother3label;

@property (weak, nonatomic) IBOutlet UILabel *concreteother1label;
@property (weak, nonatomic) IBOutlet UILabel *concreteother2label;
@property (weak, nonatomic) IBOutlet UILabel *concreteother3label;
@property (weak, nonatomic) IBOutlet UILabel *concreteother4label;
@property (weak, nonatomic) IBOutlet UILabel *concreteother5label;
@property (weak, nonatomic) IBOutlet UILabel *concreteother6label;
@property (weak, nonatomic) IBOutlet UILabel *labourotherlabel;

- (IBAction)textend:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *name;

- (IBAction)mailSend:(id)sender;

- (IBAction)saveData:(id)sender;
-(int)checkCompleteValue:(NSString *)edit min:(Fraction *)min max:(Fraction *)max;
-(void)valueCalculate:(int)value;
-(void)valueCalculate1;
- (IBAction)textend1:(id)sender;
@end
