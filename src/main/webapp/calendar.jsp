<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.tjoeun.myCalendar.MyCalendar"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>만년 달력</title>
<link rel="stylesheet" href="calendar.css"/>
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.14.0/css/all.css" integrity="sha384-HzLeBuhoNPvSl5KYnjx0BT+WB0QEEqLprO+NBkkk5gbc67FTaL7XIGa2w1L0Xbgc" crossorigin="anonymous">
</head>
<body>

<%

	Calendar calendar = Calendar.getInstance();
	int year = calendar.get(Calendar.YEAR);
	int month = calendar.get(Calendar.MONTH) + 1;

	try {
		year = Integer.parseInt(request.getParameter("year"));
		month = Integer.parseInt(request.getParameter("month"));
		
		if (month >= 13) {
			year++;
			month = 1;
		} else if (month <= 0) {
			year--;
			month = 12;
		}		
		
	} catch (NumberFormatException e) {
		
	}
%>

	<table width="700" align="center" cellpadding="5" cellspacing="0">
		<tr>
			<th>
				<button class="button button1" type="button" 					
				onclick="location.href='?year=<%=year%>&month=<%=month - 1%>'">	&laquo</button>
			</th>
			<th id="title" colspan="5">
				<%=year%>.<%=month%>
			</th>
			<th>
			<button class="button button1" type="button" 
					onclick="location.href='?year=<%=year%>&month=<%=month + 1%>'">&raquo</button>
			</th>
		</tr>
		<tr>
			<td id="sunday">SUN</td>
			<td class="etcday">MON</td>
			<td class="etcday">TUE</td>
			<td class="etcday">WED</td>
			<td class="etcday">THU</td>
			<td class="etcday">FRI</td>
			<td id="saturday">SAT</td>
		</tr>
		<tr>
