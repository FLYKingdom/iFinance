//
//  MyBaseViewController.m
//  schoolIM
//
//  Created by bingo on 14-10-15.
//  Copyright (c) 2014年 profusionup. All rights reserved.
//

#import "MyBaseViewController.h"
#import "MBProgressHUD.h"
#import "DSNavigationBar.h"


static const float scrollVolicityY=150.0f;
@interface MyBaseViewController () <MBProgressHUDDelegate> {
    MBProgressHUD *HUD;

}
@property (nonatomic, assign) BOOL isModalStyle;

@property (nonatomic, copy) NSString *pageEvent;

@end
@implementation MyBaseViewController

@synthesize isFooterView;


-(instancetype)initWithModalStyle{
    self = [super init];
    if (self) {
        self.isModalStyle = YES;
    }
    return self;
}


-(id) initIsFooterView:(BOOL)isFooter{
    self = [super init];
    if (self) {
        isFooterView=isFooter;
    }
    return self;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        
    }
    
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=DefaultBackgroundColor;
    
    int titleWidth=kDeviceWidth-100;
    UILabel *navTitle=[[UILabel alloc] initWithFrame:CGRectMake((kDeviceWidth-titleWidth)/2, 0, titleWidth, 44)];
    [navTitle setFont:[UIFont fontWithName:FontName size:18.0f]];
    [navTitle setTextColor:NavigationTintColor];
    [navTitle setTextAlignment:NSTextAlignmentCenter];
    [navTitle setBackgroundColor:[UIColor clearColor]];
    
    [self.navigationItem setTitleView:navTitle];
    
}

#pragma mark - public method

-(void)setupNavigationTitle:(NSString *)titleStr nonTitle:(BOOL)nonTitle{
    if (!nonTitle) {        
        UILabel *label= [[UILabel alloc] init];
        [label setText:titleStr];
        [label setTextColor:DefaultMainColor];
        [label setFont:[UIFont systemFontOfSize:17]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label sizeToFit];
        self.navigationItem.titleView = label;
    }
    
    self.pageEvent = titleStr;//设置 evnet
}


-(void) back :(id)sender  {
    if (!backButtonDisable) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)disableGesture{
    gestureDisable=YES;
}
-(void)disableBackButton{
    
    backButtonDisable=YES;
}


-(void)setupBackgroundColor{
    
   self.view.backgroundColor = DefaultBackgroundColor;
}
- (void)pushNewViewController:(UIViewController *)newViewController {
    
    [self.navigationController pushViewController:newViewController animated:YES];
}

-(void)showLoading{

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = @"请稍候...";
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
}

-(void)showOnWindow{

    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
     HUD.delegate = self;
     HUD.labelText = @"请稍候...";
     [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];

}

/**
  * myTask 方法暂时模拟请求数据所需要加载的时间
 */
- (void)myTask {
  
    sleep(3);
  
}

/**
 *一些操作结果的提示
 */

- (void)showOnWindowWithString:(NSString *)content{
    
    // The hud will dispable all input on the window
    HUD = [[MBProgressHUD alloc] initWithView:self.view.window];
    [self.view.window addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.delegate = self;
    HUD.labelText =content;
    HUD.color = [UIColor orangeColor];
    HUD.labelColor = [UIColor whiteColor];
    HUD.margin = 10.f;
    HUD.yOffset = 150.f;
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

-(void) showToastWithString:(NSString *)content{
    
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    // Configure for text only and offset down
    HUD.mode = MBProgressHUDModeText;
    HUD.labelText =content;
    HUD.color = [UIColor colorWithWhite:0.2f alpha:0.8f];
    HUD.labelColor = [UIColor whiteColor];
    HUD.margin = 10.f;
    HUD.yOffset = 150.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD hide:YES afterDelay:1.4f];
    
    
}

#pragma mark - 生命周期函数

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    DSNavigationBar *navigationBar= (DSNavigationBar *)self.navigationController.navigationBar;
//    [navigationBar setNavigationBarWithColor:[UIColor whiteColor]];
    
    if (self.pageEvent && ![self.pageEvent isEqualToString:@""]) {
        [MobClick beginEvent:self.pageEvent];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self hideLoading];
    self.title = @"";
    if (self.pageEvent && ![self.pageEvent isEqualToString:@""]) {
        [MobClick endEvent:self.pageEvent];
    }
}

//-(void) viewWillAppear:(BOOL)animated{
//    if (isFooterView) {
//        [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
//    }else{
//        [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
//    }
//    
//}

/**
 *加载成功后隐藏加载框
 */
-(void)hideLoading{
    
    [HUD removeFromSuperview];
}

-(void)showSuccess{


}
-(void)showError{


}
/**
 *视图滚动时调用此方法
 */
-(void) scrollisScrolling:(UIScrollView *)scrollView{
    CGPoint scrollVelocity = [scrollView.panGestureRecognizer velocityInView:self.view];
    if (scrollVelocity.y>scrollVolicityY) {
        if ([[self rdv_tabBarController] isTabBarHidden]) {
            [[self rdv_tabBarController] setTabBarHidden:NO animated:YES];
        }

    }else if(scrollVelocity.y<scrollVolicityY*-1){
        
        if (![[self rdv_tabBarController] isTabBarHidden]) {
            [[self rdv_tabBarController] setTabBarHidden:YES animated:YES];
        }
    }
    
}

#pragma mark - set bar style

-(void) setTranslucentBarStyle{
    DSNavigationBar *navigationBar= (DSNavigationBar *)self.navigationController.navigationBar;
    [navigationBar setNavigationBarWithColor:[UIColor colorWithWhite:0.0f alpha:0.0f]];
}

@end
