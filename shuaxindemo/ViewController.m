//
//  ViewController.m
//  shuaxindemo
//
//  Created by chaojie on 2017/7/4.
//  Copyright © 2017年 chaojie. All rights reserved.
//

#import "ViewController.h"
#import "MJRefresh.h"
#import "TitleCollectionViewCell.h"
#import "NextViewController.h"

#define ItemSizeWidth 80
#define ItemSizeHeigth 35
#define NumberItems 5

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,NextViewControllerDelegate>
{
//    MJRefreshNormalHeader *_header;
    UIScrollView *_scrView;
    NSMutableArray *_addArray;

    NSMutableArray *_arrayData;

}

//横向滑动的collectionView
@property (nonatomic,strong)UICollectionView *collectionView;
//滑动的scroll
@property (nonatomic,strong)UIScrollView *scroll;
//当前的选中的index
@property (nonatomic)NSInteger indexPathRow;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.title = @"ceshi";
    
    
    UIBarButtonItem *rightBar = [[UIBarButtonItem alloc] initWithTitle:@"rightBar" style:UIBarButtonItemStylePlain target:self action:@selector(barButtonClick:)];
    
    self.navigationItem.rightBarButtonItem = rightBar;
    
    
    //设置tabbar
    self.tabBarController.tabBar.tintColor = [UIColor redColor];
    self.tabBarItem.title = @"test";
    
    self.tabBarItem.image = [[UIImage imageNamed:@"wd1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.selectedImage = [[UIImage imageNamed:@"wd"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //创建scroll
    [self createScrollView];
    //设置横向滑动的表格
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.itemSize = CGSizeMake(ItemSizeWidth, ItemSizeHeigth);
    layout.minimumInteritemSpacing = 5.0;
    layout.minimumLineSpacing = 5.0;
    layout.sectionInset = UIEdgeInsetsMake(0.0f, 20.0f, 0.0f, 20.0f);

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 65, [UIScreen mainScreen].bounds.size.width, ItemSizeHeigth + 10) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"TitleCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    self.collectionView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.collectionView];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgColor:) name:@"changeBgColor" object:nil];
    
}
-(void)barButtonClick:(UIBarButtonItem *)barButtonItem{
    
    NextViewController *nextVC = [[NextViewController alloc] init];
    
    [self.navigationController pushViewController:nextVC animated:YES];
    
}
-(void)changeBgColor:(NSNotification *)notifi{
    
    
    NSLog(@"+++++%@",notifi.userInfo);
    
    
    self.navigationItem.title = notifi.userInfo[@"userName"];
    
    self.navigationItem.rightBarButtonItem.title = notifi.userInfo[@"colojr"];
}
-(void)dealloc{
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"changeBgColor" object:nil];
}

