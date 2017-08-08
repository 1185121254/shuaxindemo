//
//  NextViewController.h
//  shuaxindemo
//
//  Created by chaojie on 2017/7/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NextViewControllerDelegate <NSObject>

-(void)changeData:(NSMutableArray *)dataArray;

@end

@interface NextViewController : UIViewController

@property(nonatomic,weak)id<NextViewControllerDelegate> datagate;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(nonatomic,copy) void (^block)(NSString *str);

@end
