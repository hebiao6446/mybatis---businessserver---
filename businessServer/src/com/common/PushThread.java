package com.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class PushThread extends Thread {
    private String p12Path;
    private ArrayList<String> deviceTokens;
    private HashMap msg;
    
	public PushThread(String p12Path, ArrayList<String> deviceTokens, HashMap msg ){
		this.p12Path =  p12Path;
		this.deviceTokens = deviceTokens;
		this.msg = msg;
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
		super.run();
		PushUtils.push2More(p12Path, deviceTokens, msg,Integer.valueOf(msg.get("msgType").toString()));
		
	}

	
}
