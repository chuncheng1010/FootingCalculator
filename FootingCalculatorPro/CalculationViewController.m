//
//  CalculationViewController.m
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import "CalculationViewController.h"
#import "AppDelegate.h"
#import "DataListTableViewCell1.h"

#import "RegexKitLite.h"

@interface CalculationViewController ()

@end

@implementation CalculationViewController

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
    
    
    selectSql = [[NSString stringWithFormat:@"SELECT date,name,address,phone,email,method,type FROM jobs WHERE id=%d",index] UTF8String];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        while (sqlite3_step(selectStatement)==SQLITE_ROW) {
            _date.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 0)];
            _name.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 1)];
            _address.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 2)];
            _phone.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 3)];
            _email.text = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 4)];
            method = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 5)] intValue];
            type = [[NSString stringWithUTF8String:(char *)sqlite3_column_text(selectStatement, 6)] intValue];
        }
        
    }
    else
        return;
    sqlite3_finalize(selectStatement);
    
    const unichar ch = 0x00b3;
    NSString *temp = [NSString stringWithCharacters: &ch length:1];
    if(method == 0)
    {
        
            _concreteunit.text = [NSString stringWithFormat:@"M%@",temp];
            _lengthunit.text = @"METRES";
        if(type == 0)
            _titlelabel.text = @"Concrete Piers - Metric";
        if(type == 1)
            _titlelabel.text = @"Concrete Pads - Metric";
        if(type == 2)
            _titlelabel.text = @"Concrete Footings - Metric";
        
    }
    else{
        _concreteunit.text = [NSString stringWithFormat:@"FT%@",temp];
        _lengthunit.text = @"FEET";
        if(type == 0)
            _titlelabel.text = @"Concrete Piers - Imperial";
        if(type == 1)
            _titlelabel.text = @"Concrete Pads - Imperial";
        if(type == 2)
            _titlelabel.text = @"Concrete Footings - Imperial";
            
    }
    
    
        if(type == 0)
        {
            if(method == 0)
            {
            _header1.text = @"No.";
            _header2.text = @"Dia";
            _header3.text = @"   ";
            _header4.text = @"Depth";
            _header5.text = [NSString stringWithFormat:@"M%@",temp];
            }
            if(method == 1)
            {
                _header1.text = @"No.";
                _header2.text = @"Dia";
                _header3.text = @"   ";
                _header4.text = @"Depth";
                _header5.text = [NSString stringWithFormat:@"FT%@",temp];
            }
        }
    
    if(type == 1)
    {
        _header1.text = @"No.";
        _header2.text = @"(L)";
        _header3.text = @"(W)";
        _header4.text = @"(D)";
        if(method == 0)
            _header5.text = [NSString stringWithFormat:@"M%@",temp];
        else
            _header5.text = [NSString stringWithFormat:@"FT%@",temp];
    }
    if(type == 2)
    {
        _header1.text = @"No.";
        _header2.text = @"(W)";
        _header3.text = @"(D)";
        _header4.text = @"(L)";
        if(method == 0)
            _header5.text = [NSString stringWithFormat:@"M%@",temp];
        else
            _header5.text = [NSString stringWithFormat:@"FT%@",temp];
    }
    
    
    
    [self showTable];
}
-(void)calculateValue
{
    double valueconcrete = 0,valuelength = 0;
    if(method == 0)
    {
        if(type == 0)
        {
            
            for(int i = 0; i < dataList.count; i++)
            {
                NSMutableDictionary *dic = [dataList objectAtIndex:i];
                valuelength += [[dic objectForKey:@"depth"] doubleValue];
                valueconcrete += [[dic objectForKey:@"result"] doubleValue];
                
            }
        }
        else{
            for(int i = 0; i < dataList.count; i++)
            {
                NSMutableDictionary *dic = [dataList objectAtIndex:i];
                valuelength += [[dic objectForKey:@"length"] doubleValue];
                valueconcrete += [[dic objectForKey:@"result"] doubleValue];
                
            }
        }
    }
    else{
        if(type == 0)
        {
            for(int i = 0; i < dataList.count; i++)
            {
                NSMutableDictionary *dic = [dataList objectAtIndex:i];
                valuelength += [[dic objectForKey:@"length"] doubleValue];
                valueconcrete += [[dic objectForKey:@"result"] doubleValue];
                
            }
            
        }
        else{
            for(int i = 0; i < dataList.count; i++)
            {
                NSMutableDictionary *dic = [dataList objectAtIndex:i];
                valuelength += [[dic objectForKey:@"length"] doubleValue];
                valueconcrete += [[dic objectForKey:@"result"] doubleValue];
                
            }
        }
    }
    _totalconcrete.text = [NSString stringWithFormat:@"%.03f",round(valueconcrete * 1000)/1000.0];
    _totallength.text = [NSString stringWithFormat:@"%.03f",round(valuelength * 10000)/1000.0];
}



