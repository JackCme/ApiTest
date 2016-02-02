import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;

import com.mysql.jdbc.PreparedStatement;

import org.w3c.dom.Node;

//ApiData ΩÃ±€≈Ê ≈¨∑°Ω∫

public class ApiData {
	
	private static ApiData apiData = new ApiData();
	
	private final static String API_URL = "http://openapi.seongnam.go.kr:8081/openapi-data2/service/api1191/getOpenDataList?ServiceKey=9AEFA47AD4D657B7536318BF221738DB982202469F477E636C19E93F8A3CD";
	
	private int totalCount;
	
	private List<String> idx = new ArrayList<String>();
	private List<String> name = new ArrayList<String>();
	private List<String> phone = new ArrayList<String>();
	private List<String> addr = new ArrayList<String>();
	private List<String> category = new ArrayList<String>();
	
	private Connection conn = null;
	private Statement stat = null;
	private ResultSet rs = null;
	private PreparedStatement pstmt = null;
	
	private ApiData() {
		
		String db_url="jdbc:mysql://dbinstance.cmpfvsw5d4kz.ap-northeast-1.rds.amazonaws.com:3306/api";
		String db_user="admin";
		String db_pwd="dbadministrator";
		String query;
		
		try {
			
			Class.forName("com.mysql.jdbc.Driver");
			conn=DriverManager.getConnection(db_url,db_user,db_pwd);
			if(conn==null)
				throw new Exception("DB ø¨∞· Error");
			
			stat = conn.createStatement();
			query = "select count(*) as total from apiTable";
			rs = stat.executeQuery(query);
			if(rs.next()) {
				this.totalCount = rs.getInt("total");
			}
			
			
			query = "select * from apiTable";
			pstmt = (PreparedStatement) conn.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				idx.add(rs.getString("val001"));
				name.add(rs.getString("val002"));
				phone.add(rs.getString("val003"));
				addr.add(rs.getString("val004"));
				category.add(rs.getString("val005"));
			}
			
			rs.close();
			pstmt.close();
			stat.close();
			conn.close();
		
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getTotalCount() {
		return this.totalCount;
	}
	
	public List<String> getIdx() {
		return this.idx;
	}
	
	public List<String> getName() {
		return this.name;
	}
	
	public List<String> getPhone() {
		return this.phone;
	}
	
	public List<String> getAddr() {
		return this.addr;
	}
	
	public List<String> getCategory() {
		return this.category;
	}
	
	public static ApiData getInstance() {
		return apiData;
		
	}
}
