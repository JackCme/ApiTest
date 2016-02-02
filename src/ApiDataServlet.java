

import java.io.IOException;
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
		
		Set<String> gu = new LinkedHashSet<String>();
		Set<String> dong = new LinkedHashSet<String>();
		
		String query_gu = request.getParameter("gu");
		String query_dong = request.getParameter("dong");
		
		for(String a : addr) {
			String[] splitStr = a.split(" ");
			
			gu.add(splitStr[0]);
			dong.add(splitStr[1]);
		}

		request.setAttribute("totalCount", totalCount);
		request.setAttribute("idx", idx);
		request.setAttribute("name", name);
		request.setAttribute("addr", addr);
		request.setAttribute("gu", gu);
		request.setAttribute("dong", dong);


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
