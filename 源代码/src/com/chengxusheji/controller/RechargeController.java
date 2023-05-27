package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.RechargeService;
import com.chengxusheji.po.Recharge;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Recharge管理控制层
@Controller
@RequestMapping("/Recharge")
public class RechargeController extends BaseController {

    /*业务层对象*/
    @Resource RechargeService rechargeService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("recharge")
	public void initBinderRecharge(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("recharge.");
	}
	/*跳转到添加Recharge视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Recharge());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Recharge_add";
	}

	/*客户端ajax方式提交添加充值信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Recharge recharge, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        rechargeService.addRecharge(recharge);
        String user_name = recharge.getUserObj().getUser_name();
        UserInfo userInfo = userInfoService.getUserInfo(user_name);
        userInfo.setUserMoney(userInfo.getUserMoney() + recharge.getRechargeMoney());
        userInfoService.updateUserInfo(userInfo);
        
        message = "充值添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询充值信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,String rechargeTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (rechargeTime == null) rechargeTime = "";
		if(rows != 0)rechargeService.setRows(rows);
		List<Recharge> rechargeList = rechargeService.queryRecharge(userObj, rechargeTime, page);
	    /*计算总的页数和总的记录数*/
	    rechargeService.queryTotalPageAndRecordNumber(userObj, rechargeTime);
	    /*获取到总的页码数目*/
	    int totalPage = rechargeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rechargeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Recharge recharge:rechargeList) {
			JSONObject jsonRecharge = recharge.getJsonObject();
			jsonArray.put(jsonRecharge);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询充值信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Recharge> rechargeList = rechargeService.queryAllRecharge();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Recharge recharge:rechargeList) {
			JSONObject jsonRecharge = new JSONObject();
			jsonRecharge.accumulate("rechargeId", recharge.getRechargeId());
			jsonArray.put(jsonRecharge);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询充值信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,String rechargeTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (rechargeTime == null) rechargeTime = "";
		List<Recharge> rechargeList = rechargeService.queryRecharge(userObj, rechargeTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    rechargeService.queryTotalPageAndRecordNumber(userObj, rechargeTime);
	    /*获取到总的页码数目*/
	    int totalPage = rechargeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = rechargeService.getRecordNumber();
	    request.setAttribute("rechargeList",  rechargeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("rechargeTime", rechargeTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Recharge/recharge_frontquery_result"; 
	}

     /*前台查询Recharge信息*/
	@RequestMapping(value="/{rechargeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer rechargeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键rechargeId获取Recharge对象*/
        Recharge recharge = rechargeService.getRecharge(rechargeId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("recharge",  recharge);
        return "Recharge/recharge_frontshow";
	}

	/*ajax方式显示充值修改jsp视图页*/
	@RequestMapping(value="/{rechargeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer rechargeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键rechargeId获取Recharge对象*/
        Recharge recharge = rechargeService.getRecharge(rechargeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRecharge = recharge.getJsonObject();
		out.println(jsonRecharge.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新充值信息*/
	@RequestMapping(value = "/{rechargeId}/update", method = RequestMethod.POST)
	public void update(@Validated Recharge recharge, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			rechargeService.updateRecharge(recharge);
			message = "充值更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "充值更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除充值信息*/
	@RequestMapping(value="/{rechargeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer rechargeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  rechargeService.deleteRecharge(rechargeId);
	            request.setAttribute("message", "充值删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "充值删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条充值记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String rechargeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = rechargeService.deleteRecharges(rechargeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出充值信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,String rechargeTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(rechargeTime == null) rechargeTime = "";
        List<Recharge> rechargeList = rechargeService.queryRecharge(userObj,rechargeTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Recharge信息记录"; 
        String[] headers = { "充值id","充值用户","充值金额","充值时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<rechargeList.size();i++) {
        	Recharge recharge = rechargeList.get(i); 
        	dataset.add(new String[]{recharge.getRechargeId() + "",recharge.getUserObj().getName(),recharge.getRechargeMoney() + "",recharge.getRechargeTime()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Recharge.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
