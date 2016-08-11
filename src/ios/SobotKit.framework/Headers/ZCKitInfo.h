//
//  ZCKitInitInfo.h
//  SobotKit
//
//  Created by zhangxy on 15/11/13.
//  Copyright © 2015年 zhichi. All rights reserved.
//
#import "ZCLibInitInfo.h"



////////////////////////////////////////////////////////////////
// 自定义回调）
////////////////////////////////////////////////////////////////
@protocol ZCReceivedMessageDelegate <NSObject>

/**
 *  未读消息数获取
 *
 *  @param object 当前消息
 *  @param nleft  未读消息数
 */
-(void)onReceivedMessage:(id) message unRead:(int) nleft;

@end

/**
 *  未读消息数，block方式获取
 *
 *  @param message 当前消息
 *  @param nleft   未读消息数
 */
typedef void(^ReceivedMessageBlock)(id message,int nleft);


/**
 *  配置初始化自定义类
 *  自定义字体（可选） 自定义背景、边框线颜色（可选） 初始化必须参数（ZCLibInitInfo）
 */
@interface ZCKitInfo : NSObject

/**
 *  初始化必须参数（sysNum）
 */
@property(nonatomic,strong) ZCLibInitInfo *info;


/**
 *  接口域名
 */
@property(nonatomic,strong) NSString *apiHost;


/**
 *  是否保持会话，默认NO,点击返回直接断开会话链接
 */
@property (nonatomic,assign) BOOL    isKeepSession;


/**
 *  自定义关闭的时候是否推送满意度评价
 *  默认为N0;
 *
 */
@property (nonatomic,assign) BOOL    isShowEvaluate;

/**
 *  机器人优先模式，是否直接显示转人工按钮(值为NO时，会在机器人无法回答时显示转人工按钮)，默认，YES
 */
@property (nonatomic,assign) BOOL    isShowTansfer;



/**
 *  是否主动传递技能组
 *  YES，SDK内部转接人工将不再弹出技能组选项
 */
@property (nonatomic,assign) BOOL       isSettingSkillSet;

/**
 *  技能组编号
 *  null
 *  根据传递的值转接到对应的技能组
 */
@property (nonatomic,strong) NSString   *skillSetId;



////////////////////////////////////////////////////////////////
// 自定义咨询内容，在转接人工成功时，方便用户发送自己咨询的信息，（可选）
////////////////////////////////////////////////////////////////

/**
 *  图片URL null
 */
@property(nonatomic,strong) NSString *goodsImage;

/**
 *  标题，如果要显示必须填写
 *  not null
 */
@property(nonatomic,strong) NSString *goodsTitle;

/**
 *  发送给客服的内容，如果要显示必须填写
 *  not null
 */
@property(nonatomic,strong) NSString *goodsSendText;





////////////////////////////////////////////////////////////////
// 自定义字体，（可选）
////////////////////////////////////////////////////////////////

/**
 *  顶部标题颜色、评价标题
 */
@property (nonatomic,strong) UIFont    *titleFont;

/**
 *  页面返回按钮，输入框，评价提交按钮、Toast提示语
 */
@property (nonatomic,strong) UIFont    *listTitleFont;

/**
 *  各种按钮，网络提醒
 */
@property (nonatomic,strong) UIFont    *listDetailFont;

/**
 *  消息提醒(转人工、客服接待等)
 */
@property (nonatomic,strong) UIFont    *listTimeFont;

/**
 *  聊天气泡中文字
 */
@property (nonatomic,strong) UIFont    *chatFont;



////////////////////////////////////////////////////////////////
// 自定义背景、边框线颜色，（可选）
////////////////////////////////////////////////////////////////

/**
 *  对话页面背景
 */
@property (nonatomic,strong) UIColor    *backgroundColor;

/**
 *  自定义风格颜色：导航
 *
 */
@property (nonatomic,strong) UIColor    *customBannerColor;

/**
 *  左边聊天气泡颜色
 */
@property (nonatomic,strong) UIColor    *leftChatColor;

/**
 *  右边聊天气泡颜色
 */
@property (nonatomic,strong) UIColor    *rightChatColor;

/**
 *  底部bottom的背景颜色
 */
@property (nonatomic,strong) UIColor    *backgroundBottomColor;


/**
 *  底部bottom框边框线颜色(输入框、录音按钮、分割线)
 */
@property (nonatomic,strong) UIColor    *bottomLineColor;

/**
 *  评价普通按钮颜色(默认跟随主题色customBannerColor)
 */
@property (nonatomic,strong) UIColor    *commentButtonBgColor;

/**
 *  评价提交按钮颜色(默认跟随主题色customBannerColor)
 */
@property (nonatomic,strong) UIColor    *commentCommitButtonColor;


/**
 *  提示气泡的背景颜色
 */
@property (nonatomic,strong) UIColor    *BgTipAirBubblesColor;



////////////////////////////////////////////////////////////////
// 自定义文字颜色，（可选）
////////////////////////////////////////////////////////////////

/**
 *  顶部文字颜色
 */
@property (nonatomic,strong) UIColor    *topViewTextColor;

/**
 *  左边气泡文字颜色
 */
@property (nonatomic,strong) UIColor    *leftChatTextColor;


/**
 *  右边气泡文字颜色
 */
@property (nonatomic,strong) UIColor    *rightChatTextColor;

/**
 *  时间文字的颜色
 */
@property (nonatomic,strong) UIColor    *timeTextColor;

/**
 *  提示气泡文字颜色
 */
@property (nonatomic,strong) UIColor    *tipLayerTextColor;

/**
 *  客服昵称颜色
 */
@property (nonatomic,strong) UIColor    *serviceNameTextColor;



@property (nonatomic,strong) id<ZCReceivedMessageDelegate> delegate;
@property (nonatomic,strong) ReceivedMessageBlock          receivedBlock;

@end