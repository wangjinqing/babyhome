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

/** 工具类 */
public class Tools {
	//创建日期格式
	private static SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
	//创建中国的货币格式
	private static NumberFormat currencyFormat = NumberFormat.getCurrencyInstance(Locale.CHINA);	

	/** CKeditor内置的分页字符串 */
	private static String ck_separator="<div style=\"page-break-after: always;\"><span style=\"display: none;\">&nbsp;</span></div>";
	
	/** 取得指定图片的宽度与高度 */
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
	
	/** 是否没有指定的操作权限 */ 
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
	
	/** 是否拥有指定的操作权限 */ 
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
	
	/** 取得随机主文件名 */
	public synchronized static String getRndFilename(){
		return String.valueOf(System.currentTimeMillis());
	}
	
	/** 取得指定文件的文件扩展名 */
	public synchronized static String getFileExtName(String filename){
		int p = filename.indexOf(".");
		return filename.substring(p);
	}
	
	/** 验证上传文件的类型是否合法 fileType:1-图片 2-视频*/
	public synchronized static boolean isEnableUploadType(int fileType,String filename){
		String enableExtNames = null;
		int p = filename.indexOf(".");
		String fileExtName = filename.substring(p).toLowerCase();
		if (fileType==1){//图片文件类型
			enableExtNames = ".jpg,.gif,.png";
		}else if (fileType==2){//视频文件类型
			enableExtNames = ".flv";
		}
		if (enableExtNames!=null){
			if (enableExtNames.indexOf(fileExtName)!=-1)return true;
			else return false;			
		}else{
			return true;
		}

	}	
	
	/** HTML代码的Escape处理方法 */
	public static String  escape(String src){
		return StringEscapeUtils.escapeXml(src);
	}
	
	/** HTML代码的UnEscape处理方法 */
	public static String  unescape(String src){
		return StringEscapeUtils.unescapeHtml(StringEscapeUtils.unescapeXml(src));
	}
	
	/** 为以逗号分隔的字符串的每个单元加入引号,如:aa,bb-->'aa','bb' */
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
	
    /** 截取指定字节数的字符串,且确保汉字不被拆分 */
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
	
    /** 按yyyy-MM-dd格式格式化日期 */
	public static String formatDate(Date date){   
		if (date==null){
			return "";
		}else{
			return df.format(date);
		}
    }
	
    /** 对未escape的HTML内容进行分页处理,返回String[] */
	public static String[] splitContent(String unEscapedHtml){ 
		if (unEscapedHtml==null){
			return null;
		}else{
			String content = unescape(unEscapedHtml);
			//由于CKeditor的分页格式在JAVA中获取不到，先替换。 
			String patternStr = "(?is)<div style=\"page-break-after: always\">(.*?)<span style=\"display: none\">(.*?)</span></div>"; 
			Pattern p=Pattern.compile(patternStr); 
			Matcher m=p.matcher(content); 
			content=m.replaceAll(ck_separator); 
			//进行分页处理
			return content.split(ck_separator);
		}
	}
	
	/** 取得格式化后的中国货币字符串 */
	public static String formatCcurrency(double money){
		return currencyFormat.format(money);   		
	}
	
	public static void main(String[] args){
		System.out.println(escape("他说：“如果谷歌和诺基亚不能在移动操作系统上赚钱的话，它们为什么要在这方面投资大笔的钱呢，这是一个有趣的问题。 难道谷歌真是为了做善事？我想，大部分运营商和电信公司都不会相信这一点。”"));
	}
}
