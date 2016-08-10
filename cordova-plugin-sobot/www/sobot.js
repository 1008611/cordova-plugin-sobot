var exec = require('cordova/exec');

module.exports = {
  /*
    options = {
      //企业唯一编号, not null
      enterpriseId : ""
    };
  */
  init: function (options, onSuccess, onError) {
    return exec(onSuccess, onError, "Sobot", "init", [options]);
  },

  /*
    options = {
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
  */
  open: function (options,  onSuccess, onError) {
    return exec(onSuccess, onError, "Sobot", "open", [options]);
  },

  /*
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
  ui: function (options, onSuccess, onError) {
    return exec(onSuccess, onError, "Sobot", "ui", [options]);
  }
};


// navigator.sobot.open(options,
//       function (data) {
//         if (data.state == "loaded") {}
//         if (data.state == "receiving") {
//           var num = date.num;
//           var message = date.message;
//         }
//         if (data.state == "closed") {}
//       }, function () {
//       }
//     );
