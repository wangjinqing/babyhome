import java.io.UnsupportedEncodingException;


public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {
			String t=java.net.URLEncoder.encode("ÖÐ¹ú","UTF-8");
			System.out.println(t);
			String u=java.net.URLDecoder.decode(t,"UTF-8");
			System.out.println(u);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
