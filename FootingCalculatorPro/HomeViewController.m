//
//  HomeViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "HomeViewController.h"
#import "RegexKitLite.h"
#import "DataListTableViewCell.h"
#import "AppDelegate.h"
@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    dataList = [NSMutableArray arrayWithCapacity:1];
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
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [dataList removeAllObjects];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    selectedIndex = -1;
    _value1.text = @"";
    _value2.text = @"";
    _value3.text = @"";
    _result1.text = @"";
    _result2.text = @"";
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    
    
    
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] intValue] == 0)
    {
        method = 0;
        //metric
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            //piers
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Piers - Metric"];
            [attributeString addAttribute:NSUnderlineStyleAttributeName
                                    value:[NSNumber numberWithInt:1]
                                    range:(NSRange){0,[attributeString length]}];
            //_methodlabel.text = @"Paving Calculator - Imperial";
            _methodlabel.attributedText = attributeString;
            
            _valuelabel1.text = @"1. Diameter";
            _valueunit1.text = @"MM";
            _valuelabel2.text = @"2. Depth";
            _valueunit2.text = @"METER";
            _valuelabel3.hidden = YES;
            _value3.hidden = YES;
            _valueunit3.hidden = YES;
            _resultunit1.text = [NSString stringWithFormat:@"M%@",temp];
            _resultunit2.text = @"METRES";
            //table list setting
            type = 0;
            
            _header1.text = @"No.";
            _header2.text = @"Dia";
            _header3.text = @"   ";
            _header4.text = @"Depth";
            _header5.text = [NSString stringWithFormat:@"M%@",temp];
            
        }
        else{
            if([[prefs stringForKey:@"type"] intValue] == 1)
            {
                //pads
                
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Pads - Metric"];
                [attributeString addAttribute:NSUnderlineStyleAttributeName
                                        value:[NSNumber numberWithInt:1]
                                        range:(NSRange){0,[attributeString length]}];
                //_methodlabel.text = @"Paving Calculator - Imperial";
                _methodlabel.attributedText = attributeString;
                _valuelabel1.text = @"1. Length";
                _valueunit1.text = @"MM";
                _valuelabel2.text = @"2. Width";
                _valueunit2.text = @"MM";
                _valuelabel3.hidden = NO;
                _value3.hidden = NO;
                _valueunit3.hidden = NO;
                _valuelabel3.text = @"3. Depth";
                _valueunit3.text = @"MM";
                _resultunit1.text = [NSString stringWithFormat:@"M%@",temp];
                _resultunit2.text = @"METRES";
                
                type = 1;
                
                _header1.text = @"No.";
                _header2.text = @"(L)";
                _header3.text = @"(W)";
                _header4.text = @"(D)";
                _header5.text = [NSString stringWithFormat:@"M%@",temp];
                
            }
            else
            {
                //footings
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Footings - Metric"];
                [attributeString addAttribute:NSUnderlineStyleAttributeName
                                        value:[NSNumber numberWithInt:1]
                                        range:(NSRange){0,[attributeString length]}];
                //_methodlabel.text = @"Paving Calculator - Imperial";
                _methodlabel.attributedText = attributeString;
                _valuelabel1.text = @"1. Width";
                _valueunit1.text = @"MM";
                _valuelabel2.text = @"2. Depth";
                _valueunit2.text = @"MM";
                _valuelabel3.hidden = NO;
                _value3.hidden = NO;
                _valueunit3.hidden = NO;
                _valuelabel3.text = @"3. Lenght";
                _valueunit3.text = @"METRES";
                _resultunit1.text = [NSString stringWithFormat:@"M%@",temp];
                _resultunit2.text = @"METRES";
                
                type = 2;
                
                _header1.text = @"No.";
                _header2.text = @"(W)";
                _header3.text = @"(D)";
                _header4.text = @"(L)";
                _header5.text = [NSString stringWithFormat:@"M%@",temp];
                
            }
            
        }
    }
    else
    {
        method = 1;
        //imperial
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            //piers
            NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Piers - Imperial"];
            [attributeString addAttribute:NSUnderlineStyleAttributeName
                                    value:[NSNumber numberWithInt:1]
                                    range:(NSRange){0,[attributeString length]}];
            //_methodlabel.text = @"Paving Calculator - Imperial";
            _methodlabel.attributedText = attributeString;
            //_methodlabel.text = @"Piers - Imperial";
            _valuelabel1.text = @"1. Diameter";
            _valueunit1.text = @"INCHS";
            _valuelabel2.text = @"2. Depth";
            _valueunit2.text = @"FEET";
            _valuelabel3.hidden = YES;
            _value3.hidden = YES;
            _valueunit3.hidden = YES;
            _resultunit1.text = [NSString stringWithFormat:@"FT%@",temp];
            _resultunit2.text = @"FEET";
            //table list setting
            type = 0;
            
            _header1.text = @"No.";
            _header2.text = @"Dia";
            _header3.text = @"   ";
            _header4.text = @"Depth";
            _header5.text = [NSString stringWithFormat:@"FT%@",temp];
        }
        else{
            if([[prefs stringForKey:@"type"] intValue] == 1)
            {
                //pads
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Pads - Imperial"];
                [attributeString addAttribute:NSUnderlineStyleAttributeName
                                        value:[NSNumber numberWithInt:1]
                                        range:(NSRange){0,[attributeString length]}];
                //_methodlabel.text = @"Paving Calculator - Imperial";
                _methodlabel.attributedText = attributeString;
                _valuelabel1.text = @"1. Length";
                _valueunit1.text = @"INCHS";
                _valuelabel2.text = @"2. Width";
                _valueunit2.text = @"INCHS";
                _valuelabel3.hidden = NO;
                _value3.hidden = NO;
                _valueunit3.hidden = NO;
                _valuelabel3.text = @"3. Depth";
                _valueunit3.text = @"INCHS";
                _resultunit1.text = [NSString stringWithFormat:@"FT%@",temp];
                _resultunit2.text = @"FEET";
                
                type = 1;
                
                _header1.text = @"No.";
                _header2.text = @"(L)";
                _header3.text = @"(W)";
                _header4.text = @"(D)";
                 _header5.text = [NSString stringWithFormat:@"FT%@",temp];
                
            }
            else
            {
                //footings
                NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:@"Concrete Footing - Imperial"];
                [attributeString addAttribute:NSUnderlineStyleAttributeName
                                        value:[NSNumber numberWithInt:1]
                                        range:(NSRange){0,[attributeString length]}];
                //_methodlabel.text = @"Paving Calculator - Imperial";
                _methodlabel.attributedText = attributeString;
                _valuelabel1.text = @"1. Width";
                _valueunit1.text = @"INCHS";
                _valuelabel2.text = @"2. Depth";
                _valueunit2.text = @"INCHS";
                _valuelabel3.hidden = NO;
                _value3.hidden = NO;
                _valueunit3.hidden = NO;
                _valuelabel3.text = @"3. Length";
                _valueunit3.text = @"FEET";
                _resultunit1.text = [NSString stringWithFormat:@"FT%@",temp];
                _resultunit2.text = @"FEET";
                
                type = 2;
                
                _header1.text = @"No.";
                _header2.text = @"(W)";
                _header3.text = @"(D)";
                _header4.text = @"(L)";
                 _header5.text = [NSString stringWithFormat:@"FT%@",temp];
            }
            
        }
        
    }
    [self.tableList reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation: UITableViewRowAnimationAutomatic];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(int)checkCompleteValue1:(NSString *)edit min:(Fraction *)min max:(Fraction *)max
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
-(int)checkCompleteValue:(UITextField *)edit min:(Fraction *)min max:(Fraction *)max
{
    double value;
    NSString *str = edit.text;
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
    edit.text = [NSString stringWithFormat:@"%@",[self display:main u:up d:16]];
    return 2;
}

