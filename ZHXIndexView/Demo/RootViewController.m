//
//  RootViewController.m
//  ZHXIndexView
//
//  Created by 张玺 on 2020/4/6.
//  Copyright © 2020 张玺. All rights reserved.
//

#import "RootViewController.h"
#import "CollectionViewController.h"
#import "TableViewController.h"
@interface RootViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView  * _tableView;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"ZHXIndexView Demo";
    _tableView = [[UITableView  alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame)
                                                               , CGRectGetHeight(self.view.frame)) style:UITableViewStylePlain];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    [self.view  addSubview:_tableView];
}



#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString *  CellIdentifier = @"CellIdentifier";
    UITableViewCell  * cell = [tableView  dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell  alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"IndexView of UICollectionView";
            return cell;
            break;
        case 1:
            cell.textLabel.text = @"IndexView of UITableView";
            return cell;
            break;
        default:
            break;
    }
    
    cell.textLabel.text = @"";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            CollectionViewController * vc = [[CollectionViewController  alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 1:
        {
            TableViewController * vc = [[TableViewController  alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
    
        default:
            break;
    }
}

@end
