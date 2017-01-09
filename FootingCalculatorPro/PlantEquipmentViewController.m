//
//  PlantEquipmentViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "PlantEquipmentViewController.h"

@interface PlantEquipmentViewController ()

@end

@implementation PlantEquipmentViewController

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

-(void)getpreferences
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    
    if ([prefs stringForKey:@"plant1"] == nil)
        _plant1.text = [self valueSetring:@"50" max:@"1000"];
    else
        _plant1.text = [self valueSetring:[prefs stringForKey:@"plant1"] max:@"1000"];
    
    if ([prefs stringForKey:@"plant2"] == nil)
        _plant2.text = [self valueSetring:@"0" max:@"1000"];
    else
        _plant2.text = [self valueSetring:[prefs stringForKey:@"plant2"] max:@"1000"];
    
    if ([prefs stringForKey:@"plant3"] == nil)
        _plant3.text = [self valueSetring:@"0" max:@"1000"];
    else
        _plant3.text = [self valueSetring:[prefs stringForKey:@"plant3"] max:@"1000"];
    
    if ([prefs stringForKey:@"plant4"] == nil)
        _plant4.text = [self valueSetring:@"0" max:@"1000"];
    else
        _plant4.text = [self valueSetring:[prefs stringForKey:@"plant4"] max:@"1000"];
    
    if ([prefs stringForKey:@"plantlabellabel1"] == nil)
        _plantlabel1.text = @"Plant";
    else
        _plantlabel1.text = [prefs stringForKey:@"plantlabel1"];
    
    if ([prefs stringForKey:@"plantlabel2"] == nil)
        _plantlabel2.text = @"Other";
    else
        _plantlabel2.text = [prefs stringForKey:@"plantlabel2"];
    
    if ([prefs stringForKey:@"plantlabel3"] == nil)
        _plantlabel3.text = @"Other";
    else
        _plantlabel3.text = [prefs stringForKey:@"plantlabel3"];
    
    if ([prefs stringForKey:@"plantlabel3"] == nil)
        _plantlabel4.text = @"Other";
    else
        _plantlabel4.text = [prefs stringForKey:@"plantlabel4"];
    
    if ([prefs stringForKey:@"equip1"] == nil)
        _equip1.text = [self valueSetring:@"50" max:@"1000"];
    else
        _equip1.text = [self valueSetring:[prefs stringForKey:@"equip1"] max:@"1000"];
    if ([prefs stringForKey:@"equip2"] == nil)
        _equip2.text = [self valueSetring:@"0" max:@"1000"];
    else
        _equip2.text = [self valueSetring:[prefs stringForKey:@"equip2"] max:@"1000"];
    if ([prefs stringForKey:@"equip3"] == nil)
        _equip3.text = [self valueSetring:@"0" max:@"1000"];
    else
        _equip3.text = [self valueSetring:[prefs stringForKey:@"equip3"] max:@"1000"];
    if ([prefs stringForKey:@"equip4"] == nil)
        _equip4.text = [self valueSetring:@"0" max:@"1000"];
    else
        _equip4.text = [self valueSetring:[prefs stringForKey:@"equip4"] max:@"1000"];
    
    if ([prefs stringForKey:@"equiplabel1"] == nil)
        _equipmentlabel1.text = @"Equipment";
    else
        _equipmentlabel1.text = [prefs stringForKey:@"equiplabel2"];
    
    if ([prefs stringForKey:@"equiplabel2"] == nil)
        _equipmentlabel2.text = @"Other";
    else
        _equipmentlabel2.text = [prefs stringForKey:@"equiplabel2"];
    
    if ([prefs stringForKey:@"equiplabel3"] == nil)
        _equipmentlabel3.text = @"Other";
    else
        _equipmentlabel3.text = [prefs stringForKey:@"equiplabel3"];
    
    if ([prefs stringForKey:@"equiplabel4"] == nil)
        _equipmentlabel4.text = @"Other";
    else
        _equipmentlabel4.text = [prefs stringForKey:@"equiplabel4"];
    
    
}
-(NSString *)valueSetring:(NSString *)value max:(NSString *)max
{
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

- (IBAction)savePreferences:(id)sender {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:_plant1.text forKey:@"plant1"];
    [prefs setObject:_plant2.text forKey:@"plant2"];
    [prefs setObject:_plant3.text forKey:@"plant3"];
    [prefs setObject:_plant4.text forKey:@"plant4"];
    
    [prefs setObject:_equip1.text forKey:@"equip1"];
    [prefs setObject:_equip2.text forKey:@"equip2"];
    [prefs setObject:_equip3.text forKey:@"equip3"];
    [prefs setObject:_equip4.text forKey:@"equip4"];
    
    [prefs setObject:_plantlabel1.text forKey:@"plantlabel1"];
    [prefs setObject:_plantlabel1.text forKey:@"plantlabel2"];
    [prefs setObject:_plantlabel1.text forKey:@"plantlabel3"];
    [prefs setObject:_plantlabel1.text forKey:@"plantlabel4"];
    
    [prefs setObject:_equipmentlabel1.text forKey:@"equiplabel1"];
    [prefs setObject:_equipmentlabel2.text forKey:@"equiplabel2"];
    [prefs setObject:_equipmentlabel3.text forKey:@"equiplabel3"];
    [prefs setObject:_equipmentlabel4.text forKey:@"equiplabel4"];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    [view show];
}

- (IBAction)textend:(id)sender {
}

@end
