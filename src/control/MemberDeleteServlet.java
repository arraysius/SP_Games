package control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;

import model.MemberManager;
import model.User;
import spgames.dbConnection;
import spgames.hasher;

/**
 * Servlet implementation class MemberDeleteServlet
 */
@WebServlet("/MemberDeleteServlet")
public class MemberDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		try {
		
		// Get user details
		String email = request.getParameter("email").trim();
		String password = request.getParameter("password").trim();
		String hashedPassword = hasher.hash256(email + hasher.hash256(password));
		
		// Select member
		MemberManager memberManager = new MemberManager(request);
		User dbUser = (User) memberManager.selectMember(email);
		
		// Create sessionConnection to dbConnection
		dbConnection sessionDB = new dbConnection(request);
		Connection sessionConn = sessionDB.getConnection();

		// Get User object from session
		HttpSession session = request.getSession();
		User sessionUser = (User) session.getAttribute("user");
		
		//Check user
		if (hashedPassword.equals(dbUser.getHashedPassword()) && hashedPassword.equals(sessionUser.getHashedPassword())){
			memberManager.deleteMember(dbUser);
			session.invalidate();
		}else {
			response.sendRedirect("memberDelete.jsp?delete=fail");
		}
		
		//Redirect
		response.sendRedirect("index.jsp");}
		catch (Exception e) {
			e.printStackTrace();
		}
	}

}
