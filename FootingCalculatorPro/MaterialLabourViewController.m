//
//  MaterialLabourViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "MaterialLabourViewController.h"

@interface MaterialLabourViewController ()

@end

@implementation MaterialLabourViewController

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
    [self getpreferences];
    
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

- (void) getpreferences {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([prefs stringForKey:@"concrete20"] == nil)
        _concrete1.text = [self valueSetring:@"150" max:@"100000"];
    else
        _concrete1.text = [self valueSetring:[prefs stringForKey:@"concrete20"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete25"] == nil)
        _concrete2.text = [self valueSetring:@"160" max:@"100000"];
    else
        _concrete2.text = [self valueSetring:[prefs stringForKey:@"concrete25"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete32"] == nil)
        _concrete3.text = [self valueSetring:@"170" max:@"100000"];
    else
        _concrete3.text = [self valueSetring:[prefs stringForKey:@"concrete32"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete40"] == nil)
        _concrete4.text = [self valueSetring:@"180" max:@"100000"];
    else
        _concrete4.text = [self valueSetring:[prefs stringForKey:@"concrete40"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete50"] == nil)
        _concrete5.text = [self valueSetring:@"190" max:@"100000"];
    else
        _concrete5.text = [self valueSetring:[prefs stringForKey:@"concrete50"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete60"] == nil)
        _concrete6.text = [self valueSetring:@"200" max:@"100000"];
    else
        _concrete6.text = [self valueSetring:[prefs stringForKey:@"concrete60"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete65"] == nil)
        _concrete7.text = [self valueSetring:@"220" max:@"100000"];
    else
        _concrete7.text = [self valueSetring:[prefs stringForKey:@"concrete65"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete80"] == nil)
        _concrete8.text = [self valueSetring:@"240" max:@"100000"];
    else
        _concrete8.text = [self valueSetring:[prefs stringForKey:@"concrete80"] max:@"100000"];
    
    if ([prefs stringForKey:@"concrete100"] == nil)
        _concrete9.text = [self valueSetring:@"260" max:@"100000"];
    else
        _concrete9.text = [self valueSetring:[prefs stringForKey:@"concrete100"] max:@"100000"];
    
    
    if ([prefs stringForKey:@"conother1"] == nil)
        _conother1.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother1.text = [self valueSetring:[prefs stringForKey:@"conother1"] max:@"1000"];
    
    if ([prefs stringForKey:@"conother2"] == nil)
        _conother2.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother2.text = [self valueSetring:[prefs stringForKey:@"conother2"] max:@"1000"];
    
    if ([prefs stringForKey:@"conother3"] == nil)
        _conother3.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother3.text = [self valueSetring:[prefs stringForKey:@"conother3"] max:@"1000"];
    
    if ([prefs stringForKey:@"conother4"] == nil)
        _conother4.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother4.text = [self valueSetring:[prefs stringForKey:@"conother4"] max:@"1000"];
    
    if ([prefs stringForKey:@"conother5"] == nil)
        _conother5.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother5.text = [self valueSetring:[prefs stringForKey:@"conother5"] max:@"1000"];
    
    if ([prefs stringForKey:@"conother6"] == nil)
        _conother6.text = [self valueSetring:@"0" max:@"1000"];
    else
        _conother6.text = [self valueSetring:[prefs stringForKey:@"conother6"] max:@"1000"];
    
    
    if ([prefs stringForKey:@"labour1"] == nil)
        _labour1.text = [self valueSetring:@"20" max:@"100000"];
    else
        _labour1.text = [self valueSetring:[prefs stringForKey:@"labour1"] max:@"100000"];
    
    if ([prefs stringForKey:@"labour2"] == nil)
        _labour2.text = [self valueSetring:@"60" max:@"100000"];
    else
        _labour2.text = [self valueSetring:[prefs stringForKey:@"labour2"] max:@"100000"];
    
    if ([prefs stringForKey:@"labour3"] == nil)
        _labour3.text = [self valueSetring:@"60" max:@"100000"];
    else
        _labour3.text = [self valueSetring:[prefs stringForKey:@"labour3"] max:@"100000"];
    
    if ([prefs stringForKey:@"labour4"] == nil)
        _labour4.text = [self valueSetring:@"0" max:@"100000"];
    else
        _labour4.text = [self valueSetring:[prefs stringForKey:@"labour4"] max:@"100000"];
    
    if ([prefs stringForKey:@"conotherlabel1"] == nil)
        _conotherlabel1.text = @"Other";
    else
        _conotherlabel1.text = [prefs stringForKey:@"conotherlabel1"];
    
    if ([prefs stringForKey:@"conotherlabel2"] == nil)
        _conotherlabel2.text = @"Other";
    else
        _conotherlabel2.text = [prefs stringForKey:@"conotherlabel2"];
    
    if ([prefs stringForKey:@"conotherlabel3"] == nil)
        _conotherlabel3.text = @"Other";
    else
        _conotherlabel3.text = [prefs stringForKey:@"conotherlabel3"];
    
    if ([prefs stringForKey:@"conotherlabel4"] == nil)
        _conotherlabel4.text = @"Other";
    else
        _conotherlabel4.text = [prefs stringForKey:@"conotherlabel4"];
    
    if ([prefs stringForKey:@"conotherlabel5"] == nil)
        _conotherlabel5.text = @"Other";
    else
        _conotherlabel5.text = [prefs stringForKey:@"conotherlabel5"];
    
    if ([prefs stringForKey:@"conotherlabel6"] == nil)
        _conotherlabel6.text = @"Other";
    else
        _conotherlabel6.text = [prefs stringForKey:@"conotherlabel6"];
    
    if ([prefs stringForKey:@"labourlabel"] == nil)
        _labourlabel.text = @"Other";
    else
        _labourlabel.text = [prefs stringForKey:@"labourlabel"];
    
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    if([prefs stringForKey:@"method"] == nil || [[prefs stringForKey:@"method"] intValue] == 0)
    {
        _conunit1.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit2.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit3.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit4.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit5.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit6.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit7.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit8.text = [NSString stringWithFormat:@"m%@",temp];
        _conunit9.text = [NSString stringWithFormat:@"m%@",temp];
        
        _labourunit1.text = @"per l/m";
        _labourunit2.text = [NSString stringWithFormat:@"per m%@",temp];
        _labourunit4.text = [NSString stringWithFormat:@"per m%@",temp];
    }
    else{
        _conunit1.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit2.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit3.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit4.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit5.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit6.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit7.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit8.text = [NSString stringWithFormat:@"ft%@",temp];
        _conunit9.text = [NSString stringWithFormat:@"ft%@",temp];
        
        _labourunit1.text = @"per ft";
        _labourunit2.text = [NSString stringWithFormat:@"per ft%@",temp];
        _labourunit4.text = [NSString stringWithFormat:@"per ft%@",temp];
    }
    
}

- (NSString *)valueSetring:(NSString *)value max:(NSString *)max {
    
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
    NSString *str1 = [value stringByReplacingOccurrencesOfString:str withString:@""];
    
    float f1= [str1 floatValue];
    float f2 = [max floatValue];
    if(f1 == 0 || f1 > f2)
    {
        return [NSString stringWithFormat:@"%@%.02f",str,0.0];
    }
    else{
        return [NSString stringWithFormat:@"%@%.02f",str,f1];
    }
}

- (IBAction)saveMaterialCosts:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    [prefs setObject:_concrete1.text forKey:@"concrete20"];
    [prefs setObject:_concrete2.text forKey:@"concrete25"];
    [prefs setObject:_concrete3.text forKey:@"concrete32"];
    [prefs setObject:_concrete4.text forKey:@"concrete40"];
    [prefs setObject:_concrete5.text forKey:@"concrete50"];
    [prefs setObject:_concrete6.text forKey:@"concrete60"];
    [prefs setObject:_concrete7.text forKey:@"concrete65"];
    [prefs setObject:_concrete8.text forKey:@"concrete80"];
    [prefs setObject:_concrete9.text forKey:@"concrete100"];
    
    [prefs setObject:_conother1.text forKey:@"conother1"];
    [prefs setObject:_conother2.text forKey:@"conother2"];
    [prefs setObject:_conother3.text forKey:@"conother3"];
    [prefs setObject:_conother4.text forKey:@"conother4"];
    [prefs setObject:_conother5.text forKey:@"conother5"];
    [prefs setObject:_conother6.text forKey:@"conother6"];
    
    [prefs setObject:_conotherlabel1.text forKey:@"conotherlabel1"];
    [prefs setObject:_conotherlabel2.text forKey:@"conotherlabel2"];
    [prefs setObject:_conotherlabel3.text forKey:@"conotherlabel3"];
    [prefs setObject:_conotherlabel4.text forKey:@"conotherlabel4"];
    [prefs setObject:_conotherlabel5.text forKey:@"conotherlabel5"];
    [prefs setObject:_conotherlabel6.text forKey:@"conotherlabel6"];
    
    [prefs setObject:_labour1.text forKey:@"labour1"];
    [prefs setObject:_labour2.text forKey:@"labour2"];
    [prefs setObject:_labour3.text forKey:@"labour3"];
    
    
    [prefs setObject:_labour4.text forKey:@"labour4"];
    [prefs setObject:_labourlabel.text forKey:@"labourlabel"];
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
    
}

- (IBAction)textend:(id)sender {
}

@end
