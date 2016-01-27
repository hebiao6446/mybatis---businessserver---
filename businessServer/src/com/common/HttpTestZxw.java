package com.common;


import java.awt.image.AffineTransformOp;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.InetAddress;
import java.net.URL;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.LinkedHashMap;
import java.util.Random;

import javax.imageio.ImageIO;
import javax.print.Doc;
import javax.print.DocFlavor;
import javax.print.DocPrintJob;
import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.SimpleDoc;
import javax.print.attribute.DocAttributeSet;
import javax.print.attribute.HashDocAttributeSet;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.MultiFormatWriter;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

public class HttpTestZxw {

	private static final String contact = "http://127.0.0.1:8080/businessInterface/contact/";
	private static final String blessings = "http://127.0.0.1:8080/businessInterface/blessings/";
	private static final String product = "http://127.0.0.1:8080/businessInterface/product/";

	public static void main(String[] args) throws Exception {

		String paramStr = JSONObject.fromObject(HttpTestZxw.insertProjectInfo()).toString();

		String key = Commonparam.Md5String(paramStr);
		String url = product + "updateProjectInfo.action";
		String post = "data=" + paramStr + "&key=" + key;
		System.out.println(paramStr);
		System.out.println(key);
		System.out.println(url + "?" + post);
		String data = HttpGetMsg.postUrl(url, post);
		System.out.println(data);
	}


	private static Object insertUserGroupInfo() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("name", "我的测试");
		param.put("isDefault", "F");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	

	private static Object insertSellVisit() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("sellId", "1");
		param.put("visitContent", "客户还没有反馈信息");
		param.put("updateTime", "2014-06-09 08:53:38");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	private static Object insertProjectInfo() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("status", "2");
		param.put("contactsId", "9");
		param.put("totalPrice", "200.00");
		param.put("source", "张兴旺");
		param.put("updateTime", "2014-06-18");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	private static Object insertProjectVisit() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("projectId", "1");
		param.put("content", "客户还没有反馈信息");
		param.put("createTime", "2014-06-12");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	
	private static Object updateGroupContactData() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("groupId", "2");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;
	}
	
	private static Object updateUserGroupInfo() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("groupId", "1");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		param.put("name", "我的设备");
		return param;
	}
	
	
	
	private static Object updateSellInfo() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("sellId", "1");
		param.put("status", "2");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;
	}
	
	private static Object updateProjectInfo() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("projectId", "1");
		param.put("status", "2");
		param.put("totalPrice", "200.00");
		param.put("source", "张兴旺");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;
	}
	
	

	private static Object insertSellInfo() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("contactsId", "9");
		param.put("status", "1");
		param.put("totalPrice", "100.00");
		param.put("sellMethod", "张兴旺");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	
	
	
	
	
	
	
	private static Object insertContactsInfo() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("groupId", "6");
		param.put("name", "五月桃");
		param.put("address", "上海徐家汇");
		param.put("email", "zxw@minzh.com");
		param.put("company", "五月桃");
		param.put("phone", "15618045376");
		param.put("fax", "1");
		param.put("mobile", "15618045376");
		param.put("qq", "863577376");
		param.put("job", "JAVA工程师");
		param.put("business", "1");
		param.put("firstLetter", "W");
		param.put("userId", "7");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	
	
	
	
	private static Object updateContactsInfo() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("contactsId", "1");
		param.put("groupId", "1");
		param.put("name", "五月桃");
		param.put("address", "上海徐家汇");
		param.put("email", "zxw@minzh.com");
		param.put("company", "五月桃");
		param.put("phone", "15618045376");
		param.put("fax", "1");
		param.put("mobile", "15618045376");
		param.put("qq", "863577376");
		param.put("job", "JAVA工程师");
		param.put("business", "1");
		param.put("firstLetter", "W");
		param.put("userId", "7");
		param.put("account", "zhao");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		
		return param;
	}
	
	
	
	private static Object deleteGroupData() {
		HashMap<String, Object> param = new LinkedHashMap<String, Object>();
		param.put("groupId", "1");
		param.put("userId", "7");
		param.put("account", "zhao");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		
		return param;
	}
	
	
	private static Object findProductCategoryList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("companyId", "2");
		param.put("parentId", "0");
		return param;
	}
	
	
	private static Object findProductList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("productCategoryId", "2");
		return param;
	}
	
	
	private static Object findSellList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");
		return param;
	}
	
	
	private static Object findProjectList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");
		return param;
	}
	
	private static Object findProjectVisitList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("projectId", "1");
		return param;
	}
	
	private static Object findProjectContactsList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("contactsId", "1");	
		return param;
	}
	
	
	private static Object findSellVisitList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("sellId", "1");
		return param;
	}


	
	private static Object findSellProductList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("productId", "1");
		return param;
	}
	
	
	
	private static Object findsellProductList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("sellId", "1");
		return param;
	}
	
	
	
	
	private static Object findProductImgList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("productId", "2");
		param.put("fileType", "1");
		return param;
	}

	private static Object findUserGroupList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");	
		return param;
	}
	
	
	private static Object findSellContactsList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("contactsId", "1");	
		return param;
	}
	
	
	
	private static Object findBlessingsList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		return param;
	}
	
	
	private static Object findBlessingIndexsList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("blessingsTypeId", "1");	
		return param;
	}
	
	private static Object findGroupisDefaultList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "1");	
		param.put("isDefault", "T");	
		return param;
	}
	
	
	private static Object findMyContactsNum() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");	
		return param;
	}
	
	
	private static Object findMySubContactsList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");	
		return param;
	}
	
	
	private static Object findGroupList() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "7");	
		return param;
	}


	private static Object insertOrder() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("productId", "1");
		param.put("userId", "7");
		param.put("userName", "赵瑞可");
		param.put("productName", "产品名称1");
		param.put("orderCount", "10");
		param.put("price", "10.00");
		param.put("orderBeizhu", "红色的");
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;		
	}
	
	
	
	

}
