//
//  MenuTableViewController.m
//  Eleven
//
//  Created by coderyi on 15/8/18.
//  Copyright (c) 2015年 coderyi. All rights reserved.
//

#import "MenuTableViewController.h"
#import "REFrostedViewController.h"

#import "BaseNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "LocalFileViewController.h"
#import "NetworkViewController.h"
#import "MoreViewController.h"

#import "PageViewController.h"
#import "HLService.h"

@interface MenuTableViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation MenuTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 84.0f)];
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
//        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
//        imageView.image = [UIImage imageNamed:@"Eleven"];
//        imageView.layer.masksToBounds = YES;
//        imageView.layer.cornerRadius = 50.0;
//        imageView.layer.borderColor = [UIColor whiteColor].CGColor;
//        imageView.layer.borderWidth = 3.0f;
//        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
//        imageView.layer.shouldRasterize = YES;
//        imageView.clipsToBounds = YES;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 0, 24)];
        label.text = NSLocalizedString(@"Menu", nil);
        label.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
        label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
//        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
    [self setExtraCellLineHidden];
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0)
//        return nil;
//    
//    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
//    view.backgroundColor = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
//    label.text = @"Friends Online";
//    label.font = [UIFont systemFontOfSize:15];
//    label.textColor = [UIColor whiteColor];
//    label.backgroundColor = [UIColor clearColor];
//    [label sizeToFit];
//    [view addSubview:label];
//    
//    return view;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    
    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    
    if (indexPath.section == 0 && indexPath.row == 2) {
        
        if ([[HLInterface sharedInstance] market_reviwed_status]==1) {
            PageViewController *homeViewController = [[PageViewController alloc] init];
            BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
            self.frostedViewController.contentViewController = navigationController;
        } else {
            MoreViewController *homeViewController = [[MoreViewController alloc] init];
            BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:homeViewController];
            self.frostedViewController.contentViewController = navigationController;
        }
        
        
        
        
        
    } else if (indexPath.section == 0 && indexPath.row == 1){
        
        
        NetworkViewController *secondViewController = [[NetworkViewController alloc] init];
        BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:secondViewController];
        self.frostedViewController.contentViewController = navigationController;
        
        
        
    }else if (indexPath.section == 0 && indexPath.row == 0){
        LocalFileViewController *secondViewController = [[LocalFileViewController alloc] init];
        BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:secondViewController];
        self.frostedViewController.contentViewController = navigationController;
    }
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        [[HLAdManager sharedInstance] showUnsafeInterstitial];
    }
    if (indexPath.section == 0 && indexPath.row == 4) {
        [[HLAdManager sharedInstance] showUnsafeInterstitial];
    }
    if (indexPath.section == 0 && indexPath.row == 5) {
        [[HLAdManager sharedInstance] showUnsafeInterstitial];
    }
    if (indexPath.section == 0 && indexPath.row == 6) {
        
        NSString* address=[HLAnalyst stringValue:@"ButtonAddress1"];
        if(address==nil){
            address=@"https://itunes.apple.com/cn/app/mei-mei-fang-jian-shi-shang/id1062516606?l=en&mt=8";
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
    }
    if (indexPath.section == 0 && indexPath.row == 7) {
        NSString* address=[HLAnalyst stringValue:@"ButtonAddress2"];
        if(address==nil){
            address=@"https://itunes.apple.com/cn/app/reckless-die-racing-earn-for/id1057853596?l=en&mt=8";
        }
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:address]];
    }
    if (indexPath.section == 0 && indexPath.row == 8) {
        [[HLAdManager sharedInstance] showUnsafeInterstitial];
    }
    
    
    
    [self.frostedViewController hideMenuViewController];
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    if ([[HLInterface sharedInstance] market_reviwed_status]==1) {
        return 9;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.section == 0) {
        
        if ([[HLInterface sharedInstance] market_reviwed_status]==1) {
            NSArray *titles = @[NSLocalizedString(@"Local Video", nil), NSLocalizedString(@"Network Video", nil),@"福利",@"女神私密",@"透视扫描仪",@"无删减视频",@"妹妹的房间",@"抢红包",@"bt种子"];
            cell.textLabel.text = titles[indexPath.row];
        } else {
            NSArray *titles = @[NSLocalizedString(@"Local Video", nil), NSLocalizedString(@"Network Video", nil)];
            cell.textLabel.text = titles[indexPath.row];
        }
    }
    
    return cell;
}
/**
 *  当tableview中 数据源数量很少不足以填满当前区域  比如只有1一个数据  那么它将隐藏 空cell的分割线
 */
- (void)setExtraCellLineHidden{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
//    [self.tableView setTableHeaderView:view];
    
}

@end