<%
		int week = MyCalendar.weekDay(year, month, 1);

		int start = 0;
		if (month == 1) {
			start = 31 - week;
		} else {
			start = MyCalendar.lastDay(year, month - 1) - week; 
		}

		for (int i=0; i<week; i++) {
			if (i == 0) {
				out.println("<td class='beforesun'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
			} else {
				out.println("<td class='before'>" + (month == 1 ? 12 : month - 1) + "/" + ++start + "</td>");
			}
		}

		for (int i=1; i<=MyCalendar.lastDay(year, month); i++) {

			boolean flag0301 = false;
			int subHoliday0301 = 0;
			if (MyCalendar.weekDay(year, 3, 1) == 6) {
				flag0301 = true;
				subHoliday0301 = 3;
			} else if (MyCalendar.weekDay(year, 3, 1) == 0) {
				flag0301 = true;
				subHoliday0301 = 2;
			}
			boolean flag0505 = false;
			int subHoliday0505 = 0;
			if (MyCalendar.weekDay(year, 5, 5) == 6) {
				flag0505 = true;
				subHoliday0505 = 7;
			} else if (MyCalendar.weekDay(year, 5, 5) == 0) {
				flag0505 = true;
				subHoliday0505 = 6;
			}
			boolean flag0815 = false;
			int subHoliday0815 = 0;
			if (MyCalendar.weekDay(year, 8, 15) == 6) {
				flag0815 = true;
				subHoliday0815 = 17;
			} else if (MyCalendar.weekDay(year, 8, 15) == 0) {
				flag0815 = true;
				subHoliday0815 = 16;
			}
			boolean flag1003 = false;
			int subHoliday1003 = 0;
			if (MyCalendar.weekDay(year, 10, 3) == 6) {
				flag1003 = true;
				subHoliday1003 = 5;
			} else if (MyCalendar.weekDay(year, 10, 3) == 0) {
				flag1003 = true;
				subHoliday1003 = 4;
			}
			boolean flag1009 = false;
			int subHoliday1009 = 0;
			if (MyCalendar.weekDay(year, 10, 9) == 6) {
				flag1009 = true;
				subHoliday1009 = 11;
			} else if (MyCalendar.weekDay(year, 10, 9) == 0) {
				flag1009 = true;
				subHoliday1009 = 10;
			}
			
			if (month == 1 && i == 1) {
				out.println("<td class='holiday'>" + i + "<br/><span>신정</span></td>");
			} else if (month == 3 && i == 1) {
				out.println("<td class='holiday'>" + i + "<br/><span>삼일절</span></td>");
			} else if (month == 5 && i == 1) {
				out.println("<td class='holiday'>" + i + "<br/><span>근로자의날</span></td>");
			} else if (month == 5 && i == 5) {
				out.println("<td class='holiday'>" + i + "<br/><span>어린이날</span></td>");
			} else if (month == 6 && i == 6) {
				out.println("<td class='holiday'>" + i + "<br/><span>현충일</span></td>");
			} else if (month == 8 && i == 15) {
				out.println("<td class='holiday'>" + i + "<br/><span>광복절</span></td>");
			} else if (month == 10 && i == 3) {
				out.println("<td class='holiday'>" + i + "<br/><span>개천절</span></td>");
			} else if (month == 10 && i == 9) {
				out.println("<td class='holiday'>" + i + "<br/><span>한글날</span></td>");
			} else if (month == 12 && i == 25) {
				out.println("<td class='holiday'>" + i + "<br/><span>크리스마스</span></td>");
			} else if (flag0301 && month == 3 && i == subHoliday0301) {
				out.println("<td class='holiday'>" + i + "<br/><span>대체공휴일</span></td>");
			} else if (flag0505 && month == 5 && i == subHoliday0505) {
				out.println("<td class='holiday'>" + i + "<br/><span>대체공휴일</span></td>");
			} else if (flag0815 && month == 8 && i == subHoliday0815) {
				out.println("<td class='holiday'>" + i + "<br/><span>대체공휴일</span></td>");
			} else if (flag1003 && month == 10 && i == subHoliday1003) {
				out.println("<td class='holiday'>" + i + "<br/><span>대체공휴일</span></td>");
			} else if (flag1009 && month == 10 && i == subHoliday1009) {
				out.println("<td class='holiday'>" + i + "<br/><span>대체공휴일</span></td>");
			}
			else {
				switch (MyCalendar.weekDay(year, month, i)) {
					case 0:
						out.println("<td class='sun'>" + i + "</td>");
						break;
					case 6:
						out.println("<td class='sat'>" + i + "</td>");
						break;
					default:
						out.println("<td class='etc'>" + i + "</td>");
						break;
				}
			}
			
			if (MyCalendar.weekDay(year, month, i) == 6 && i != MyCalendar.lastDay(year, month)) {
				out.println("</tr><tr>");
			}
		}

		if (month == 12) {
			week = MyCalendar.weekDay(year + 1, 1, 1); 
		} else {
			week = MyCalendar.weekDay(year, month + 1, 1); 
		}

		if (week != 0) {
			start = 1;
			for (int i=week; i<=6; i++) {
				if (i == 6) {
					out.println("<td class='aftersat'>" + (month == 12 ? 1 : month + 1) + "/" + start++ + "</td>");	
				} else {
					out.println("<td class='after'>" + (month == 12 ? 1 : month + 1) + "/" + start++ + "</td>");
				}
			}
		}
%>
		</tr>
		<tr>
			<td colspan="7">
				
				<form action="?" method="post">
					<select class="select" name="year">
<%
		for (int i=1900; i<=2100; i++) {
			if (i == calendar.get(Calendar.YEAR)) {
				out.println("<option selected='selected'>" + i + "</option>");
			} else {
				out.println("<option>" + i + "</option>");
			}
		}
%>
					</select>&nbsp;year&nbsp;&nbsp;&nbsp;
					<select class="select" name="month">
<%
		for (int i=1; i<=12; i++) {
			if (i == calendar.get(Calendar.MONTH) + 1) {
				out.println("<option selected='selected'>" + i + "</option>");
			} else {
				out.println("<option>" + i + "</option>");
			}
		}
%>
					</select>&nbsp;month&nbsp;&nbsp;&nbsp;
					<button class="select" type="submit">select</button>
				</form>
				
			</td>
		</tr>	
	</table>

</body>
</html>











