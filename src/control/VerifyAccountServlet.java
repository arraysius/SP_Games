package control;

import model.MemberManager;
import model.User;
import spgames.hasher;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/VerifyAccountServlet")
public class VerifyAccountServlet extends HttpServlet {
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		if (email == null || password == null) {
			response.sendRedirect("login.jsp?login=expired");
		} else {
			email = email.toLowerCase();
			String passwordHash = hasher.hash256(email + hasher.hash256(request.getParameter("password")));

			// Get User object of user logging in
			MemberManager memberManager = new MemberManager(request);
			User user = memberManager.selectAccount(email);
			if (user == null || !user.getHashedPassword().equals(passwordHash)) {
				response.sendRedirect("login.jsp?login=fail");
				return;
			} else {
				if (user.getIsAdmin().equals("N")) {
					user = memberManager.selectMember(email);
				}

				// Set User object in session
				HttpSession session = request.getSession();
				session.invalidate();
				session = request.getSession();
				session.setAttribute("user", user);

				// Redirect
				if (user.getIsAdmin().equals("Y")) {
					response.sendRedirect("controlpanel.jsp");
				} else {
					response.sendRedirect("ProfileServlet");
				}
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.sendRedirect("login.jsp");
	}
}
