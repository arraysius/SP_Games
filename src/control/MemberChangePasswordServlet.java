package control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.MemberManager;
import model.User;
import spgames.hasher;

/**
 * Servlet implementation class MemberChangePasswordServlet
 */
@WebServlet("/MemberChangePasswordServlet")
public class MemberChangePasswordServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberChangePasswordServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("profile.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// Get user details
			String email = request.getParameter("email");
			String currentPassword = request.getParameter("currentPassword");
			String hashedCurrentPassword = hasher.hash256(email + hasher.hash256(currentPassword));
			String newPassword = request.getParameter("newPassword");
			String hashedNewPassword = hasher.hash256(email + hasher.hash256(newPassword));
			
			// Select member
			MemberManager memberManager = new MemberManager(request);
			User dbUser = memberManager.selectMember(email);

			// Get User object from session
			HttpSession session = request.getSession();
			User sessionUser = (User) session.getAttribute("user");
			
			// Check user
			if (hashedCurrentPassword.equals(dbUser.getHashedPassword()) && hashedCurrentPassword.equals(sessionUser.getHashedPassword())){
				User newUser = dbUser;
				newUser.setHashedPassword(hashedNewPassword);
				memberManager.updateAccount(newUser);
				session.invalidate();
				response.sendRedirect("login.jsp");
			}else {
				response.sendRedirect("memberChangePassword.jsp?status=fail");
				return;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