-(NSString *)display:(int)m u:(int)u d:(int)d
{
    if(m == 0 && u == 0)
        return @"0";
    if(m != 0 && u != 0)
        return [NSString stringWithFormat:@"%d %d/%d",m,u,16];//String.format("%d %d/%d", m,u,16);
    else if(m == 0)
        return [NSString stringWithFormat:@"%d/%d",u,16];//String.format("%d/%d", u,16);
    else
        return [NSString stringWithFormat:@"%d",m];//String.format("%d", m);
}
-(void)tableRefresh
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSString *resultStr;
    NSMutableDictionary  *dict = [[NSMutableDictionary  alloc]init];
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] intValue] == 0)
    {
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            if([_value1.text  isEqual: @""] || [_value2.text  isEqual: @""])
            {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input values." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            if([_value1.text doubleValue] < 50 || [_value1.text doubleValue] > 2000)
            {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Diameter." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            if([_value2.text doubleValue] < 0.05 || [_value2.text doubleValue] > 100)
            {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Diameter." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            _value1.text = [NSString stringWithFormat:@"%d",[_value1.text intValue]];
            _value2.text = [NSString stringWithFormat:@"%.03f",[_value2.text doubleValue]];
            double value1 = [_value1.text doubleValue];
            double value2 = [_value2.text doubleValue];
            double result = 3.142 * pow((value1/1000),2) * value2;
            resultStr = [NSString stringWithFormat:@"%.03f",round(result * 1000)/1000.0];
            [dict setValue:_value1.text forKey:@"diameter"];
            [dict setValue:_value2.text forKey:@"depth"];
            [dict setValue:resultStr forKey:@"result"];
            
            if(selectedIndex == -1)
                [dataList addObject:dict];
            else
                [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
        }
        else
        {
            if([[prefs stringForKey:@"type"] intValue] == 1)
            {
                //pads
                if([_value1.text isEqualToString:@""] || [_value2.text isEqualToString:@""] || [_value3.text isEqualToString:@""])
                {
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input values." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value1.text doubleValue] < 50 || [_value1.text doubleValue] > 900)
                {
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value2.text doubleValue] < 50 || [_value2.text doubleValue] > 900)
                {
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value3.text doubleValue] < 50 || [_value3.text doubleValue] > 900)
                {
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                _value1.text = [NSString stringWithFormat:@"%d",[_value1.text intValue]];
                _value2.text = [NSString stringWithFormat:@"%d",[_value2.text intValue]];
                _value3.text = [NSString stringWithFormat:@"%d",[_value3.text intValue]];
                
                double value1 = [_value1.text doubleValue];
                double value2 = [_value2.text doubleValue];
                double value3 = [_value3.text doubleValue];
                double result = (value1/1000) * (value3/1000) * (value2/1000);
                resultStr = [NSString stringWithFormat:@"%.03f",round(result * 1000)/1000.0];
                
                [dict setValue:_value1.text forKey:@"length"];
                [dict setValue:_value2.text forKey:@"width"];
                [dict setValue:_value3.text forKey:@"depth"];
                [dict setValue:resultStr forKey:@"result"];
                
                if(selectedIndex == -1)
                    [dataList addObject:dict];
                else
                    [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
            }
            else
            {
                if([_value1.text isEqualToString:@""] || [_value2.text isEqualToString:@""] || [_value3.text isEqualToString:@""])
                {
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input values." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value1.text doubleValue] < 0.01 || [_value1.text doubleValue] > 1000)
                {
                    _value1.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value2.text doubleValue] < 50 || [_value2.text doubleValue] > 6000)
                {
                    _value2.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if([_value3.text doubleValue] < 50 || [_value3.text doubleValue] > 1000)
                {
                    _value3.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                
                _value1.text = [NSString stringWithFormat:@"%.03f",[_value1.text doubleValue]];
                _value2.text = [NSString stringWithFormat:@"%d",[_value2.text intValue]];
                _value3.text = [NSString stringWithFormat:@"%d",[_value3.text intValue]];
                
                double value1,value2,value3;
                value1 = [_value1.text doubleValue];
                value2 = [_value2.text doubleValue];
                value3 = [_value3.text doubleValue];
                double result = value1 * (value3/1000) * (value2/1000);
                resultStr = [NSString stringWithFormat:@"%.03f",round(result * 1000)/1000.0];
                
                [dict setValue:_value1.text forKey:@"length"];
                [dict setValue:_value2.text forKey:@"depth"];
                [dict setValue:_value3.text forKey:@"width"];
                [dict setValue:resultStr forKey:@"result"];
                
                if(selectedIndex == -1)
                    [dataList addObject:dict];
                else
                    [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
            }
        }
    }
    else
    {
        Fraction *min = [[Fraction alloc] init];
        
        Fraction *max = [[Fraction alloc] init];
        
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            Fraction *diafraction = [[Fraction alloc] init];
            Fraction *depthfraction = [[Fraction alloc] init];
            min.main = 0;
            min.up = 1;
            min.down = 16;
            
            max.main = 72;
            max.up = 0;
            max.down = 0;
            
            int ret = [self checkCompleteValue:_value1 min:min max:max];
            if( ret == 0)
            {
                _value1.text = @"";
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Diameter." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            } else if(ret == 1)
            {
                _value1.text = @"";
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            diafraction.main = main;
            diafraction.up = up;
            diafraction.down = down;
            
            min.main = 0;
            min.up = 1;
            min.down = 16;
            max.main = 300;
            max.up = 0;
            max.down = 0;
            ret = [self checkCompleteValue:_value2 min:min max:max];
            if(ret == 0)
            {
                _value2.text = @"";
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            else if(ret == 1)
            {
                _value2.text = @"";
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                [view show];
                return;
            }
            depthfraction.main = main;
            depthfraction.up = up;
            depthfraction.down = down;
            double value1,value2;
            value1 = (diafraction.main * 16 + diafraction.up) / 16.0;
            value2 = (depthfraction.main * 16 + depthfraction.up) / 16.0;
            double result = 3.142 * pow((value1/12),2) * value2;
            resultStr = [NSString stringWithFormat:@"%.03f", round(result * 1000)/1000.0];
            
            [dict setValue:_value1.text forKey:@"diameter"];
            [dict setValue:_value2.text forKey:@"depth"];
            [dict setValue:resultStr forKey:@"result"];
            
            if(selectedIndex == -1)
                [dataList addObject:dict];
            else
                [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
        }
        else
        {
            if([[prefs stringForKey:@"type"] intValue] == 1)
            {
                Fraction *length = [[Fraction alloc] init];
                Fraction *width = [[Fraction alloc] init];
                Fraction *depth = [[Fraction alloc] init];
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 1000;
                max.up = 0;
                max.down = 0;
                
                int ret = [self checkCompleteValue:_value1 min:min max:max];
                if(ret == 0)
                {
                    _value1.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value1.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                length.main = main;
                length.up = up;
                length.down = down;
                
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 1000;
                max.up = 0;
                max.down = 0;
                
                ret = [self checkCompleteValue:_value2 min:min max:max];
                if(ret == 0)
                {
                    _value2.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value2.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                
                width.main = main;
                width.up = up;
                width.down = down;
                
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 1000;
                max.up = 0;
                max.down = 0;
                
                ret = [self checkCompleteValue:_value3 min:min max:max];
                if(ret == 0)
                {
                    _value3.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value3.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                depth.main = main;
                depth.up = up;
                depth.down = down;
                
                double value1,value2,value3;
                value1 = (length.main * 16 + length.up)/16.0;
                value2 = (width.main * 16 + width.up)/16.0;
                value3 = (depth.main * 16 + depth.up)/16.0;
                double result = (value1 * value2 * value3)/(12 * 12 * 12);
                resultStr = [NSString stringWithFormat:@"%.03f",round(result * 1000)/1000.0];
                
                [dict setValue:_value1.text forKey:@"length"];
                [dict setValue:_value2.text forKey:@"width"];
                [dict setValue:_value3.text forKey:@"depth"];
                [dict setValue:resultStr forKey:@"result"];
                
                if(selectedIndex == -1)
                    [dataList addObject:dict];
                else
                    [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
            }
            else
            {
                
                Fraction *length = [[Fraction alloc] init];
                Fraction *width = [[Fraction alloc] init];
                Fraction *depth = [[Fraction alloc] init];
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 1000;
                max.up = 0;
                max.down = 0;
                
                int ret = [self checkCompleteValue:_value1 min:min max:max];
                if(ret == 0)
                {
                    _value1.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Length." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value1.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                length.main = main;
                length.up = up;
                length.down = down;
                
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 500;
                max.up = 0;
                max.down = 0;
                
                ret = [self checkCompleteValue:_value2 min:min max:max];
                if(ret == 0)
                {
                    _value2.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Depth." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value2.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                
                depth.main = main;
                depth.up = up;
                depth.down = down;
                
                min.main = 0;
                min.up = 0;
                min.down = 0;
                max.main = 100;
                max.up = 0;
                max.down = 0;
                
                ret = [self checkCompleteValue:_value3 min:min max:max];
                if(ret == 0)
                {
                    _value3.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Please input correct Width." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                if(ret == 1)
                {
                    _value3.text = @"";
                    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Data Range is incorrect." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
                    [view show];
                    return;
                }
                width.main = main;
                width.up = up;
                width.down = down;
                
                double value1,value2,value3;
                value1 = (length.main * 16 + length.up)/16.0;
                value2 = (width.main * 16 + width.up)/16.0;
                value3 = (depth.main * 16 + depth.up)/16.0;
                double result = (value1 * value2 * value3)/(12 * 12);
                resultStr = [NSString stringWithFormat:@"%.03f",round(result * 1000)/1000.0];
                
                [dict setValue:_value1.text forKey:@"length"];
                [dict setValue:_value2.text forKey:@"depth"];
                [dict setValue:_value3.text forKey:@"width"];
                [dict setValue:resultStr forKey:@"result"];
                
                if(selectedIndex == -1)
                    [dataList addObject:dict];
                else
                    [dataList replaceObjectAtIndex:selectedIndex withObject:dict];
                
            }
        }
    }
    [self showTable];
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@""
                                                                        message:@"SAVED!"
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                          style:UIAlertActionStyleDestructive
                                                        handler:^(UIAlertAction *action) {
                                                            //NSLog(@"Dismiss button tapped!");
                                                           
                                                        }];
    
    [controller addAction:alertAction];
    [self presentViewController:controller animated:YES completion:nil];
}
-(void)showTable
{
    [_tableList reloadData];
    double totaldepth = 0,totalconcrete = 0;
    double value = 0,totaldepth1;
    Fraction *depthfraction = [[Fraction alloc] init];
    Fraction *min = [[Fraction alloc] init];
    Fraction *max = [[Fraction alloc] init];
    
    
        if(method == 0)
        {
            if(type == 0)
            {
                for(int i = 0; i < dataList.count;i++)
                {
                    NSMutableDictionary  *dic = [dataList objectAtIndex:i];
                    totalconcrete += [[dic objectForKey:@"result"] doubleValue];
                    totaldepth += [[dic objectForKey:@"depth"] doubleValue];
                }
                _result1.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete *1000)/1000.0];
                _result2.text = [NSString stringWithFormat:@"%.03f",round(totaldepth *1000)/1000.0];
                
            }
            else
            {
                
                for(int i = 0; i < dataList.count;i++)
                {
                    NSMutableDictionary  *dic = [dataList objectAtIndex:i];
                    totalconcrete += [[dic objectForKey:@"result"] doubleValue];
                    totaldepth += [[dic objectForKey:@"length"] doubleValue];
                }
                _result1.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete *1000)/1000.0];
                _result2.text = [NSString stringWithFormat:@"%.03f",round(totaldepth *1000)/1000.0];
            }
        }
        else
        {
            if(type == 0)
            {
                for(int i = 0; i < dataList.count;i++)
                {
                    min.main = 0;
                    min.up = 0;
                    min.down = 0;
                    max.main = 188;
                    max.up = 0;
                    max.down = 0;
                    NSMutableDictionary  *dic = [dataList objectAtIndex:i];
                    [self checkCompleteValue1:[dic objectForKey:@"depth"] min:min max:max];
                    depthfraction.main = main;
                    depthfraction.up = up;
                    depthfraction.down = down;
                    double value1 = (depthfraction.main * 16 + depthfraction.up)/16.0;
                    totaldepth1 += value1;
                    totalconcrete += [[dic objectForKey:@"result"] doubleValue];
                }
                main = (int)totaldepth1;
                up = round((totaldepth1- main) * 16);
                _result2.text = [self display:main u:up d:down];
                _result1.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete * 1000)/1000.0];
            }
            else
            {
                for(int i = 0; i < dataList.count;i++)
                {
                    min.main = 0;
                    min.up = 0;
                    min.down = 0;
                    max.main = 5000;
                    max.up = 0;
                    max.down = 0;
                    NSMutableDictionary  *dic = [dataList objectAtIndex:i];
                    [self checkCompleteValue1:[dic objectForKey:@"length"] min:min max:max];
                    depthfraction.main = main;
                    depthfraction.up = up;
                    depthfraction.down = down;
                    double value1 = (depthfraction.main * 16 + depthfraction.up)/16.0;
                    totaldepth1 += value1;
                    totalconcrete += [[dic objectForKey:@"result"] doubleValue];
                }
                main = (int)totaldepth1;
                up = round((totaldepth1- main) * 16);
                _result2.text = [self display:main u:up d:down];
                _result1.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete * 1000)/1000.0];
            }
        }
    
}

- (IBAction)saveDatas:(id)sender {
    if(dataList.count == 0)
        return;
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Would you like to save calculator answers?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil];
    view.tag = 1;
    [view show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(alertView.tag == 1 && buttonIndex == 0)
    {
        /*
         UIAlertView *commentView = [[UIAlertView alloc] initWithTitle:@"Please enter job name." message:@"\n" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
         
         comment1 = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 24.0)];
         comment1.autocorrectionType = UITextAutocorrectionTypeNo;
         comment1.keyboardType = UIKeyboardTypeDefault;
         comment1.returnKeyType = UIReturnKeyDone;
         comment1.clearButtonMode = UITextFieldViewModeWhileEditing;
         
         
         UIFont* font = [UIFont fontWithName:@"Helvetica-Bold" size:15.0f];
         [comment1 setFont:font];
         [comment1 setBackgroundColor:[UIColor whiteColor]];
         comment1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
         [comment1 becomeFirstResponder];
         comment1.delegate = self;
         [commentView addSubview:comment1];
         commentView.tag = 2;
         [commentView show];
         [commentView release];
         return;
         */
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter job name." preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                          {
                              comment1 = alert.textFields.firstObject;
                              //NSString *temp = comment1.text;
                              [self savepreferences];
                          }]];
        [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
            textField.placeholder = @"Enter Name:";
            textField.secureTextEntry = NO;
        }];
        [self presentViewController:alert animated:YES completion:nil];
        //[self savepreferences];
    }
}
-(void)savepreferences
{
    //save data
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    /*
     insert or update
     */
    //CREATE TABLE jobstable(id integer primary key autoincrement,date TEXT,name TEXT,address TEXT,phone TEXT,email TEXT,quote TEXT,method TEXT,option TEXT,value TEXT,height TEXT,width TEXT,length TEXT,margin TEXT,tax TEXT,title TEXT)
    sqlite3_stmt *insertStatement;
    
    char *insertSql = "INSERT INTO jobs(title,date,name,address,phone,email,margin,tax,quote,method,type) VALUES(?,?,?,?,?,?,?,?,?,?,?)";
    
    //int ret = sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL);
    if (sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        
        //sqlite3_bind_int(insertStatement, 1, 1);
        
        NSString *str = comment1.text;
        NSLog(@"%@",str);
        sqlite3_bind_text(insertStatement, 1, [str UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 2, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 3, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 4, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 5, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 6, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 7, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 8, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(insertStatement, 9, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_text(insertStatement, 10, [[NSString stringWithFormat:@"%d",method] UTF8String],  -1, SQLITE_TRANSIENT);
        
        sqlite3_bind_text(insertStatement, 11, [[NSString stringWithFormat:@"%d",type] UTF8String],  -1, SQLITE_TRANSIENT);
        // sql
        if (sqlite3_step(insertStatement) != SQLITE_DONE) {
            NSLog(@"Error");
            
        }
        sqlite3_finalize(insertStatement);
        
        
    }
    NSLog(@"FAILED TO INSERT THE RECORD : %@",[NSString stringWithCString:sqlite3_errmsg(delegate.db) encoding:NSStringEncodingConversionAllowLossy]);
    
    char *selectSql = "SELECT * FROM jobs WHERE id=(SELECT max(id) FROM jobs)";
    int no = 0;
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &insertStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(insertStatement)==SQLITE_ROW) {
            no = sqlite3_column_int(insertStatement, 0);
        }
    }
    sqlite3_finalize(insertStatement);
    insertSql = "INSERT INTO jobstable(jobid,length,width,depth,result) VALUES(?,?,?,?,?)";
    if(type == 0)
    {
        for(int i = 0; i < dataList.count; i++)
        {
            NSMutableDictionary  *dic = [dataList objectAtIndex:i];
            if (sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
                sqlite3_bind_int(insertStatement, 1, no);
                sqlite3_bind_text(insertStatement, 2, [[dic objectForKey:@"diameter"] UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 3, [@"" UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 4, [[dic objectForKey:@"depth"] UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 5, [[dic objectForKey:@"result"] UTF8String],  -1, SQLITE_TRANSIENT);
                if (sqlite3_step(insertStatement) != SQLITE_DONE) {
                    NSLog(@"Error");
                    
                }
                sqlite3_finalize(insertStatement);
            }
            
        }
    }
    else
    {
        for(int i = 0; i < dataList.count; i++)
        {
            NSMutableDictionary  *dic = [dataList objectAtIndex:i];
            if (sqlite3_prepare_v2(delegate.db, insertSql, -1, &insertStatement, NULL) == SQLITE_OK) {
                sqlite3_bind_int(insertStatement, 1, no);
                sqlite3_bind_text(insertStatement, 2, [[dic objectForKey:@"length"] UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 3, [[dic objectForKey:@"width"] UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 4, [[dic objectForKey:@"depth"] UTF8String],  -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(insertStatement, 5, [[dic objectForKey:@"result"] UTF8String],  -1, SQLITE_TRANSIENT);
                if (sqlite3_step(insertStatement) != SQLITE_DONE) {
                    NSLog(@"Error");
                    
                }
                sqlite3_finalize(insertStatement);
            }
            
        }
    }
    
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
    
    NSLog(@"FAILED TO INSERT THE RECORD : %@",[NSString stringWithCString:sqlite3_errmsg(delegate.db) encoding:NSStringEncodingConversionAllowLossy]);
    
    //[self.navigationController popViewControllerAnimated:YES];

}

- (IBAction)textend:(id)sender {
}
- (IBAction)footingcalculate:(id)sender {
    
    selectedIndex = -1;
    [self tableRefresh];   
    
}

- (IBAction)deleteEntry:(id)sender {
    if(selectedIndex == -1)
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                            message:@"Please Select - ENTRY"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *action) {
                                                                //NSLog(@"Dismiss button tapped!");
                                                            }];
        
        [controller addAction:alertAction];
        [self presentViewController:controller animated:YES completion:nil];
        
        return;
    }
    [dataList removeObjectAtIndex:selectedIndex];
    [self showTable];
    _value1.text = @"";
    _value2.text = @"";
    _value3.text = @"";
    selectedIndex = -1;
}

- (IBAction)editEntry:(id)sender {
    if( selectedIndex == -1)
    {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Select"
                                                                            message:@"Please Select - ENTRY"
                                                                     preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Ok"
                                                              style:UIAlertActionStyleDestructive
                                                            handler:^(UIAlertAction *action) {
                                                                //NSLog(@"Dismiss button tapped!");
                                                            }];
        
        [controller addAction:alertAction];
        [self presentViewController:controller animated:YES completion:nil];
        return;
    }
    [self tableRefresh];
    selectedIndex = -1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"datalistcell";
    
    DataListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[DataListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSMutableDictionary  *dic = [dataList objectAtIndex:indexPath.row];
    if(type == 0)
    {
        
        cell.dataresult.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
        cell.dataresult1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"diameter"]];
        cell.dataresult2.text = @"";
        cell.dataresult3.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"depth"]];
        cell.dataresult4.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
        
    }else
    {
        if(type == 1)
        {
            
            
            
            cell.dataresult.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
            cell.dataresult1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"length"]];
            cell.dataresult2.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"width"]];
            cell.dataresult3.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"depth"]];
            cell.dataresult4.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
        }
        else
        {
            cell.dataresult.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
            cell.dataresult1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"length"]];
            cell.dataresult2.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"depth"]];
            cell.dataresult3.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"width"]];
            cell.dataresult4.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"result"]];
        }
    }
    return cell;
    
    
    
    return nil;
}