- (IBAction)textend:(id)sender {
}

- (IBAction)mailSend:(id)sender {
    if([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        picker.mailComposeDelegate = self;
        
        
        [picker setSubject:@""];
        
        [picker setToRecipients:[NSArray arrayWithObjects:_email.text,nil]];
        
        NSString *content = [NSString stringWithFormat:@"Date: %@\n",_date.text];
        content = [content stringByAppendingFormat:@"Name: %@\n",_name.text];
        content = [content stringByAppendingFormat:@"Address: %@\n",_address.text];
        content = [content stringByAppendingFormat:@"Phone: %@\n",_phone.text];
        content = [content stringByAppendingFormat:@"Email: %@\n",_email.text];
        
        content = [content stringByAppendingFormat:@"Total concrete: %@ %@\n",_totalconcrete.text,_concreteunit.text];
        content = [content stringByAppendingFormat:@"Total Length: %@ %@\n",_totallength.text,_lengthunit.text];
        
        
        
        
        
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *simpleTableIdentifier = @"datalistcell";
    
    DataListTableViewCell1 *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[DataListTableViewCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSMutableDictionary  *dic = [dataList objectAtIndex:indexPath.row];
    if(type == 0)
    {
        
        cell.dataresult.text = [NSString stringWithFormat:@"%d",(int)indexPath.row + 1];
        cell.dataresult1.text = [NSString stringWithFormat:@"%@",[dic objectForKey:@"length"]];
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
    if(method == 0)
    {
        if(type == 0)
        {
            //metric
            headerLabel.text = [NSString stringWithFormat:@"No.          Dia                           Depth                   M%@",temp];
            
        }
        else
        {
            if(type == 1)
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
        if(type == 0)
        {
            //pier
            headerLabel.text = [NSString stringWithFormat:@"No.          Dia                           Depth                   FT%@",temp];
        }
        else
        {
            if(type == 1)
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
            _totalconcrete.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete *1000)/1000.0];
            _totallength.text = [NSString stringWithFormat:@"%.03f",round(totaldepth *1000)/1000.0];
            
        }
        else
        {
            
            for(int i = 0; i < dataList.count;i++)
            {
                NSMutableDictionary  *dic = [dataList objectAtIndex:i];
                totalconcrete += [[dic objectForKey:@"result"] doubleValue];
                totaldepth += [[dic objectForKey:@"length"] doubleValue];
            }
            _totalconcrete.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete *1000)/1000.0];
            _totallength.text = [NSString stringWithFormat:@"%.03f",round(totaldepth *1000)/1000.0];
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
            _totallength.text = [self display:main u:up d:down];
            _totalconcrete.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete * 1000)/1000.0];
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
            _totallength.text = [self display:main u:up d:down];
            _totalconcrete.text = [NSString stringWithFormat:@"%.03f",round(totalconcrete * 1000)/1000.0];
        }
    }
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)textend1:(id)sender {
}

- (IBAction)saveData:(id)sender {
    sqlite3_stmt *selectStatement;
    char *selectSql = "update jobs set date=?,name=?,phone=?,address=?,email=? where id=?";
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    if (sqlite3_prepare_v2(delegate.db, selectSql, -1, &selectStatement, NULL) == SQLITE_OK) {
        sqlite3_bind_text(selectStatement, 1, [_date.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 2, [_name.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 3, [_phone.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 4, [_address.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_text(selectStatement, 5, [_email.text UTF8String], -1, SQLITE_TRANSIENT);
        sqlite3_bind_int(selectStatement, 6, index);
        int success = sqlite3_step(selectStatement);
        sqlite3_reset(selectStatement);
        
        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"" message:@"Successfully saved." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [view show];
        
        
    }
    sqlite3_finalize(selectStatement);
}
@end
