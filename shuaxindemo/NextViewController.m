//
//  NextViewController.m
//  shuaxindemo
//
//  Created by chaojie on 2017/7/6.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()<UITableViewDelegate,UITableViewDataSource>


@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
//    _dataArray = [[NSMutableArray alloc] initWithObjects:@"two",@"two",@"three",@"four",@"five", nil];
    
//    _dataArray = [[NSMutableArray alloc] init];
    
    NSLog(@"_dataArray:%@",_dataArray);
    
    [_tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    
    NSDictionary *dict = @{@"colojr":@"123", @"userName":@"haha"};
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgColor" object:nil userInfo:dict];

   
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = _dataArray[indexPath.row];
    
    cell.textLabel.font = [UIFont systemFontOfSize:18];
    
    return cell;
    
    
}
- (IBAction)btnClcik:(id)sender {
    
//    if ([_datagate respondsToSelector:@selector(changeData:)]) {
//        [_datagate changeData:_dataArray];
//    }
   
    if (self.block != nil) {
        
        self.block(@"huanghunyi");

    }
   
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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

@end
