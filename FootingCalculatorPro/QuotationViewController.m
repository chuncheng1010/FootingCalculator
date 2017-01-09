//
//  QuotationViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "QuotationViewController.h"
#import "AppDelegate.h"
#import "RegexKitLite.h"
#import "Fraction.h"

@interface QuotationViewController ()

@end

@implementation QuotationViewController

@synthesize index;
- (void)viewDidLoad {
    [super viewDidLoad];
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        //return YES; /* Device is iPad */
        //[self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"headerimage.png" ] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)] forBarMetrics:UIBarMetricsDefault];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        
    }
    else{
        self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"headerimage.png"]];
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"headerimage.png"] forBarMetrics:UIBarMetricsDefault];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    dataList = [[NSMutableArray alloc] init];
    sqlite3_stmt *selectStatement;
    NSString *str = [NSString stringWithFormat:@"SELECT length,width,depth,result FROM jobstable WHERE jobid=%d",index];
    char *selectSql = [str UTF8String];
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            //id integer primary key autoincrement,date TEXT,name TEXT,address TEXT,phone TEXT,email TEXT,quote TEXT,method TEXT,option TEXT,value TEXT,height TEXT,width TEXT,length TEXT,margin TEXT,tax TEXT,title TEXT)
            NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
            //int no = sqlite3_column_int(selectStatement, 0);
            
            //[data setObject:[NSString stringWithFormat:@"%d",no] forKey:@"id"];
            [data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)] forKey:@"length"];
            [data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)] forKey:@"width"];
            [data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)] forKey:@"depth"];
            [data setObject:[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)] forKey:@"result"];
            [dataList addObject:data];
            
        }
    }
    else
        return;
    sqlite3_finalize(selectStatement);
    
    
    selectSql = [[NSString stringWithFormat:@"SELECT date,name,address,phone,email,method,type,quote FROM jobs WHERE id=%d",index] UTF8String];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            _date.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            _name.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            _address.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            _phone.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            _email.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            method = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] intValue];
            type = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] intValue];
            _quote.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 7)];
        }
        
    }
    else
        return;
    sqlite3_finalize(selectStatement);
    [self datashow];
}

