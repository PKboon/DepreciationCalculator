<%-- 
    Document   : UnitsOfProductTable
    Created on : Nov 2, 2019, 3:46:24 PM
    Author     : Pikulkaew Boonpeng
--%>

<!DOCTYPE html>
<html>
    <head>
        <title>Depreciation Table by Pikulkaew Boonpeng</title>
    </head>
    <body bgcolor="LavenderBlush">
        <%
            try {
                double c = Double.parseDouble(request.getParameter("cost"));
                double s = Double.parseDouble(request.getParameter("scrap"));
                double a = 0; //accum. depreciation
                double t = Double.parseDouble(request.getParameter("totalUnits"));
                double y = 0; //exceed year
                String unitArr[] = request.getParameterValues("unit");
                double sumUnits = 0;

                for (int i = 0; i < unitArr.length; i++) {
                    sumUnits += Double.parseDouble(unitArr[i]);
                    if (sumUnits >= t) {
                        y = i;
                        break;
                    }
                }
                if (sumUnits != t) {
        %>
        <h1 align="center" style="color: red">Oops! Something went wrong.</h1>
        <h3 align="center" style="color: blueviolet">The total of entered units is <%=String.format("%.2f", sumUnits)%>, it should be <%=String.format("%.2f", t)%></h3>
        <%
            if (sumUnits > t && y <= unitArr.length) {
        %>
        <h3 align="center" style="color: blueviolet">It exceeds at year <%=String.format("%.0f", y + 1)%></h3>
        <%
            }
        } else if (sumUnits == t && y < unitArr.length - 1) {
        %>
        <h1 align="center" style="color: red">Oops! Something went wrong.</h1>
        <h3 align="center" style="color: blueviolet">The total of entered units equals <%=String.format("%.2f", t)%> at year <%=String.format("%.0f", y + 1)%></h3>
        <%
        } else {
        %>
        <h1 align="center">Units of Production Depreciation Table</h1>
        <table width="50%" align="center" border="3" bgcolor="HotPink">
            <col width="5%">
            <col width="20%">
            <col width="20%">
            <tr>
                <th align="center" bgcolor="MediumAquaMarine">YEAR</th>
                <th align="center" bgcolor="PapayaWhip">DEPRECIATION</th>
                <th align="center" bgcolor="LightSalmon">ACCUM. DEPRECIATION</th>
            </tr>
            <%
                for (int i = 0; i < unitArr.length; i++) {
                    double row = Double.parseDouble(unitArr[i]);
            %>
            <tr>
                <td align="center" bgcolor="MediumAquaMarine"><%=i + 1%></td>
                <td align="center" bgcolor="PapayaWhip"><%=String.format("$%.2f", row * (c - s) / t)%></td>
                <td align="center" bgcolor="LightSalmon"><%=String.format("$%.2f", a += (row * (c - s) / t))%></td>
            </tr>    
            <%
                }
            %>
        </table>
        <%
            }
        } catch (Exception ex) {
        %>
        <br/>   
        <h2 align="center" style="color: red">You did NOT complete all the information.</h2>
        <h2 align="center" style="color: red">Please return to the previous page to COMPLETE it.</h2>
        <%
            }
        %>
    </body>
</html>
