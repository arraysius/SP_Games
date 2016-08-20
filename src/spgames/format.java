package spgames;

import java.util.ArrayList;

public class format {

	// New line to <br>
	public static String nl2br(String text) {
		String newText = text.trim();
		newText = newText.replaceAll("\n", "<br>");
		return newText;
	}

	// Check if string contains letter and number
	public static boolean hasLetterHasDigit(String s) {
		boolean hasLetter = false;
		boolean hasDigit = false;

		char[] characters = s.toCharArray();

		for (char c : characters) {
			if (Character.isLetter(c)) {
				hasLetter = true;
				break;
			}
		}

		for (char c : characters) {
			if (Character.isDigit(c)) {
				hasDigit = true;
				break;
			}
		}

		return hasLetter && hasDigit;
	}
	
	public static String stringJoin(ArrayList<String> strings) {
		String returnString = "";
		for (int i = 0; i < strings.size(); i++) {
			returnString += strings.get(i);
			if (i < strings.size() - 1) {
				returnString += ", ";
			}
		}
		return returnString;
	}

}