-(void)datashow
{
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    _plantother1label.text = [prefs stringForKey:@"plantlabel1"] == nil ? @"Other":[prefs stringForKey:@"plantlabel1"];
    _plantother2label.text = [prefs stringForKey:@"plantlabel2"] == nil ? @"Other":[prefs stringForKey:@"plantlabel2"];
    _plantother3label.text = [prefs stringForKey:@"plantlabel3"] == nil ? @"Other":[prefs stringForKey:@"plantlabel3"];
    
    _equipmentother1label.text = [prefs stringForKey:@"equiplabel1"] == nil ? @"Other":[prefs stringForKey:@"equiplabel1"];
    _equipmentother2label.text = [prefs stringForKey:@"equiplabel2"] == nil ? @"Other":[prefs stringForKey:@"equiplabel2"];
    _equipmentother3label.text = [prefs stringForKey:@"equiplabel3"] == nil ? @"Other":[prefs stringForKey:@"equiplabel3"];
    
    _concreteother1label.text = [prefs stringForKey:@"conotherlabel1"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel1"];
    _concreteother2label.text = [prefs stringForKey:@"conotherlabel2"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel2"];
    _concreteother3label.text = [prefs stringForKey:@"conotherlabel3"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel3"];
    _concreteother4label.text = [prefs stringForKey:@"conotherlabel4"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel4"];
    _concreteother5label.text = [prefs stringForKey:@"conotherlabel5"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel5"];
    _concreteother6label.text = [prefs stringForKey:@"conotherlabel6"] == nil ? @"Other":[prefs stringForKey:@"conotherlabel6"];
    
    _labourotherlabel.text = [prefs stringForKey:@"labourlabel"] == nil ? @"Other":[prefs stringForKey:@"labourlabel"];
    
    
    
    
    //plantvalue,plantothervalue1,plantothervalue2,plantothervalue3,toolsvalue,toolsothervalue1,toolsothervalue2,toolsothervalue3
    
    int currency;
    NSString *str;
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] intValue] == 0)
        currency = 0;
    else
        currency = [[prefs stringForKey:@"currency"] intValue];
    switch (currency) {
        case 0:
            str = @"$";
            break;
        case 1:
            str = @"€";
            break;
        case 2:
            str = @"￥";
            break;
        case 3:
            str = @"₤";
            break;
        case 4:
            str = @"F";
            break;
        default:
            break;
    }
    
    NSString *t1,*t2,*t3,*t4,*t5,*t6,*t7,*t8,*t9,*t10;
    t1 = [prefs stringForKey:@"plant1"];
    if([t1 length] == 0)
        t1 = @"50.00";
    _plant.text = [NSString stringWithFormat:@"%@%@",str,t1];
    
    t2 = [prefs stringForKey:@"plant2"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _plantother1.text = [NSString stringWithFormat:@"%@%@",str,t2];
    
    t3 = [prefs stringForKey:@"plant3"];
    if([t3 length] == 0)
        t3 = @"0.00";
    _plantother2.text = [NSString stringWithFormat:@"%@%@",str,t3];
    
    t4 = [prefs stringForKey:@"plant4"];
    if([t4 length] == 0)
        t4 = @"0.00";
    _plantother3.text = [NSString stringWithFormat:@"%@%@",str,t4];
    
    double d = [t1 doubleValue] + [t2 doubleValue] + [t3 doubleValue] + [t4 doubleValue];
    _netplant.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    t1 = [prefs stringForKey:@"equip1"];
    if([t1 length] == 0)
        t1 = @"50.00";
    _equipment.text = [NSString stringWithFormat:@"%@%@",str,t1];
    
    t2 = [prefs stringForKey:@"equip2"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _equipmentother1.text = [NSString stringWithFormat:@"%@%@",str,t2];
    
    t3 = [prefs stringForKey:@"equip3"];
    if([t3 length] == 0)
        t3 = @"0.00";
    _equipmentother2.text = [NSString stringWithFormat:@"%@%@",str,t3];
    
    t4 = [prefs stringForKey:@"equip4"];
    if([t4 length] == 0)
        t4 = @"0.00";
    _equipmentother3.text = [NSString stringWithFormat:@"%@%@",str,t4];
    
    d = [t1 doubleValue] + [t2 doubleValue] + [t3 doubleValue] + [t4 doubleValue];
    _netequipment.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    [self valueSettings];
    
    //paversvalue,roadbasevalue,beddingvalue,jointvalue,cementvalue,
    _concrete20.text = [NSString stringWithFormat:@"%@%@",str,concrete20];
    _concrete25.text = [NSString stringWithFormat:@"%@%@",str,concrete25];
    _concrete32.text = [NSString stringWithFormat:@"%@%@",str,concrete32];
    _concrete40.text = [NSString stringWithFormat:@"%@%@",str,concrete40];
    _concrete50.text = [NSString stringWithFormat:@"%@%@",str,concrete50];
    _concrete60.text = [NSString stringWithFormat:@"%@%@",str,concrete60];
    _concrete65.text = [NSString stringWithFormat:@"%@%@",str,concrete65];
    _concrete80.text = [NSString stringWithFormat:@"%@%@",str,concrete80];
    _concrete100.text = [NSString stringWithFormat:@"%@%@",str,concrete100];
    
    
    //materialothervalue1,materialothervalue2,materialothervalue3
    
    t1 = [prefs stringForKey:@"conother1"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother1.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t4 = t1;
    
    t1 = [prefs stringForKey:@"conother2"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother2.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t5 = t1;
    
    t1 = [prefs stringForKey:@"conother3"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother3.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t6 = t1;
    
    t1 = [prefs stringForKey:@"conother4"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother4.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t7 = t1;
    
    t1 = [prefs stringForKey:@"conother5"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother5.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t8 = t1;
    
    t1 = [prefs stringForKey:@"conother6"];
    if([t1 length] == 0)
        t1 = @"0.00";
    _concreteother6.text = [NSString stringWithFormat:@"%@%@",str,t1];
    t9 = t1;
    
    
    d = [t3 doubleValue] + [t4 doubleValue] + [t5 doubleValue] + [t6 doubleValue] + [t7 doubleValue] + [t8 doubleValue] + [t9 doubleValue] + [concrete20 doubleValue] + [concrete32 doubleValue] + [concrete40 doubleValue] + [concrete50 doubleValue] + [concrete60 doubleValue] + [concrete65 doubleValue] + [concrete80 doubleValue] + [concrete100 doubleValue];
    _netmaterial.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    
    double d1,d2,d3;
    t2 = [prefs stringForKey:@"labour1"];
    if([t2 length] == 0)
        t2 = @"20.00";
    d1 = [t2 doubleValue] * labourpiers;
    _labourpies.text = [NSString stringWithFormat:@"%@%.2f",str,round(d1 * 100)/100.0];
    //t3 = [NSString stringWithFormat:@"%f",d1];
    
    t2 = [prefs stringForKey:@"labour2"];
    if([t2 length] == 0)
        t2 = @"60.00";
    d2 = [t2 doubleValue] * labourpadings;
    _labourpads.text = [NSString stringWithFormat:@"%@%.2f",str,d2];
    
    t2 = [prefs stringForKey:@"labour3"];
    if([t2 length] == 0)
        t2 = @"60.00";
    d3 = [t2 doubleValue] * labourfootings;
    _labourfootings.text = [NSString stringWithFormat:@"%@%.2f",str,d3];
    
    t2 = [prefs stringForKey:@"labour4"];
    if([t2 length] == 0)
        t2 = @"0.00";
    _labourother.text = [NSString stringWithFormat:@"%@%@",str,t2];
    
    
    
    d = [t2 doubleValue] + d1 + d2 + d3;
    _netlabour.text = [NSString stringWithFormat:@"%@%.2f",str,d];
    
    d = [[_netplant.text substringFromIndex:1] doubleValue] + [[_netequipment.text substringFromIndex:1] doubleValue] + [[_netmaterial.text substringFromIndex:1] doubleValue] + [[_netlabour.text substringFromIndex:1] doubleValue];
    _totalnetcosts.text = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    [self valueCalculate];
    
    
    
    
}
-(void)valueCalculate1
{
    
}

- (IBAction)textend1:(id)sender {
    [self valueCalculate];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)valueCalculate
{
    NSString *t1,*netcost,*margin,*subto,*taxto;
    double d;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int currency;
    NSString *str;
    if([prefs stringForKey:@"currency"] == nil || [[prefs stringForKey:@"currency"] intValue] == 0)
        currency = 0;
    else
        currency = [[prefs stringForKey:@"currency"] intValue];
    switch (currency) {
        case 0:
            str = @"$";
            break;
        case 1:
            str = @"€";
            break;
        case 2:
            str = @"￥";
            break;
        case 3:
            str = @"₤";
            break;
        case 4:
            str = @"F";
            break;
        default:
            break;
    }
    
    
    t1 = _mymargin1.text;
    if([t1 length] == 0)
    {
        _mymargin1.text = @"20";
        t1 = @"20";
    }
    
    netcost = _totalnetcosts.text;
    t1 = [NSString stringWithFormat:@"%@%.2f",str,[[netcost substringFromIndex:1] doubleValue] * [t1 doubleValue] / 100];//String.format("%.2f",Double.parseDouble(t1) * Double.parseDouble(netcost) / 100);
    
    //marginvalue.setText("$" + present(t1));
    _mymargin2.text = t1;
    margin = t1;
    
    //t1 = String.format("%.2f",Double.parseDouble(netcost) + Double.parseDouble(margin));
    d = [[netcost substringFromIndex:1] doubleValue] + [[margin substringFromIndex:1] doubleValue];
    t1 = [NSString stringWithFormat:@"%@%.2f",str,d];
    _subtotal.text = t1;
    //subtotal.setText("$" + present(t1));
    subto = t1;
    
    
    t1 = _taxamount1.text;
    if([t1 length] == 0)
    {
        _taxamount1.text = @"10";
        t1 = @"10";
    }
    
    d = [t1 doubleValue] * [[subto substringFromIndex:1] doubleValue]/100;
    t1 = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];
    
    _taxamount2.text = t1;
    taxto = t1;
    
    d = [[subto substringFromIndex:1] doubleValue] + [[taxto substringFromIndex:1] doubleValue];
    t1 = [NSString stringWithFormat:@"%@%.2f",str,round(d * 100)/100.0];//String.format("%.2f",(Double.parseDouble(subto) + Double.parseDouble(taxto)));
    //total.setText("$" + present(t1));
    _total.text = t1;
}

-(void)valueCalculate:(int)value
{
    
}

-(void)valueSettings
{
     NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    int strength = [prefs stringForKey:@"strength"] == nil ? 0:[[prefs stringForKey:@"strength"] intValue];
    
    double totalcalculate = 0.0;
    for(int i = 0; i < [dataList count]; i++)
    {
        NSMutableDictionary *data = [dataList objectAtIndex:i];
        totalcalculate += [[data objectForKey:@"result"] floatValue];
    }
    if(type == 0)
    {
        labourpiers = totalcalculate;
        labourpadings = 0.0;
        labourfootings = 0.0;
    }
    if(type == 1)
    {
        labourpiers = 0.0;
        labourpadings = totalcalculate;
        labourfootings = 0.0;
    }
    if(type == 2)
    {
        labourpiers = 0.0;
        labourpadings = 0.0;
        labourfootings = totalcalculate;
    }
    
    concrete20 = @"0.00";
    concrete25 = @"0.00";
    concrete32 = @"0.00";
    concrete40 = @"0.00";
    concrete50 = @"0.00";
    concrete60 = @"0.00";
    concrete65 = @"0.00";
    concrete80 = @"0.00";
    concrete100 = @"0.00";
    
    switch (strength) {
        case 0:
            totalcalculate *= [prefs stringForKey:@"concrete20"] == nil ? 150: [[prefs stringForKey:@"concrete20"] floatValue];//Double.parseDouble(shared.getString("complate20", "150"));
            concrete20 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];//String.format("%.2f", Math.round(totalcalculate  * 100)/100.0);
            break;
        case 1:
            totalcalculate *= [prefs stringForKey:@"concrete25"] == nil ? 160: [[prefs stringForKey:@"concrete25"] floatValue];
            concrete25 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 2:
            totalcalculate *= [prefs stringForKey:@"concrete32"] == nil ? 170: [[prefs stringForKey:@"concrete32"] floatValue];//Double.parseDouble(shared.getString("complate32", "170"));
            concrete32 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];//String.format("%.2f", Math.round(totalcalculate  * 100)/100.0);
            break;
        case 3:
            totalcalculate *= [prefs stringForKey:@"concrete40"] == nil ? 180: [[prefs stringForKey:@"concrete40"] floatValue];//Double.parseDouble(shared.getString("complate40", "180"));
            concrete40 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 4:
            totalcalculate *= [prefs stringForKey:@"concrete50"] == nil ? 190: [[prefs stringForKey:@"concrete50"] floatValue];//Double.parseDouble(shared.getString("complate50", "190"));
            concrete50 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 5:
            totalcalculate *= [prefs stringForKey:@"concrete60"] == nil ? 200: [[prefs stringForKey:@"concrete60"] floatValue];//Double.parseDouble(shared.getString("complate60", "200"));
            concrete60 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 6:
            totalcalculate *= [prefs stringForKey:@"concrete65"] == nil ? 220: [[prefs stringForKey:@"concrete65"] floatValue];//Double.parseDouble(shared.getString("complate65", "220"));
            concrete65 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 7:
            totalcalculate *= [prefs stringForKey:@"concrete80"] == nil ? 240: [[prefs stringForKey:@"concrete80"] floatValue];//Double.parseDouble(shared.getString("complate80", "240"));
            concrete80 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        case 8:
            totalcalculate *= [prefs stringForKey:@"concrete100"] == nil ? 260: [[prefs stringForKey:@"concrete100"] floatValue];//Double.parseDouble(shared.getString("complate100", "260"));
            concrete100 = [NSString stringWithFormat:@"%.2f", round(totalcalculate * 100)/100.0];
            break;
        default:
            break;
    }
    
    
}

-(int)checkCompleteValue:(NSString *)edit min:(Fraction *)min max:(Fraction *)max
{
    double value;
    NSString *str = edit;
    NSString *temp;
    NSString *pat = @"(^[0-9]+)\\p{Space}([0-9]+)/([1-9]+)$";
    NSString *result = [str stringByMatching:pat];
    if(result != nil) {
        
        main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(1));
        up = [[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(2));
        down = [[str stringByMatching:pat capture:3] intValue];//Integer.parseInt(m.group(3));
        main += up/down;
        value = up/(down * 1.0);
        //value = Math.round(value * 10)/10.0;
        down = 16;
        up = (int)round(value *16);
        //System.out.println(main + " " + up + " " + down);
        if(main * 16 + up < min.main * 16 + min.up)
            return 1;
        if(main *16 + up > max.main * 16 + max.up)
            return 1;
        
    }
    else
    {
        pat = @"(^[0-9]+)\\.([0-9]+)$";
        result = [str stringByMatching:pat];
        if(result != nil)
        {
            main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(1));
            temp = [NSString stringWithFormat:@"%@.%@",[str stringByMatching:pat capture:1],[str stringByMatching:pat capture:2]];//String.format("%s.%s", m.group(1),m.group(2));
            value = [temp doubleValue];//Double.parseDouble(temp);
            value = value - main;
            down = 16;
            up = (int)round(value *16);
            //System.out.println(main + " " + up + " " + down);
        }
        else
        {
            pat = @"(^[0-9]+)/([1-9]+)$";
            result = [str stringByMatching:pat];
            if(result != nil)
            {
                main = [[str stringByMatching:pat capture:1] intValue]/[[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(1))/Integer.parseInt(m.group(2));
                up = [[str stringByMatching:pat capture:1] intValue] - main * [[str stringByMatching:pat capture:2] intValue];//Integer.parseInt(m.group(1))  - main * Integer.parseInt(m.group(2));
                //(up * 1.0)/(Integer.parseInt(m.group(2)) * 1.0);
                value = (up * 1.0)/([[str stringByMatching:pat capture:2] intValue] * 1.0);
                down = 16;
                up = (int)round(value * 16);
                
            }
            else
            {
                pat = @"(^[0-9]+)$";
                result = [str stringByMatching:pat];
                if(result != nil)
                {
                    main = [[str stringByMatching:pat capture:1] intValue];//Integer.parseInt(m.group(0));
                    up = 0;
                    down = 16;
                }
                else
                    return 0;
            }
        }
        
    }
    //System.out.println(main + " " + up + " " + down);
    if(main * 16 + up < min.main * 16 + min.up)
        return 1;
    if(main *16 + up > max.main * 16 + max.up)
        return 1;
    //edit.text = [NSString stringWithFormat:@"%@",[self display:main u:up d:16]];
    return 2;
}

-(void)savedata
{
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save these settings?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    [view show];
    //[view release];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        [self savepreferences];
    }
    //[self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)mailSend:(id)sender {
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        
        [picker setSubject:@""];
        
        [picker setToRecipients:[NSArray arrayWithObjects:_email.text,nil]];
        
        NSString *content = [NSString stringWithFormat:@"Quote: %@\n",_quote.text];
        content = [content stringByAppendingFormat:@"Date: %@\n",_date.text];
        content = [content stringByAppendingFormat:@"Name: %@\n",_name.text];
        content = [content stringByAppendingFormat:@"Address: %@\n",_address.text];
        content = [content stringByAppendingFormat:@"Phone: %@\n",_phone.text];
        content = [content stringByAppendingFormat:@"Email: %@\n",_email.text];
        
        content = [content stringByAppendingFormat:@"Plant %@ item\n",_plant.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_plantother1label.text,_plantother1.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_plantother2label.text,_plantother2.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_plantother3label.text,_plantother3.text];
        content = [content stringByAppendingFormat:@"Net Plant: %@\n",_netplant.text];
        
        content = [content stringByAppendingFormat:@"Equipment %@ item\n",_equipment.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_equipmentother1label.text,_equipmentother1.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_equipmentother2label.text,_equipmentother2.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_equipmentother3label.text,_equipmentother3.text];
        content = [content stringByAppendingFormat:@"Net Equipment: %@\n",_netequipment.text];
        
        content = [content stringByAppendingFormat:@"Concrete - 20Mpa: %@ total\n",_concrete20.text];
        content = [content stringByAppendingFormat:@"Concrete - 25Mpa: %@ total\n",_concrete25.text];
        content = [content stringByAppendingFormat:@"Concrete - 32Mpa: %@ total\n",_concrete32.text];
        content = [content stringByAppendingFormat:@"Concrete - 40Mpa: %@ total\n",_concrete40.text];
        content = [content stringByAppendingFormat:@"Concrete - 50Mpa: %@ total\n",_concrete50.text];
        content = [content stringByAppendingFormat:@"Concrete - 60Mpa: %@ total\n",_concrete60.text];
        content = [content stringByAppendingFormat:@"Concrete - 65Mpa: %@ total\n",_concrete65.text];
        content = [content stringByAppendingFormat:@"Concrete - 80Mpa: %@ total\n",_concrete80.text];
        content = [content stringByAppendingFormat:@"Concrete - 100Mpa: %@ total\n",_concrete100.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother1label.text,_concreteother1.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother2label.text,_concreteother2.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother3label.text,_concreteother3.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother4label.text,_concreteother4.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother5label.text,_concreteother5.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_concreteother6label.text,_concreteother6.text];
        content = [content stringByAppendingFormat:@"Net Materials: %@\n",_netmaterial.text];
        
        content = [content stringByAppendingFormat:@"Labour - Piers: %@ total\n",_labourpies.text];
        content = [content stringByAppendingFormat:@"Labour - Pads: %@ total\n",_labourpads.text];
        content = [content stringByAppendingFormat:@"Labour - Footings: %@ total\n",_labourfootings.text];
        content = [content stringByAppendingFormat:@"%@: %@ item\n",_labourotherlabel.text,_labourother.text];
        content = [content stringByAppendingFormat:@"Net Labour: %@\n",_netlabour.text];
        
        content = [content stringByAppendingFormat:@"Total Net Costs: %@\n",_totalnetcosts.text];
        content = [content stringByAppendingFormat:@"My Margin: %@ %@\n",_mymargin1.text,_mymargin2.text];
        content = [content stringByAppendingFormat:@"Sub TOTAL: %@\n",_subtotal.text];
        content = [content stringByAppendingFormat:@"Tax Amount: %@ %@\n",_taxamount1.text,_taxamount2.text];
        content = [content stringByAppendingFormat:@"TOTAL: %@\n",_total.text];
        
        
        
        
        
        
        
        [picker setMessageBody:content isHTML:NO];
        
        [self presentModalViewController:picker animated:YES];
        
        
    }
    else
    {
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Can not send Mail." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        
    }
}

- (void) mailComposeController:(MFMailComposeViewController *) controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    UIAlertView *view;
    if(result == MFMailComposeResultSent)
    {
        view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    }
    else
    {
        view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully not sent" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    }
    [view show];
    
    [controller dismissModalViewControllerAnimated:YES];
}

-(void)savepreferences
{
    sqlite3_stmt *selectStatement;
    char *selectSql = "update jobs set date=?,name=?,phone=?,address=?,email=?,quote=? where id=?";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(selectStatement, 1, [_date.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 2, [_name.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 3, [_phone.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 4, [_address.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 5, [_email.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 6, [_quote.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(selectStatement, 7, index);
        int success = sqlite3_step(selectStatement);
        sqlite3_reset(selectStatement);
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        //[view release];
        
    }
    
    sqlite3_finalize(selectStatement);
    //[self.mymargin1 becomeFirstResponder];
    
}

- (IBAction)textend:(id)sender {
}

- (IBAction)saveData:(id)sender {
    [self savedata];
}
@end
