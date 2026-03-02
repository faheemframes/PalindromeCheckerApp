@echo off
REM ================================
REM AUTOMATE UC2 → UC7 PALINDROME
REM ================================

SETLOCAL ENABLEDELAYEDEXPANSION

REM UC DESCRIPTIONS / CODE
SET UC2_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { System.out.println("madam is a palindrome"); } }
SET UC3_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { String s="racecar"; String rev=new StringBuilder(s).reverse().toString(); System.out.println(s + (s.equals(rev) ? " is a palindrome" : " is NOT a palindrome")); } }
SET UC4_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { String s="level"; char[] arr=s.toCharArray(); boolean pal=true; for(int i=0;i<arr.length/2;i++){ if(arr[i]!=arr[arr.length-1-i]){pal=false; break;} } System.out.println(s + (pal ? " is a palindrome" : " is NOT a palindrome")); } }
SET UC5_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { String s="deed"; java.util.Stack<Character> stack=new java.util.Stack<>(); for(char c:s.toCharArray()) stack.push(c); String rev=""; while(!stack.isEmpty()) rev+=stack.pop(); System.out.println(s + (s.equals(rev) ? " is a palindrome" : " is NOT a palindrome")); } }
SET UC6_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { String s="noon"; java.util.Stack<Character> stack=new java.util.Stack<>(); java.util.Queue<Character> queue=new java.util.LinkedList<>(); for(char c:s.toCharArray()){ stack.push(c); queue.add(c); } boolean pal=true; while(!stack.isEmpty()){ if(stack.pop()!=queue.remove()){ pal=false; break; } } System.out.println(s + (pal ? " is a palindrome" : " is NOT a palindrome")); } }
SET UC7_CODE=public class PalindromeCheckerApp { public static void main(String[] args) { String s="civic"; java.util.Deque<Character> deque=new java.util.ArrayDeque<>(); for(char c:s.toCharArray()) deque.add(c); boolean pal=true; while(deque.size()>1){ if(deque.removeFirst()!=deque.removeLast()){ pal=false; break; } } System.out.println(s + (pal ? " is a palindrome" : " is NOT a palindrome")); } }

REM ARRAY OF CODES
SET CODES=UC2_CODE UC3_CODE UC4_CODE UC5_CODE UC6_CODE UC7_CODE

REM LOOP THROUGH UCs
SET /A UC=2
FOR %%X IN (%CODES%) DO (
    REM OVERWRITE JAVA FILE
    ECHO Writing UC!UC! code...
    ECHO !%%X! > src\PalindromeCheckerApp.java

    REM GIT WORKFLOW
    git checkout develop
    git checkout -b feature/UC!UC!
    git add .
    git commit -m "UC!UC!: Add module code"
    git push origin feature/UC!UC!
    git checkout develop
    git pull
    git merge feature/UC!UC!
    git push

    SET /A UC=!UC!+1
)

echo ===============================
echo UC2 → UC7 Completed ✅
pause