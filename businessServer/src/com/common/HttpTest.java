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

public class HttpTest {
	private static final String user = "http://127.0.0.1:8080/businessInterface/user/";
	private static final String sign = "http://127.0.0.1:8080/businessInterface/sign/";
	public static void main(String[] args) throws Exception {

		String paramStr = JSONObject.fromObject(userLogin()).toString();
		String key = Commonparam.Md5String(paramStr);
		String url = "http://127.0.0.1:8099/businessInterface/user/userLogin.action";
		String post = "data=" + paramStr + "&key=" + key;
		System.out.println(paramStr); 
		System.out.println(key);
		System.out.println(url + "?" + post);
		String data = HttpGetMsg.postUrl(url, post);
		System.out.println(data);
	}
	private static Object userLogin() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("account", "zrk");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;
	}
	private static Object findHistorySign() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "111");
		param.put("fontTime", "2012-12-12");
		param.put("backTime", "2014-10-12");
		param.put("account", "xiaole");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		param.put("page", 2);
		param.put("size", 20);
		return param;
	}
	private static Object signContent() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "111");
		param.put("account", "xiaole");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		param.put("content", "上海市徐汇区天钥桥路1178号,上海市徐汇区天钥桥路1178号");
		return param;		
	}
	private static Object updateSign() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "1");
		param.put("account", "zhao");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		param.put("time", "10:23:34");
		param.put("phone", "15618045376");
		param.put("lat", "123.00000000");
		param.put("lng", "123.00000000");		
		param.put("address", "上海市徐汇区天钥桥路1178号");		
		param.put("type", "D");		
		return param;
	}
	
	private static Object findTodaySign() {
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("userId", "1");
		param.put("account", "zhao");
		param.put("pwd", "E10ADC3949BA59ABBE56E057F20F883E");
		return param;
	}
	

}