/*
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. The view for the header
    UIView* headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 22)];
    
    // 2. Set a custom background color and a border
    headerView.backgroundColor = [UIColor colorWithWhite:0.5f alpha:1.0f];
    headerView.layer.borderColor = [UIColor colorWithWhite:0.5 alpha:1.0].CGColor;
    headerView.layer.borderWidth = 1.0;
    
    // 3. Add a label
    UILabel* headerLabel = [[UILabel alloc] init];
    headerLabel.frame = CGRectMake(5, 2, tableView.frame.size.width - 5, 18);
    headerLabel.backgroundColor = [UIColor clearColor];
    headerLabel.textColor = [UIColor whiteColor];
    headerLabel.font = [UIFont boldSystemFontOfSize:16.0];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] intValue] == 0)
    {
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            //metric
            headerLabel.text = [NSString stringWithFormat:@"No.          Dia                           Depth                   M%@",temp];
            
        }
        else
        {
             if([[prefs stringForKey:@"type"] intValue] == 1)
             {
                 headerLabel.text = [NSString stringWithFormat:@"No.            (L)         (W)           (D)             %@",@"Total"];
             }
             else{
                 headerLabel.text = [NSString stringWithFormat:@"No.            (W)         (D)           (L)             %@",@"Total"];
             }
        }
    }
    else
    {
        //imperial
        if([prefs stringForKey:@"type"] == nil || [[prefs stringForKey:@"type"] intValue] == 0)
        {
            //pier
            headerLabel.text = [NSString stringWithFormat:@"No.          Dia                            Depth                   FT%@",temp];//@"No.            Dia             (D)         FT%@",temp];
        }
        else
        {
            if([[prefs stringForKey:@"type"] intValue] == 1)
            {
                headerLabel.text = [NSString stringWithFormat:@"No.             (L)            (W)            (D)            %@",@"Total"];
            }
            else{
                headerLabel.text = [NSString stringWithFormat:@"No.             (W)            (D)            (L)           %@",@"Total"];
            }
        }
        
    }
    headerLabel.textAlignment = NSTextAlignmentLeft;
    
    // 4. Add the label to the header view
    [headerView addSubview:headerLabel];
    
    // 5. Finally return
    return headerView;
}
*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int)indexPath.row;
    NSMutableDictionary  *dict = [[NSMutableDictionary  alloc]init];
    dict = [dataList objectAtIndex:selectedIndex];
    
    if(type == 0)
    {
        _value1.text = [dict objectForKey:@"diameter"];
        _value2.text = [dict objectForKey:@"depth"];
    }
    else{
        if(type == 1)
        {
            _value1.text = [dict objectForKey:@"length"];
            _value2.text = [dict objectForKey:@"width"];
            _value3.text = [dict objectForKey:@"depth"];
        }
        else{
            _value1.text = [dict objectForKey:@"length"];
            _value2.text = [dict objectForKey:@"depth"];
            _value3.text = [dict objectForKey:@"width"];
        }
    }
    
}

@end
