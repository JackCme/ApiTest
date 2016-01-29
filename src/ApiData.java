import java.util.*;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;

//ApiData 싱글톤 클래스

public class ApiData {
	
	private static ApiData apiData = new ApiData();
	
	private final static String API_URL = "http://openapi.seongnam.go.kr:8081/openapi-data2/service/api1191/getOpenDataList?ServiceKey=9AEFA47AD4D657B7536318BF221738DB982202469F477E636C19E93F8A3CD";
	
	private int totalCount;
	
	private List<String> idx = new ArrayList<String>();
	private List<String> name = new ArrayList<String>();
	private List<String> phone = new ArrayList<String>();
	private List<String> addr = new ArrayList<String>();
	private List<String> category = new ArrayList<String>();
	
	private ApiData() {
		try {
			//공공데이터 API 파라미터 변수
			int numOfRows = 0;
			int pageNo = 1;
			
			//총 개수 파싱을 위해 0개 데이터 요청
			DocumentBuilder docBuilder = DocumentBuilderFactory.newInstance().newDocumentBuilder();
			Document document = docBuilder.parse(API_URL + "&numOfRows=" + numOfRows);
			XPath xpath = XPathFactory.newInstance().newXPath();
			
			String expression = "//*/totalCount";
			//API의 총 개수 데이터 파싱
			NodeList totalCountNode = (NodeList)xpath.compile(expression).evaluate(document, XPathConstants.NODESET);
			numOfRows = Integer.parseInt(totalCountNode.item(0).getTextContent());
			
			this.totalCount = numOfRows;
			//총 데이터 요청
			
			document = docBuilder.parse(API_URL + "&numOfRows=" + numOfRows);
			
			expression = "//*/item";
			
			NodeList nodeList = (NodeList)xpath.compile(expression).evaluate(document, XPathConstants.NODESET);
			
			for(int i = 0; i < nodeList.getLength(); i++ ) {
				Node node = nodeList.item(i);
				
				if(node.getNodeType() == Node.ELEMENT_NODE) {
					Element el = (Element) node;
					
					Element idx = (Element) el.getElementsByTagName("val001").item(0);
					Element name = (Element) el.getElementsByTagName("val002").item(0);
					Element phone = (Element) el.getElementsByTagName("val003").item(0);
					Element addr = (Element) el.getElementsByTagName("val004").item(0);
					Element category = (Element) el.getElementsByTagName("val005").item(0);
					
					if (idx != null) 
						this.idx.add(idx.getTextContent());
					else this.idx.add("없음");
					
					if (name != null) 
						this.name.add(name.getTextContent());
					else this.name.add("없음");
					
					if (phone != null)
						this.phone.add(phone.getTextContent());
					else this.phone.add("없음");
					
					if (addr != null && !addr.getTextContent().equals(""))
						this.addr.add(addr.getTextContent());
					else this.addr.add("없음");
					
					if(category != null && !category.getTextContent().equals(""))
						this.category.add(category.getTextContent());
					else this.category.add("없음");
				}
				
			}
		
		
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
