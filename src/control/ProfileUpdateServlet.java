package control;

import model.MemberManager;
import model.User;
import spgames.format;
import spgames.hasher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.regex.Pattern;

/**
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/ProfileUpdateServlet")
public class ProfileUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProfileUpdateServlet() {
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

			// Get user details and validation
			String email = request.getParameter("email").trim();

			String name = request.getParameter("name");
			if (!(name.matches("^[a-zA-Z ]+$"))) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			name = name.trim();
			
			String contactNum = request.getParameter("phone");
			if (!(contactNum.matches("^[689][0-9]{7}$"))) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			int phoneNum = Integer.parseInt(contactNum);
			
			String address1 = request.getParameter("address1");
			if (!(Pattern.compile("[a-zA-Z ]+").matcher(address1.trim()).find() && Pattern.compile("[0-9]*").matcher(address1.trim()).find()) || Pattern.compile("[<>\\\\]+").matcher(address1.trim()).find()) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			address1 = address1.trim();
			
			String address2 = request.getParameter("address2");
			if (address2 == null || !(Pattern.compile("[a-zA-Z ]*").matcher(address2.trim()).find() && Pattern.compile("[0-9]*").matcher(address2.trim()).find()) || Pattern.compile("[<>\\\\]+").matcher(address2.trim()).find()) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			address2 = address2.trim();
			
			String pCode = request.getParameter("postalcode");
			if (pCode == null || !(pCode.matches("^[0-9]{6}$"))) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			int postalCode = Integer.parseInt(pCode);
			
			String password = request.getParameter("password").trim();
			if (password == null || password.contains(" ") || password.length() < 8 || password.length() > 16 || !format.hasLetterHasDigit(password)) {
				response.sendRedirect("manageProfile.jsp?status=fail");
				return;
			}
			
			String hashedPassword = hasher.hash256(email + hasher.hash256(password));
			
			// Select member
			MemberManager memberManager = new MemberManager(request);
			User dbUser = memberManager.selectMember(email);

			// Get User object from session
			HttpSession session = request.getSession();
			User sessionUser = (User) session.getAttribute("user");
			
			//Check user
			if (hashedPassword.equals(dbUser.getHashedPassword()) && hashedPassword.equals(sessionUser.getHashedPassword())){
				User newUser = new User(dbUser.getEmail(), name, dbUser.getHashedPassword(), dbUser.getSecretKey(), dbUser.getIsAdmin(), phoneNum, address1, address2, postalCode);
				memberManager.updateMember(newUser);

				session.setAttribute("user", newUser);
			}else {
				response.sendRedirect("manageProfile.jsp?status=fail");
			}

			//Redirect
			response.sendRedirect("profile.jsp");

	}

}
