package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.UserInfo;
import com.chengxusheji.po.Recharge;

import com.chengxusheji.mapper.RechargeMapper;
@Service
public class RechargeService {

	@Resource RechargeMapper rechargeMapper;
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

    /*添加充值记录*/
    public void addRecharge(Recharge recharge) throws Exception {
    	rechargeMapper.addRecharge(recharge);
    }

    /*按照查询条件分页查询充值记录*/
    public ArrayList<Recharge> queryRecharge(UserInfo userObj,String rechargeTime,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null  && !userObj.getUser_name().equals(""))  where += " and t_recharge.userObj='" + userObj.getUser_name() + "'";
    	if(!rechargeTime.equals("")) where = where + " and t_recharge.rechargeTime like '%" + rechargeTime + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return rechargeMapper.queryRecharge(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Recharge> queryRecharge(UserInfo userObj,String rechargeTime) throws Exception  { 
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_recharge.userObj='" + userObj.getUser_name() + "'";
    	if(!rechargeTime.equals("")) where = where + " and t_recharge.rechargeTime like '%" + rechargeTime + "%'";
    	return rechargeMapper.queryRechargeList(where);
    }

    /*查询所有充值记录*/
    public ArrayList<Recharge> queryAllRecharge()  throws Exception {
        return rechargeMapper.queryRechargeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(UserInfo userObj,String rechargeTime) throws Exception {
     	String where = "where 1=1";
    	if(null != userObj &&  userObj.getUser_name() != null && !userObj.getUser_name().equals(""))  where += " and t_recharge.userObj='" + userObj.getUser_name() + "'";
    	if(!rechargeTime.equals("")) where = where + " and t_recharge.rechargeTime like '%" + rechargeTime + "%'";
        recordNumber = rechargeMapper.queryRechargeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取充值记录*/
    public Recharge getRecharge(int rechargeId) throws Exception  {
        Recharge recharge = rechargeMapper.getRecharge(rechargeId);
        return recharge;
    }

    /*更新充值记录*/
    public void updateRecharge(Recharge recharge) throws Exception {
        rechargeMapper.updateRecharge(recharge);
    }

    /*删除一条充值记录*/
    public void deleteRecharge (int rechargeId) throws Exception {
        rechargeMapper.deleteRecharge(rechargeId);
    }

    /*删除多条充值信息*/
    public int deleteRecharges (String rechargeIds) throws Exception {
    	String _rechargeIds[] = rechargeIds.split(",");
    	for(String _rechargeId: _rechargeIds) {
    		rechargeMapper.deleteRecharge(Integer.parseInt(_rechargeId));
    	}
    	return _rechargeIds.length;
    }
}
