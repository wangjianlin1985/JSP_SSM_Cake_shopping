package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Recipel;

import com.chengxusheji.mapper.RecipelMapper;
@Service
public class RecipelService {

	@Resource RecipelMapper recipelMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加个性DIY制作记录*/
    public void addRecipel(Recipel recipel) throws Exception {
    	recipelMapper.addRecipel(recipel);
    }

    /*按照查询条件分页查询个性DIY制作记录*/
    public ArrayList<Recipel> queryRecipel(UserInfo userObj,String handState,String addTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_recipel.userObj='" + userObj.getUser_name() + "'";
    	if(!handState.equals("")) where = where + " and t_recipel.handState like '%" + handState + "%'";
    	if(!addTime.equals("")) where = where + " and t_recipel.addTime like '%" + addTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return recipelMapper.queryRecipel(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Recipel> queryRecipel(UserInfo userObj,String handState,String addTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_recipel.userObj='" + userObj.getUser_name() + "'";
    	if(!handState.equals("")) where = where + " and t_recipel.handState like '%" + handState + "%'";
    	if(!addTime.equals("")) where = where + " and t_recipel.addTime like '%" + addTime + "%'";
    	return recipelMapper.queryRecipelList(where);
    }

    /*查询所有个性DIY制作记录*/
    public ArrayList<Recipel> queryAllRecipel()  throws Exception {
        return recipelMapper.queryRecipelList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,String handState,String addTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_recipel.userObj='" + userObj.getUser_name() + "'";
    	if(!handState.equals("")) where = where + " and t_recipel.handState like '%" + handState + "%'";
    	if(!addTime.equals("")) where = where + " and t_recipel.addTime like '%" + addTime + "%'";
        recordNumber = recipelMapper.queryRecipelCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取个性DIY制作记录*/
    public Recipel getRecipel(int recipelId) throws Exception  {
        Recipel recipel = recipelMapper.getRecipel(recipelId);
        return recipel;
    }

    /*更新个性DIY制作记录*/
    public void updateRecipel(Recipel recipel) throws Exception {
        recipelMapper.updateRecipel(recipel);
    }

    /*删除一条个性DIY制作记录*/
    public void deleteRecipel (int recipelId) throws Exception {
        recipelMapper.deleteRecipel(recipelId);
    }

    /*删除多条个性DIY制作信息*/
    public int deleteRecipels (String recipelIds) throws Exception {
    	String _recipelIds[] = recipelIds.split(",");
    	for(String _recipelId: _recipelIds) {
    		recipelMapper.deleteRecipel(Integer.parseInt(_recipelId));
    	}
    	return _recipelIds.length;
    }
}
