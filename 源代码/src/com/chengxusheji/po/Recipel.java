package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Recipel {
    /*个性DIY制作id*/
    private Integer recipelId;
    public Integer getRecipelId(){
        return recipelId;
    }
    public void setRecipelId(Integer recipelId){
        this.recipelId = recipelId;
    }

    /*个性DIY制作照片*/
    private String recipelPhoto;
    public String getRecipelPhoto() {
        return recipelPhoto;
    }
    public void setRecipelPhoto(String recipelPhoto) {
        this.recipelPhoto = recipelPhoto;
    }

    /*上传用户*/
    private UserInfo userObj;
    public UserInfo getUserObj() {
        return userObj;
    }
    public void setUserObj(UserInfo userObj) {
        this.userObj = userObj;
    }

    /*个性DIY制作备注*/
    private String recipelMemo;
    public String getRecipelMemo() {
        return recipelMemo;
    }
    public void setRecipelMemo(String recipelMemo) {
        this.recipelMemo = recipelMemo;
    }

    /*处理状态*/
    @NotEmpty(message="处理状态不能为空")
    private String handState;
    public String getHandState() {
        return handState;
    }
    public void setHandState(String handState) {
        this.handState = handState;
    }

    /*上传时间*/
    private String addTime;
    public String getAddTime() {
        return addTime;
    }
    public void setAddTime(String addTime) {
        this.addTime = addTime;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonRecipel=new JSONObject(); 
		jsonRecipel.accumulate("recipelId", this.getRecipelId());
		jsonRecipel.accumulate("recipelPhoto", this.getRecipelPhoto());
		jsonRecipel.accumulate("userObj", this.getUserObj().getName());
		jsonRecipel.accumulate("userObjPri", this.getUserObj().getUser_name());
		jsonRecipel.accumulate("recipelMemo", this.getRecipelMemo());
		jsonRecipel.accumulate("handState", this.getHandState());
		jsonRecipel.accumulate("addTime", this.getAddTime().length()>19?this.getAddTime().substring(0,19):this.getAddTime());
		return jsonRecipel;
    }}