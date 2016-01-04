//
//  WXLoginViewController.m
//  01-QQZone
//
//  Created by 李伟雄 on 16/1/4.
//  Copyright © 2016年 Liwx. All rights reserved.
//

#import "WXLoginViewController.h"
#import "WXMainViewController.h"

@interface WXLoginViewController () <UITextFieldDelegate>

/** 帐号 */
@property (weak, nonatomic) IBOutlet UITextField *accountTextField;
/** 密码 */
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
/** 记住密码 */
@property (weak, nonatomic) IBOutlet UIButton *remPasswordBtn;
/** 自动登录 */
@property (weak, nonatomic) IBOutlet UIButton *autoLoginBtn;
/** 登陆的view */
@property (weak, nonatomic) IBOutlet UIView *loginView;
/** 转圈的view */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

@end

@implementation WXLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 设置UITextField的代理,此处是用于监听return键的点击事件
    self.accountTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

// SINGLE: 三种方式可实现跳转控制器
// 1.Modal presentViewController:方法
// 2.Push方法
// 3.切换窗口的根控制器

#pragma mark - Event
/** 登陆操作 */
- (IBAction)login {
    
    // 退出键盘,如果没退出键盘,弹出的窗口有异常
    [self.view endEditing:YES];
    
    // 获取帐号和密码
    NSString *account = self.accountTextField.text;
    NSString *password = self.passwordTextField.text;
    
    // 判断用户名密码是否为空,为空退出
    if (account.length == 0 || password.length == 0) {
        [self showError:@"用户名密码不能为空"];
        return;
    }
    
    // 执行登陆操作
    CGFloat duration = 0.0;
    // 登陆中不允许与用户操作
    self.loginView.userInteractionEnabled = NO;
    // 启动活动指示器(开始转圈)
    [self.activityView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 判断帐号和密码是否正确
        if ([account isEqualToString:@"123"] && [password isEqualToString:@"123"]) {
            // 登陆成功, 跳转到QQ空间主界面
            self.view.window.rootViewController = [[WXMainViewController alloc] init];
            
        }else {
            // 登陆失败,弹窗提示
            [self showError:@"帐号或密码错误"];
        }
        // 恢复用户操作,并停止转圈
        self.loginView.userInteractionEnabled = YES;
        [self.activityView stopAnimating];
    });
}

/** 记住密码按钮操作 */
- (IBAction)remPwdBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected == NO) {
        self.autoLoginBtn.selected = NO;
    }
}

/** 自动登陆按钮操作 */
- (IBAction)autoLoginBtnClick:(UIButton *)sender {
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        self.remPasswordBtn.selected = YES;
    }
}

#pragma mark - Error
/** 弹窗并抖动提示 */
- (void)showError:(NSString *)error
{
    // SINGLE: 用UIAlertController做弹框提示
    // 创建UIAlertController控制器
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"登陆失败" message:error preferredStyle:UIAlertControllerStyleAlert];
    // 创建UIAlertAction,并添加到控制器
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    // Modal控制器
    [self presentViewController:alertController animated:YES completion:nil];
    
    // 使用核心动画(序列帧动画)进行抖动
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    anim.keyPath = @"transform.translation.x";
    anim.values = @[@(-10), @0, @10, @0];
    anim.repeatCount = 3;
    anim.duration = 0.1;
    [self.loginView.layer addAnimation:anim forKey:nil];
  
}

#pragma mark - UITextFieldDelegate
// SINGLE: UITextField监听键盘的return键的点击事件
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.accountTextField) {
        // 当前在帐号TextField,点击next跳到密码TextField,让密码TextField成为第一响应者
        [self.passwordTextField becomeFirstResponder];
    }else if(textField == self.passwordTextField){
        // 当前在密码TextField,点击return执行登陆操作
        [self login];
    }
    return YES;
}

@end
