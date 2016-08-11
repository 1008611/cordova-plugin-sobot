//
//  ZCUIBaseController.h
//  SobotKit
//
//  Created by zhangxy on 15/11/12.
//  Copyright © 2015年 zhichi. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  智齿SDK中公共UIViewController
 */
@interface ZCUIBaseController : UIViewController

/**
 *  顶部的View
 */
@property(nonatomic,strong) UIView      * topView;

/**
 *  关闭按钮（返回）
 */
@property(nonatomic,strong) UIButton    * backButton;
@property(nonatomic,strong) UIButton    * closeButton;

/**
 *  标题
 */
@property(nonatomic,strong) UILabel     * titleLabel;

/**
 *  创建TitleView
 */
-(void)createTitleView;

@end