-(void)changeData:(NSMutableArray *)dataArray{
    
    _addArray = dataArray;
    
    NSLog(@"dataArray:%@",dataArray);
    
    UITableView *tab = [self.view viewWithTag:4];
    
    [tab reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return NumberItems;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Titlelabel.text = @"精品推荐";
    if (self.indexPathRow == indexPath.row) {
        cell.Titlelabel.textColor = [UIColor redColor];
    }else{
        cell.Titlelabel.textColor = [UIColor blackColor];
    }
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",@(indexPath.row));
    self.indexPathRow = indexPath.row;
    [self.scroll setContentOffset:CGPointMake(indexPath.row * [UIScreen mainScreen].bounds.size.width, 0) animated:YES];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [collectionView reloadData];
}
- (void)createScrollView
{
    self.scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100.0 - 49.0)];
    self.scroll.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width*5, [UIScreen mainScreen].bounds.size.height - 100.0 - 49.0);
    self.scroll.pagingEnabled = YES;
    self.scroll.delegate = self;
    self.scroll.tag = 100;
    [self.view addSubview:self.scroll];
    
    
    _arrayData = [[NSMutableArray alloc] initWithObjects:@"one",@"two",@"three",@"four",@"five", nil];
    
    _addArray = [[NSMutableArray alloc] initWithObjects:@"DAMING",@"XIOAGANG",@"BEN",@"XIAOMING",@"SAM", nil];

    _addArray = [[NSMutableArray alloc] init];
    
    for (int i=0; i<5; i++) {
        UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width*i, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100.0 - 49.0)];
        table.delegate = self;
        table.dataSource = self;
        table.tag = i;
        [table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tablecell"];
        [self.scroll addSubview:table];
        
       MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullNewData:)];
        [header  setTitle:@"The drop-down refresh" forState:MJRefreshStateIdle];
        [header setTitle:@"loadDataComing" forState:MJRefreshStatePulling];
        [header setTitle:@"The server is running" forState:MJRefreshStateRefreshing];
        
        header.stateLabel.font = [UIFont systemFontOfSize:18];
        header.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:20];
        
        header.stateLabel.textColor = [UIColor redColor];
        header.lastUpdatedTimeLabel.textColor = [UIColor grayColor];
        header.tag = table.tag + 100;

        table.mj_header = header;
        
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 0) {
        return _arrayData.count;
    }else if (tableView.tag == 1){
        return _arrayData.count;
    }else if (tableView.tag == 2){
        return _arrayData.count;
    }else if (tableView.tag == 3){
        return _arrayData.count;
    }else if (tableView.tag == 4){
        return _addArray.count;
    }else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tablecell" forIndexPath:indexPath];
    
    if (tableView.tag == 0) {
//        cell.textLabel.text = @"test001";
        cell.textLabel.text = _arrayData[indexPath.row];
    }else if (tableView.tag == 1){
        cell.textLabel.text = _arrayData[indexPath.row];
//        cell.textLabel.text = @"test002";
    }else if (tableView.tag == 2){
        
        cell.textLabel.text = _arrayData[indexPath.row];
//        cell.textLabel.text = @"test003";
    }else if (tableView.tag == 3){
        cell.textLabel.text = _arrayData[indexPath.row];
//        cell.textLabel.text = @"test004";
    }else if (tableView.tag == 4){
        cell.textLabel.text = _addArray[indexPath.row];
//        cell.textLabel.text = @"test005";
    }else{
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    __weak typeof(self) weakself = self;
    
    NextViewController *nextVC = [[NextViewController alloc] init];
//    nextVC.datagate = self;
    
//    NSMutableArray *data = [[NSMutableArray alloc] initWithObjects:@"one",@"one",@"one",@"one",@"one", nil];
    
//    nextVC.dataArray = data;
    
    nextVC.block = ^(NSString *str) {
      
        self.navigationItem.rightBarButtonItem.title = str;
        
    };
    
  
    
    NSLog(@"nextVC.dataArray:%@",nextVC.dataArray);
    switch (tableView.tag) {
        case 0:
            
            switch (indexPath.row) {
                case 0:
                    
                    [self.navigationController pushViewController:nextVC animated:YES];
                    
                    break;
                    
                default:
                    break;
            }
            
            break;
            
        case 1:
            
            break;
            
        case 2:
            
            break;
            
        case 3:
            
            break;
            
        case 4:
            
            break;
        default:
            break;
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 100) {
        NSInteger index = scrollView.contentOffset.x/[UIScreen mainScreen].bounds.size.width;
        self.indexPathRow = index;
        NSIndexPath *indexpat = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexpat atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.collectionView reloadData];
    }
    
}

-(void)pullNewData:(MJRefreshNormalHeader *)header{

    UITableView *tableview = [self.view viewWithTag:header.tag -100];

    NSLog(@"+++++%ld",tableview.tag);
    
    switch (header.tag) {
        case 100:
        
            [header beginRefreshing];
            
            [_arrayData addObjectsFromArray:_addArray];
            
//            [tableview reloadData];

            [header endRefreshing];
            
            
            NSLog(@"00000");

            
            break;
        case 101:
            
            [header beginRefreshing];

            [_arrayData addObjectsFromArray:_addArray];
            [tableview reloadData];

            [header endRefreshing];

            NSLog(@"11111");


            break;
            
        case 102:
        

            [header beginRefreshing];

            [_arrayData addObjectsFromArray:_addArray];
            [tableview reloadData];

            [header endRefreshing];

            NSLog(@"22222");

            break;
            
        case 103:
            

            [header beginRefreshing];

            [_arrayData addObjectsFromArray:_addArray];
            [tableview reloadData];

            [header endRefreshing];
            
            NSLog(@"33333");


            break;
            
        case 104:
            

            [header beginRefreshing];

            [_arrayData addObjectsFromArray:_addArray];
            [tableview reloadData];

            [header endRefreshing];


            NSLog(@"444444");

            
            break;
        default:
            break;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
