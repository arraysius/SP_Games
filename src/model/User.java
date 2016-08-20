package model;

public class User {

	// Account details
	private String email;
	private String name;
	private String hashedPassword;
	private String secretKey;
	private String isAdmin;

	// Member details
	private int phoneNumber;
	private String address1;
	private String address2;
	private int postalCode;

	public User() {
		super();
	}

	public User(String email, String name, String hashedPassword, String secretKey, String isAdmin) {
		super();
		this.email = email;
		this.name = name;
		this.hashedPassword = hashedPassword;
		this.secretKey = secretKey;
		this.isAdmin = isAdmin;
	}

	public User(String email, String name, String hashedPassword, String secretKey, String isAdmin, int phoneNumber, String address1, String address2, int postalCode) {
		super();
		this.email = email;
		this.name = name;
		this.hashedPassword = hashedPassword;
		this.secretKey = secretKey;
		this.isAdmin = isAdmin;
		this.phoneNumber = phoneNumber;
		this.address1 = address1;
		this.address2 = address2;
		this.postalCode = postalCode;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHashedPassword() {
		return hashedPassword;
	}

	public void setHashedPassword(String hashedPassword) {
		this.hashedPassword = hashedPassword;
	}

	public String getSecretKey() {
		return secretKey;
	}

	public void setSecretKey(String secretKey) {
		this.secretKey = secretKey;
	}

	public String getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(String isAdmin) {
		this.isAdmin = isAdmin;
	}

	public int getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(int phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public String getAddress1() {
		return address1;
	}

	public void setAddress1(String address1) {
		this.address1 = address1;
	}

	public String getAddress2() {
		return address2;
	}

	public void setAddress2(String address2) {
		this.address2 = address2;
	}

	public int getPostalCode() {
		return postalCode;
	}

	public void setPostalCode(int postalCode) {
		this.postalCode = postalCode;
	}
}