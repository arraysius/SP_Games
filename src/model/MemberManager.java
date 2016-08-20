package model;

import model.User;
import spgames.dbConnection;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberManager {

	private Connection conn;

	public MemberManager() {
		super();
	}

	public MemberManager(HttpServletRequest request) {
		try {
			dbConnection db = new dbConnection(request);
			conn = db.getConnection();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public User selectAccount(String email) {
		try {
			String selectAccountSQL = "SELECT Name, Password AS HashedPassword, Secret_Key, isAdmin FROM account WHERE account.Email = ?";
			PreparedStatement selectAccountPstmt = conn.prepareStatement(selectAccountSQL);
			selectAccountPstmt.setString(1, email);
			ResultSet selectAccountRs = selectAccountPstmt.executeQuery();
			if (selectAccountRs.next()) {
				User user = new User();

				String name = selectAccountRs.getString("Name");
				String hashedPassword = selectAccountRs.getString("HashedPassword");
				String secretKey = selectAccountRs.getString("Secret_Key");
				String isAdmin = selectAccountRs.getString("isAdmin");

				user.setEmail(email);
				user.setName(name);
				user.setHashedPassword(hashedPassword);
				user.setSecretKey(secretKey);
				user.setIsAdmin(isAdmin);

				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public User selectMember(String memberEmail) {
		try {
			String selectMemberSQL = "SELECT Name, Password AS HashedPassword, Secret_Key, isAdmin, Phone_Number, Address1, Address2, Postal_Code FROM account, member WHERE account.Email = member.Email AND account.Email = ?";
			PreparedStatement selectMemberPstmt = conn.prepareStatement(selectMemberSQL);
			selectMemberPstmt.setString(1, memberEmail);
			ResultSet selectMemberRs = selectMemberPstmt.executeQuery();
			if (selectMemberRs.next()) {
				User user = new User();

				String name = selectMemberRs.getString("Name");
				String hashedPassword = selectMemberRs.getString("HashedPassword");
				String secretKey = selectMemberRs.getString("Secret_Key");
				String isAdmin = selectMemberRs.getString("isAdmin");
				int phoneNumber = selectMemberRs.getInt("Phone_Number");
				String address1 = selectMemberRs.getString("Address1");
				String address2 = selectMemberRs.getString("Address2");
				int postalCode = selectMemberRs.getInt("Postal_Code");

				user.setEmail(memberEmail);
				user.setName(name);
				user.setHashedPassword(hashedPassword);
				user.setSecretKey(secretKey);
				user.setIsAdmin(isAdmin);
				user.setPhoneNumber(phoneNumber);
				user.setAddress1(address1);
				user.setAddress2(address2);
				user.setPostalCode(postalCode);

				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return null;
	}

	public boolean insertMember(User user) {
		try {
			// Insert into Account
			String addAccountSQl = "INSERT INTO account VALUES (?, ?, ?, ?, ?)";
			PreparedStatement addAccountPstmt = conn.prepareStatement(addAccountSQl);
			addAccountPstmt.setString(1, user.getEmail());
			addAccountPstmt.setString(2, user.getName());
			addAccountPstmt.setString(3, user.getHashedPassword());
			addAccountPstmt.setString(4, user.getSecretKey());
			addAccountPstmt.setString(5, user.getIsAdmin());
			addAccountPstmt.executeUpdate();

			// Insert into Member table
			String addMemberSQl = "INSERT INTO member VALUES (?, ?, ?, ?, ?)";
			PreparedStatement addMemberPstmt = conn.prepareStatement(addMemberSQl);
			addMemberPstmt.setString(1, user.getEmail());
			addMemberPstmt.setInt(2, user.getPhoneNumber());
			addMemberPstmt.setString(3, user.getAddress1());
			addMemberPstmt.setString(4, user.getAddress2());
			addMemberPstmt.setInt(5, user.getPostalCode());
			addMemberPstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public void updateAccount(User user) {
		try {
			// Update Account Info
			String updateMemberAccountSQL = "UPDATE account SET Password = ?, Secret_Key = ? WHERE Email = ?";
			PreparedStatement updateMemberAccountPstmt = conn.prepareStatement(updateMemberAccountSQL);
			updateMemberAccountPstmt.setString(1, user.getHashedPassword());
			updateMemberAccountPstmt.setString(2, user.getSecretKey());
			updateMemberAccountPstmt.setString(3, user.getEmail());
			updateMemberAccountPstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public boolean updateMember(User user) {
		try {
			// Update Member info
			String updateMemberInfoSQL = "UPDATE member SET Phone_Number = ?, Address1 = ?, Address2 = ?, Postal_Code = ?";
			PreparedStatement updateMemberInfoPstmt = conn.prepareStatement(updateMemberInfoSQL);
			updateMemberInfoPstmt.setInt(1, user.getPhoneNumber());
			updateMemberInfoPstmt.setString(2, user.getAddress1());
			updateMemberInfoPstmt.setString(3, user.getAddress2());
			updateMemberInfoPstmt.setInt(5, user.getPostalCode());
			updateMemberInfoPstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public boolean deleteMember(User user) {
		try {
			String deleteMemberSQL = "DELETE FROM account WHERE Email = ?";
			PreparedStatement deleteMemberPstmt = conn.prepareStatement(deleteMemberSQL);
			deleteMemberPstmt.setString(1, user.getEmail());
			deleteMemberPstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

}
