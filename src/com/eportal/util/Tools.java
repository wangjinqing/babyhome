package com.eportal.util;

import java.awt.image.BufferedImage;
import java.io.FileInputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringEscapeUtils;

import com.eportal.ORM.Admin;

/** ������ */
public class Tools {
	//�������ڸ�ʽ
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	//�����й��Ļ��Ҹ�ʽ
	private static NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.CHINA);	

	/** CKeditor���õķ�ҳ�ַ��� */
	private static String ck_separator="<div style=\"page-break-after: always;\"><span style=\"display: none;\">&nbsp;</span></div>";
	
	/** ȡ��ָ��ͼƬ�Ŀ����߶� */
	public static Map getPicWidthHeight(String filename){
		Map map = new HashMap();
		try {
			BufferedImage sourceImg = javax.imageio.ImageIO.read(new FileInputStream(filename));
			map.put("width", sourceImg.getWidth());
			map.put("height", sourceImg.getHeight());
			return map;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}	
	}
	
	/** �Ƿ�û��ָ���Ĳ���Ȩ�� */ 
	public static boolean isDisable(Admin admin, int option) {
		if(admin==null){
			return true;
		}else{
			if (admin.getPrivileges().substring(0, 1).equals("1"))
				return false;
			else {
				if (admin.getPrivileges().substring(option - 1, option).equals("1"))
					return false;
				else
					return true;
			}			
		}
	}
	
	/** �Ƿ�ӵ��ָ���Ĳ���Ȩ�� */ 
	public static boolean isEnable(Admin admin, int option) {
		if(admin==null){
			return false;
		}else{
			if (admin.getPrivileges().substring(0, 1).equals("1"))
				return true;
			else {
				if (admin.getPrivileges().substring(option - 1, option).equals("1"))
					return true;
				else
					return false;
			}			
		}
	}
	
	/** ȡ��������ļ��� */
	public synchronized static String getRndFilename(){
		return String.valueOf(System.currentTimeMillis());
	}
	
	/** ȡ��ָ���ļ����ļ���չ�� */
	public synchronized static String getFileExtName(String filename){
		int p = filename.indexOf(".");
		return filename.substring(p);
	}
	
	/** ��֤�ϴ��ļ��������Ƿ�Ϸ� fileType:1-ͼƬ 2-��Ƶ*/
	public synchronized static boolean isEnableUploadType(int fileType,String filename){
		String enableExtNames = null;
		int p = filename.indexOf(".");
		String fileExtName = filename.substring(p).toLowerCase();
		if (fileType==1){//ͼƬ�ļ�����
			enableExtNames = ".jpg,.gif,.png";
		}else if (fileType==2){//��Ƶ�ļ�����
			enableExtNames = ".flv";
		}
		if (enableExtNames!=null){
			if (enableExtNames.indexOf(fileExtName)!=-1)return true;
			else return false;			
		}else{
			return true;
		}

	}	
	
	/** HTML�����Escape������ */
	public static String  escape(String src){
		return StringEscapeUtils.escapeXml(src);
	}
	
	/** HTML�����UnEscape������ */
	public static String  unescape(String src){
		return StringEscapeUtils.unescapeHtml(StringEscapeUtils.unescapeXml(src));
	}
	
	/** Ϊ�Զ��ŷָ����ַ�����ÿ����Ԫ��������,��:aa,bb-->'aa','bb' */
	public static String formatString(String src){
		StringBuffer result = new StringBuffer();
		result.append("");
		if (src!=null){
			String[] tmp = src.split(",");
			result.append("'"+tmp[0]+"'");
			for(int i=1;i<tmp.length;i++){
				result.append(",'"+tmp[i]+"'");
			}
		}		
		return result.toString();
	}	
	
    /** ��ȡָ���ֽ������ַ���,��ȷ�����ֲ������ */
	public static String cutString(String text, int textMaxChar){   
        int size,index;   
        String result = null;  
        if(textMaxChar<=0){   
        	result= text;   
        }else{   
            for(size=0,index=0;index<text.length()&&size<textMaxChar;index++){   
                size += text.substring(index,index+1).getBytes().length;   
            }   
            result = text.substring(0,index);   
        }  
        return result;   
    }
	
    /** ��yyyy-MM-dd��ʽ��ʽ������ */
	public static String formatDate(Date date){   
		if (date==null){
			return "";
		}else{
			return df.format(date);
		}
    }
	
    /** ��δescape��HTML���ݽ��з�ҳ����,����String[] */
	public static String[] splitContent(String unEscapedHtml){ 
		if (unEscapedHtml==null){
			return null;
		}else{
			String content = unescape(unEscapedHtml);
			//����CKeditor�ķ�ҳ��ʽ��JAVA�л�ȡ���������滻�� 
			String patternStr = "(?is)<div style=\"page-break-after: always\">(.*?)<span style=\"display: none\">(.*?)</span></div>"; 
			Pattern p=Pattern.compile(patternStr); 
			Matcher m=p.matcher(content); 
			content=m.replaceAll(ck_separator); 
			//���з�ҳ����
			return content.split(ck_separator);
		}
	}
	
	/** ȡ�ø�ʽ������й������ַ��� */
	public static String formatCcurrency(double money){
		return currencyFormat.format(money);   		
	}
	
	public static void main(String[] args){
		System.out.println(escape("��˵��������ȸ��ŵ���ǲ������ƶ�����ϵͳ��׬Ǯ�Ļ�������ΪʲôҪ���ⷽ��Ͷ�ʴ�ʵ�Ǯ�أ�����һ����Ȥ�����⡣ �ѵ��ȸ�����Ϊ�������£����룬�󲿷���Ӫ�̺͵��Ź�˾������������һ�㡣��"));
	}
}
