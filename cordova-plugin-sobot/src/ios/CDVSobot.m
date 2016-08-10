
//  CDVSobot.m
//  创业服务
//
//  Created by Dream on 16/4/22.
//
//

#import "CDVSobot.h"

@implementation CDVSobot
//初始化
-(void)init:(CDVInvokedUrlCommand *)command
{
    self.uiInfo=[ZCKitInfo new];
    self.rootVC                    = (CDVViewController *)self.viewController;
    NSDictionary * dic             = [command argumentAtIndex:0];
    NSString *enterpriseId         = dic[@"enterpriseId"];
    [[NSUserDefaults standardUserDefaults] setObject:enterpriseId forKey:@"Pre_Text"];
    if(enterpriseId.length < 5 ){
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsBool:NO];
        [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        return;
    }
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}
//开启客服
- (void)open:(CDVInvokedUrlCommand *)command
{
    
    // 启动
    ZCLibInitInfo *initInfo = [ZCLibInitInfo new];
    NSDictionary * dic      = [command argumentAtIndex:0];
    self.currentId          = command.callbackId;
    initInfo.enterpriseId   = [[NSUserDefaults standardUserDefaults] objectForKey:@"Pre_Text"];;
    initInfo.userId         = dic[@"userId"];
    initInfo.nickName       = dic[@"nickName"];
    initInfo.phone          = dic[@"phone"];
    initInfo.email          = dic[@"email"];
    initInfo.customInfo     = dic[@"customInfo"];
    initInfo.groupId        = dic[@"groupId"];
    
    if(initInfo.enterpriseId.length < 5 ){
        CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"enterpriseId.length < 5"];
        [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        return;
    }
    
    self.uiInfo.info     = initInfo;
    
    //接收到消息
    __weak CDVSobot* ws = self;
    [self.uiInfo setReceivedBlock:^(id message,int nLeft){
        NSLog(@"当前消息数：%d \n %@",nLeft,message);
        NSDictionary *result = @{@"state" : @"receiving", @"num" : [NSNumber numberWithInt:nLeft], @"message" : message};
        CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
        [commandResult setKeepCallbackAsBool:TRUE];
        [ws.commandDelegate sendPluginResult:commandResult callbackId:ws.currentId];
       
    }];

    
    [ZCSobot startZCChatView:self.uiInfo with:self.rootVC pageBlock:^(ZCUIChatController *object, ZCPageBlockType type) {
        // 点击返回
        if(type==ZCPageBlockGoBack){
            NSDictionary *result           = @{@"state" : @"closed"};
            CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
            [commandResult setKeepCallbackAsBool:FALSE];
            [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        }
        // 页面UI初始化完成，可以获取UIView，自定义UI
        if(type==ZCPageBlockLoadFinish){
            NSDictionary *result           = @{@"state" : @"loaded"};
            CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
            [commandResult setKeepCallbackAsBool:TRUE];
            [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
        }
    } messageLinkClick:nil];
}
//自定义属性
- (void)ui:(CDVInvokedUrlCommand *)command
{
    NSDictionary *dic = [command argumentAtIndex:0];
    for (NSString *key in [dic allKeys]) {
        if (dic[key] == nil) {
            continue;
        }
        if ([key hasSuffix:@"Font"]) {
            UIFont *font = [UIFont systemFontOfSize:[dic[key] integerValue]];
            [self.uiInfo setValue:font forKey:key];
            continue;
        }
        if ([key hasSuffix:@"Color"]) {
            UIColor *color = [self colorByHexString:dic[key]];
            if (color) {
                [self.uiInfo setValue:color forKey:key];
            }
            continue;
        }
        [self.uiInfo setValue:dic[key] forKey:key];
    }
    CDVPluginResult *commandResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:YES];
    [self.commandDelegate sendPluginResult:commandResult callbackId:command.callbackId];
}

//字符串转color
- (UIColor *)colorByHexString:(NSString*)hexString
{
    if (!hexString || [hexString isEqualToString:@""]) {
        return nil;
    }
    if (!([hexString isKindOfClass:[NSString class]])) {
        hexString = @"#000000";
    }
    
    if (![hexString hasPrefix:@"#"] || [hexString length] < 4) {
        return nil;
    }
    unsigned int rgbValue = 0;
    NSScanner* scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


/*
 initInfo = {
 //初始化配置用户信息, 企业唯一编号 用户唯一标识 用户昵称 用户电话 用户邮箱
 
 //企业唯一编号, not null
 enterpriseId : "",
 //用户唯一标识（对接用户可靠身份，不建议为null）, 将自动备注到客户资料
 userId : "",
 //用户昵称, null, 将自动备注到客户资料
 nickName : "",
 //用户电话, null, 将自动备注到客户资料
 phone : "",
 //用户邮箱, null, 将自动备注到客户资料
 email : "",
 //自定义用户资料, null, 将自动显示到客服工作台客户资料
 customInfo : {},
 //当前转接的技能组, null, 自动连接上一个客服时用户服务端验证
 groupId : ""
 };
 
 uiInfo = {
 //是否保持会话，默认NO,点击返回直接断开会话链接
 isKeepSession : false,
 //自定义关闭的时候是否推送满意度评价, 默认为N0;
 isShowEvaluate : false,
 //机器人优先模式，是否直接显示转人工按钮(值为NO时，会在机器人无法回答时显示转人工按钮)，默认，YES
 isShowTansfer : true,
 //是否主动传递技能组
 //YES，SDK内部转接人工将不再弹出技能组选项
 isSettingSkillSet : true,
 //技能组编号, null, 根据传递的值转接到对应的技能组
 skillSetId : "",
 
 ////////////////////////////////////////////////////////////////
 // 自定义咨询内容，在转接人工成功时，方便用户发送自己咨询的信息，（可选）
 ////////////////////////////////////////////////////////////////
 
 //某项为空时, 将不会生效
 
 //图片URL null
 goodsImage : "",
 //标题，如果要显示必须填写, not null
 goodsTitle : "",
 //发送给客服的内容，如果要显示必须填写, not null
 goodsSendText : "",
 
 ////////////////////////////////////////////////////////////////
 // 自定义字体，（可选）
 ////////////////////////////////////////////////////////////////
 
 //顶部标题颜色、评价标题
 titleFont : 30,
 //页面返回按钮，输入框，评价提交按钮、Toast提示语
 listTitleFont : 30,
 //各种按钮，网络提醒
 listDetailFont : 30,
 //消息提醒(转人工、客服接待等)
 listTimeFont : 30,
 //聊天气泡中文字
 chatFont : 30,
 
 ////////////////////////////////////////////////////////////////
 // 自定义背景、边框线颜色，（可选）
 ////////////////////////////////////////////////////////////////
 
 //对话页面背景
 backgroundColor : "#0000000",
 //自定义风格颜色：导航
 customBannerColor : "#0000000",
 //左边聊天气泡颜色
 leftChatColor : "#0000000",
 //右边聊天气泡颜色
 rightChatColor : "#0000000",
 //底部bottom的背景颜色
 backgroundBottomColor : "#0000000",
 //底部bottom框边框线颜色(输入框、录音按钮、分割线)
 bottomLineColor : "#0000000",
 //评价普通按钮颜色(默认跟随主题色customBannerColor)
 commentButtonBgColor : "#0000000",
 //评价提交按钮颜色(默认跟随主题色customBannerColor)
 commentCommitButtonColor : "#0000000",
 //提示气泡的背景颜色
 BgTipAirBubblesColor : "#0000000",
 
 ////////////////////////////////////////////////////////////////
 // 自定义文字颜色，（可选）
 ////////////////////////////////////////////////////////////////
 
 //顶部文字颜色
 topViewTextColor : "#0000000",
 //左边气泡文字颜色
 leftChatTextColor : "#0000000",
 //右边气泡文字颜色
 rightChatTextColor : "#0000000",
 //时间文字的颜色
 timeTextColor : "#0000000",
 //提示气泡文字颜色
 tipLayerTextColor : "#0000000",
 //客服昵称颜色
 serviceNameTextColor : "#0000000"
 };
 */

@end
