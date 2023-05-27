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
import com.chengxusheji.service.RecipelService;
import com.chengxusheji.po.Recipel;
import com.chengxusheji.service.UserInfoService;
import com.chengxusheji.po.UserInfo;

//Recipel管理控制层
@Controller
@RequestMapping("/Recipel")
public class RecipelController extends BaseController {

    /*业务层对象*/
    @Resource RecipelService recipelService;

    @Resource UserInfoService userInfoService;
	@InitBinder("userObj")
	public void initBinderuserObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userObj.");
	}
	@InitBinder("recipel")
	public void initBinderRecipel(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("recipel.");
	}
	/*跳转到添加Recipel视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Recipel());
		/*查询所有的UserInfo信息*/
		List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
		request.setAttribute("userInfoList", userInfoList);
		return "Recipel_add";
	}

	/*客户端ajax方式提交添加个性DIY制作信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Recipel recipel, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			recipel.setRecipelPhoto(this.handlePhotoUpload(request, "recipelPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
        recipelService.addRecipel(recipel);
        message = "个性DIY制作添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	/*用户前台客户端ajax方式提交添加个性DIY制作信息*/
	@RequestMapping(value = "/userAdd", method = RequestMethod.POST)
	public void userAdd(Recipel recipel, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		try {
			recipel.setRecipelPhoto(this.handlePhotoUpload(request, "recipelPhotoFile"));
		} catch(UserException ex) {
			message = "图片格式不正确！";
			writeJsonResponse(response, success, message);
			return ;
		}
		
		UserInfo userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		recipel.setUserObj(userObj);
		
		recipel.setHandState("待处理");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		recipel.setAddTime(sdf.format(new java.util.Date()));
		 
        recipelService.addRecipel(recipel);
        message = "个性DIY制作添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	/*ajax方式按照查询条件分页查询个性DIY制作信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("userObj") UserInfo userObj,String handState,String addTime,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (handState == null) handState = "";
		if (addTime == null) addTime = "";
		if(rows != 0)recipelService.setRows(rows);
		List<Recipel> recipelList = recipelService.queryRecipel(userObj, handState, addTime, page);
	    /*计算总的页数和总的记录数*/
	    recipelService.queryTotalPageAndRecordNumber(userObj, handState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = recipelService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = recipelService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Recipel recipel:recipelList) {
			JSONObject jsonRecipel = recipel.getJsonObject();
			jsonArray.put(jsonRecipel);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询个性DIY制作信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Recipel> recipelList = recipelService.queryAllRecipel();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Recipel recipel:recipelList) {
			JSONObject jsonRecipel = new JSONObject();
			jsonRecipel.accumulate("recipelId", recipel.getRecipelId());
			jsonArray.put(jsonRecipel);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询个性DIY制作信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("userObj") UserInfo userObj,String handState,String addTime,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (handState == null) handState = "";
		if (addTime == null) addTime = "";
		List<Recipel> recipelList = recipelService.queryRecipel(userObj, handState, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    recipelService.queryTotalPageAndRecordNumber(userObj, handState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = recipelService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = recipelService.getRecordNumber();
	    request.setAttribute("recipelList",  recipelList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("handState", handState);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Recipel/recipel_frontquery_result"; 
	}
	
	
	/*用户前台按照查询条件分页查询个性DIY制作信息*/
	@RequestMapping(value = { "/userFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String userFrontlist(@ModelAttribute("userObj") UserInfo userObj,String handState,String addTime,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (handState == null) handState = "";
		if (addTime == null) addTime = "";
		userObj = new UserInfo();
		userObj.setUser_name(session.getAttribute("user_name").toString());
		List<Recipel> recipelList = recipelService.queryRecipel(userObj, handState, addTime, currentPage);
	    /*计算总的页数和总的记录数*/
	    recipelService.queryTotalPageAndRecordNumber(userObj, handState, addTime);
	    /*获取到总的页码数目*/
	    int totalPage = recipelService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = recipelService.getRecordNumber();
	    request.setAttribute("recipelList",  recipelList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("userObj", userObj);
	    request.setAttribute("handState", handState);
	    request.setAttribute("addTime", addTime);
	    List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
	    request.setAttribute("userInfoList", userInfoList);
		return "Recipel/recipel_userFrontquery_result"; 
	}
	

     /*前台查询Recipel信息*/
	@RequestMapping(value="/{recipelId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer recipelId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键recipelId获取Recipel对象*/
        Recipel recipel = recipelService.getRecipel(recipelId);

        List<UserInfo> userInfoList = userInfoService.queryAllUserInfo();
        request.setAttribute("userInfoList", userInfoList);
        request.setAttribute("recipel",  recipel);
        return "Recipel/recipel_frontshow";
	}

	/*ajax方式显示个性DIY制作修改jsp视图页*/
	@RequestMapping(value="/{recipelId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer recipelId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键recipelId获取Recipel对象*/
        Recipel recipel = recipelService.getRecipel(recipelId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonRecipel = recipel.getJsonObject();
		out.println(jsonRecipel.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新个性DIY制作信息*/
	@RequestMapping(value = "/{recipelId}/update", method = RequestMethod.POST)
	public void update(@Validated Recipel recipel, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String recipelPhotoFileName = this.handlePhotoUpload(request, "recipelPhotoFile");
		if(!recipelPhotoFileName.equals("upload/NoImage.jpg"))recipel.setRecipelPhoto(recipelPhotoFileName); 


		try {
			recipelService.updateRecipel(recipel);
			message = "个性DIY制作更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "个性DIY制作更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除个性DIY制作信息*/
	@RequestMapping(value="/{recipelId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer recipelId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  recipelService.deleteRecipel(recipelId);
	            request.setAttribute("message", "个性DIY制作删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "个性DIY制作删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条个性DIY制作记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String recipelIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = recipelService.deleteRecipels(recipelIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出个性DIY制作信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("userObj") UserInfo userObj,String handState,String addTime, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(handState == null) handState = "";
        if(addTime == null) addTime = "";
        List<Recipel> recipelList = recipelService.queryRecipel(userObj,handState,addTime);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Recipel信息记录"; 
        String[] headers = { "个性DIY制作id","个性DIY制作照片","上传用户","个性DIY制作备注","处理状态","上传时间"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<recipelList.size();i++) {
        	Recipel recipel = recipelList.get(i); 
        	dataset.add(new String[]{recipel.getRecipelId() + "",recipel.getRecipelPhoto(),recipel.getUserObj().getName(),recipel.getRecipelMemo(),recipel.getHandState(),recipel.getAddTime()});
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
			response.setHeader("Content-disposition","attachment; filename="+"Recipel.xls");//filename是下载的xls的名，建议最好用英文 
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
