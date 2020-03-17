//
//  MainViewController.m
//  DarkModeAdaptation
//
//  Created by grx on 2020/3/17.
//  Copyright © 2020 ruixiao. All rights reserved.
//

#import "MainViewController.h"
#import "ColorDefine.h"
#import "UIColor+HZXColor.h"

@interface MainViewController ()

@property (nonatomic,strong) UILabel *titleLable;
@property (nonatomic,strong) UILabel *contentLable;
@property (nonatomic,strong) UIImageView *contentImage;

@property (nonatomic,strong) UIButton *changeModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /** iOS13系统颜色 */
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    /** 当前系统模式 */
    if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
        self.navigationItem.title = @"暗黑模式";
    }else{
        self.navigationItem.title = @"普通模式";
    }
    [self.view addSubview:self.titleLable];
    /** 利用宏定义修改文本颜色 */
    self.titleLable.textColor = KCustomAdjustColor([UIColor blackColor], [UIColor whiteColor]);
    /** 利用UIColor的类别修改文本背景颜色 */
    self.titleLable.backgroundColor = [UIColor colorWithLightColorStr:@"226597" DarkColor:@"5ACFB1"] ;
    
    
    [self.view addSubview:self.contentLable];
    /** 利用Color.xcassets修改文本颜色 */
    self.contentLable.textColor = [UIColor colorNamed:@"customColor"];
    /** 利用Color.xcassets修改文本背景颜色 */
    self.contentLable.backgroundColor = [UIColor colorNamed:@"custombgColor"];
    
     /** 图片适配 */
    [self.view addSubview:self.contentImage];
    self.contentImage.image = [UIImage imageNamed:@"Apple"];
    
    /** 切换模式 */
    [self.view addSubview:self.changeModel];
}

/** 重写这个方法就会改变当前页面的模式 */ 
//- (UIUserInterfaceStyle)overrideUserInterfaceStyle{
//    return UIUserInterfaceStyleLight;
//}

-(UILabel *)titleLable{
    if (!_titleLable) {
        _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 220, self.view.frame.size.width-60, 60)];
        _titleLable.font = [UIFont systemFontOfSize:18];
        _titleLable.textAlignment = NSTextAlignmentCenter;
        _titleLable.text = @"当前系统模式显示文本颜色";
    }
    return _titleLable;
}

-(UILabel *)contentLable{
    if (!_contentLable) {
        _contentLable = [[UILabel alloc]initWithFrame:CGRectMake(30, 340, self.view.frame.size.width-60, 120)];
        _contentLable.font = [UIFont systemFontOfSize:15];
        _contentLable.numberOfLines = 0;
        _contentLable.text = @"按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本,按照系统的颜色变化。显示内容文本";
    }
    return _contentLable;
}

-(UIImageView *)contentImage{
    if (!_contentImage) {
        _contentImage = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-40, 100, 80, 80)];
    }
    return _contentImage;
}

-(UIButton *)changeModel{
    if (!_changeModel) {
        _changeModel = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 120, 40)];
        [_changeModel setTitleColor:KCustomAdjustColor([UIColor blackColor], [UIColor whiteColor]) forState:UIControlStateNormal];
        [_changeModel setTitle:@"切换模式" forState:UIControlStateNormal];
        [_changeModel setBackgroundColor:[UIColor colorWithLightColorStr:@"226597" DarkColor:@"5ACFB1"]];
        _changeModel.layer.borderWidth = 1;
        _changeModel.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/1.2);
        [_changeModel addTarget:self action:@selector(changeModelClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeModel;
}

/** 主动开启黑暗模式 */
-(void)changeModelClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;
    }else{
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
}

/** 模式改变的回调代理 */
- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection{
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            if (self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
                self.navigationItem.title = @"普通模式";
            }else{
                self.navigationItem.title = @"暗黑模式";
            }
        }
    }
}



@end
