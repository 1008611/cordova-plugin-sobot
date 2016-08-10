package org.apache.cordova.sobot;


import android.annotation.TargetApi;
import android.content.Context;
import android.util.Log;

import com.sobot.chat.SobotApi;
import com.sobot.chat.api.model.ConsultingContent;
import com.sobot.chat.api.model.Information;
import com.sobot.chat.listener.MessageListener;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaActivity;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.Map;

public class Sobot extends CordovaPlugin {
    CallbackContext cb;
    Context context;
    String enterpriseId;
    Information info;
    boolean isKeepSession;
    boolean isShowEvaluate;
    boolean isShowTansfer;
    boolean isSettingSkillSet;
    String skillSetId;
    String goodsImage;
    String goodsTitle;
    String goodsSendText;
    String customBannerColor;

    String userId;
    String nickName;
    String phone;
    String email;
    String mCustomInfo;
    String groupId;

    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
        context = cordova.getActivity().getApplicationContext();
    }

    @TargetApi(19)
    @Override
    public boolean execute(
            String action, JSONArray args, final CallbackContext callbackContext) {
        this.cb = callbackContext;
        info = new Information();
        if (action.equals("init")) {

            try {
                org.json.JSONObject object = args.getJSONObject(0);
                enterpriseId = object.getString("enterpriseId");

                Log.e("TAG--获取到的enterpriseId--", enterpriseId);
                cb.success();
                return true;

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        if (action.equals("ui")) {

            try {
                org.json.JSONObject object = args.getJSONObject(0);

                Log.e("TAG--获取到的ui info--", object + "");

                //判断 参数的存在
                boolean hasIsKeepSession = object.has("isKeepSession");
                boolean hasIsShowEvaluate = object.has("isShowEvaluate");
                boolean hasIsShowTansfer = object.has("isShowTansfer");
                boolean hasIsSettingSkillSet = object.has("isSettingSkillSet");
                boolean hasSkillSetId = object.has("skillSetId");
                boolean hasGoodsImage = object.has("goodsImage");
                boolean hasGoodsTitle = object.has("goodsTitle");
                boolean hasGoodsSendText = object.has("goodsSendText");
                boolean hasCcustomBannerColor = object.has("customBannerColor");

                if (hasIsKeepSession) {
                    isKeepSession = object.getBoolean("isKeepSession");
                }
                if (hasIsShowEvaluate) {
                    isShowEvaluate = object.getBoolean("isShowEvaluate");
                }
                if (hasIsShowTansfer) {
                    isShowTansfer = object.getBoolean("isShowTansfer");
                }
                if (hasIsSettingSkillSet) {
                    isSettingSkillSet = object.getBoolean("isSettingSkillSet");
                }
                if (hasSkillSetId) {
                    skillSetId = object.getString("skillSetId");
                }
                if (hasGoodsImage) {
                    goodsImage = object.getString("goodsImage");
                }
                if (hasGoodsTitle) {
                    goodsTitle = object.getString("goodsTitle");
                }
                if (hasGoodsSendText) {
                    goodsSendText = object.getString("goodsSendText");
                }
                if (hasCcustomBannerColor) {
                    customBannerColor = object.getString("customBannerColor");
                }

                cb.success();
                return true;

            } catch (JSONException e) {
                e.printStackTrace();
            }
        }

        if (action.equals("open")) {
            try {

                org.json.JSONObject object = args.getJSONObject(0);

                boolean hasUserId = object.has("userId");
                boolean hasNickName = object.has("nickName");
                boolean hasPhone = object.has("phone");
                boolean hasEmail = object.has("email");
                boolean hasCustomInfo = object.has("customInfo");
                boolean hasGroupId = object.has("groupId");
                if (hasUserId) {
                    userId = object.getString("userId");//用户唯一标识（对接用户可靠身份，不建议为null）, 将自动备注到客户资料
                }
                if (hasNickName) {
                    nickName = object.getString("nickName");//用户昵称, null, 将自动备注到客户资料
                }
                if (hasPhone) {
                    phone = object.getString("phone"); //用户电话, null, 将自动备注到客户资料
                }
                if (hasEmail) {
                    email = object.getString("email"); //用户邮箱, null, 将自动备注到客户资料
                }
                if (hasCustomInfo) {
                    mCustomInfo = object.getString("customInfo");//自定义用户资料, null, 将自动显示到客服工作台客户资料(key-value)
                }
                if (hasGroupId) {
                    groupId = object.getString("groupId");//当前转接的技能组, null, 自动连接上一个客服时用户服务端验证
                }

                info.setAppKey(enterpriseId);/* 必填 */  //测试账号 ad33977af6d64f12b9c16bb335039c8c  enterpriseId
                info.setNickName(nickName);/* 用户昵称，选填 */
                info.setPhone(phone);/* 用户电话，选填 */
                info.setEmail(email);/* 用户邮箱，选填 */
                info.setUid(userId);/* 设置用户唯一标识 */
                info.setColor(customBannerColor);/* 选填   顶部颜色*/
                info.setBackOrClose(isKeepSession);
                // 设置 是否会话保持。默认true，进行会话保持显示返回。false，不进行会话保持显示关闭
                info.setShowSatisfaction(isShowEvaluate);
                // 设置为关闭时，点击关闭是否弹出满意度评价。默认true，弹出，false不弹满意度。直接弹是否关闭的dialog

                info.setSettingSkillSet(isSettingSkillSet);/* 是否预设技能组 */
                // 该方法在1.4.2里面不存在了。客服反映  1.4.2版本的SDK是判断预设的技能组id是否为空。
                info.setSkillSetId(skillSetId);/* 预设技能组编号，选填 */

                Map<String, String> customInfo = new HashMap<String, String>();
                customInfo.put("技能1", "聊天");

//                 将json字符串转换成jsonObject
//                JSONObject jsonObject = JSONObject.fromObject(mCustomInfo);
//                Iterator it = jsonObject.keys();
//                // 遍历jsonObject数据，添加到Map对象
//                while (it.hasNext()) {
//                    String key = String.valueOf(it.next());
//                    String value = (String) jsonObject.get(key);
//                    customInfo.put(key, value);
//                }
                info.setCustomInfo(customInfo);/* 自定义用户资料 */ //现在pc还没有做好这个地方。这是预留字段

                ConsultingContent consultingContent = new ConsultingContent();/* 咨询内容 */
                consultingContent.setTitle(goodsTitle);/* 咨询内容标题 */
                consultingContent.setImgUrl(goodsImage); // 咨询内容图片 选填 //
                consultingContent.setFromUrl(goodsSendText);/* 发送内容 */
                info.setConsultingContent(consultingContent); /* 可以设置为null */

                //获取到未读消息的数量
                SobotApi.setMessageListener(new MessageListener() {
                    @Override
                    public void onReceiveMessage(int noReadNum) {
                        Log.e("TAG-未读消息数量", noReadNum + "");
                        String num = noReadNum + "";
                        try {
                            PluginResult r2 = new PluginResult(
                                    PluginResult.Status.OK,
                                    Sobot.message("receiving", num)
                            );
                            r2.setKeepCallback(true);
                            cb.sendPluginResult(r2);

                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    }
                });

                SobotApi.startSobotChat(context, info);
                PluginResult r = new PluginResult(
                        PluginResult.Status.OK,
                        Sobot.message("loaded", "load")
                );

                r.setKeepCallback(true);
                cb.sendPluginResult(r);

            } catch (Exception e) {
                e.printStackTrace();
            }
            return true;
        }

        return true;
    }


    private static JSONObject message(String state, String status)
            throws JSONException {

        JSONObject json = new JSONObject();
        json.put("state", state);
        json.put("num", status);
        return json;
    }

    @Override
    public void onDestroy() {
        super.onDestroy();

    }
}