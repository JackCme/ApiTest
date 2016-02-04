

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathFactory;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 * Servlet implementation class ApiData
 */
@WebServlet("/")
public class ApiDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ApiDataServlet() {
        super();
        // TODO Auto-generated constructor stub
        
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.setCharacterEncoding("utf-8");
		response.setContentType("utf-8");
		
		ApiData apiData = ApiData.getInstance();

		int totalCount = apiData.getTotalCount();
		
		List<String> addr = apiData.getAddr();
		List<String> idx = apiData.getIdx();
		List<String> name = apiData.getName();
		List<String> cat = apiData.getCategory();
		
		Set<String> gu = new LinkedHashSet<String>();
		Set<String> dong = new LinkedHashSet<String>();
		Set<String> category = new LinkedHashSet<String>();
		
		for(String a : addr) {
			String[] splitStr = a.split(" ");
			
			gu.add(splitStr[0]);
			dong.add(splitStr[1]);
		}
		
		for(String c : cat) {
			category.add(c);
		}

		request.setAttribute("totalCount", totalCount);
		request.setAttribute("idx", idx);
		request.setAttribute("name", name);
		request.setAttribute("addr", addr);
		request.setAttribute("category", category);
		request.setAttribute("gu", gu);
		request.setAttribute("dong", dong);
		
		
		//Geocode api 
		/*
		String clientId = "Fb6yUt0Z8Dy9KXt8oNtc";
		String clientSecret = "uNk8ZBCBp_";
		String encoded = URLEncoder.encode("성남시 분당구 야탑동 342-1", "UTF-8");
		String url = "https://openapi.naver.com/v1/map/geocode?query=" + encoded;
		 
		 HttpClient client = HttpClientBuilder.create().build();
		 HttpGet req = new HttpGet(url);
		 
		 req.addHeader("X-Naver-Client-Id", clientId);
		 req.addHeader("X-Naver-Client-Secret", clientSecret);
		 HttpResponse res = client.execute(req);
		 
		 HttpEntity res_entity = res.getEntity();
		 String res_string = EntityUtils.toString(res_entity);
		 
		 request.setAttribute("res_string", res_string);
		 
		*/
		RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
		requestDispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}


}
