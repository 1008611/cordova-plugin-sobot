# cordova-plugin-sobot
=======
this is my sobot plugin \<br> 

android and ios \<br> 

‘有关参数可以根据需求调整。’
#安装
cordova plugin add  https://github.com/1008611/cordova-plugin-sobot

#使用

##初始化

在页面js开始能执行的地方
```
  navigator.sobot.init({enterpriseId : "ad33977af6d64f12b9c16bb335039c8c"},
                //上面是本人的测试账号，自行去官网申请。
                function () {
                    var uiOptions = {
                        //是否保持会话，默认NO,点击返回直接断开会话链接
                        isKeepSession: true,
                        //自定义风格颜色：导航
                        customBannerColor: "#f15350",
                        //右边聊天气泡颜色
                        rightChatColor: "#f15350",
                        //评价普通按钮颜色(默认跟随主题色customBannerColor)
                        commentButtonBgColor: "#f15350",
                        //评价提交按钮颜色(默认跟随主题色customBannerColor)
                        commentCommitButtonColor: "#f15350",
                    };
                    navigator.sobot.ui(uiOptions,
                        function () {

                        }, function (err) {

                        });

                },
                function (err) {
                });
```
##调出机器人
```
navigator.sobot.open(    {
                    enterpriseId : "",
                    userId : "",
                    nickName : "",
                    phone : "",
                    email : "",
                    customInfo : {},
                    groupId : ""
                },
                    function (data) {
                        if (data.state == "loaded") {
                            //popupService.toast('loaded');
                        }
                        if (data.state == "receiving") {
                            var num = data.num;
                            
                            var message = data.message;

                            //popupService.toast(num + ": " + message);
                        }
                        if (data.state == "closed") {
                            //popupService.toast('closed');
                        }
                    }, function () {

                    }
                );
```

