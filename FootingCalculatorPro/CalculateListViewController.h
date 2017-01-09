//
//  CalculateListViewController.h
//  FootingCalculator
//
//  Created by lcs on 12/12/16.
//  Copyright © 2016 lcs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculateListViewController : UITableViewController
{
    NSMutableArray *listdata;
    int selectedid;
}
-(void)getDataList;
@end
