<%-- 
    Document    : DepreciationCalculator
    Created on  : Oct 27, 2019, 6:15:14 PM
    Author      : Pikulkaew Boonpeng
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
                int y = Integer.parseInt(request.getParameter("year"));
                String m = request.getParameter("method");
                double a = 0; //accum. depreciation

                if (m.equals("SL")) {
        %>
        <h1 align="center">Straight-Line Depreciation Table</h1>
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
                for (int i = 1; i <= y; i++) {
                    double row = (c - s) / y;
            %>
            <tr>
                <td align="center" bgcolor="MediumAquaMarine"><%=i%></td>
                <td align="center" bgcolor="PapayaWhip"><%=String.format("$%.2f", row)%></td>
                <td align="center" bgcolor="LightSalmon"><%=String.format("$%.2f", a += row)%></td>
            </tr>
            <%
                }
            %>
        </table>
        <%
        } else if (m.equals("SYD")) {
        %>
        <h1 align="center">Sum-of-The-Year's-Digits Depreciation Table</h1>
        <table width="50%" align="center" border="3" bgcolor="HotPink">
            <col width="5%">
            <col width="20%">
            <col width="20%">
            <tr>
                <th align="center" bgcolor="MediumAquaMarine">YEAR</th>
                <th align="center" bgcolor="PapayaWhip">DEPRECIATION</th>
                <th align="center" bgcolor="LightSalmon">ACCUM. DEPRECIATION</th>
            </tr>
            <%                    int forNumerator = y;
                double S = ((y * (y + 1)) / 2.0);
                for (int i = 1; i <= y; i++) {
                    double row = forNumerator / S * (c - s);
            %>
            <tr>
                <td align="center" bgcolor="MediumAquaMarine"><%=i%></td>
                <td align="center" bgcolor="PapayaWhip"><%=String.format("$%.2f", row)%></td>
                <td align="center" bgcolor="LightSalmon"><%=String.format("$%.2f", a += row)%></td>
            </tr>    
            <%
                    forNumerator--;
                }
            %>
        </table>
        <%
        } else if (m.equals("DDB")) {
        %>
        <h1 align="center">Double Declining Balance Depreciation Table</h1>
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
                double forMul = c;
                for (int i = 1; i <= y; i++) {
                    double row = (2.0 / y) * forMul;
                    if (i == y) {
                        row = (c - s) - a; //adjust the last year
                    }
            %>
            <tr>
                <td align="center" bgcolor="MediumAquaMarine"><%=i%></td>
                <td align="center" bgcolor="PapayaWhip"><%=String.format("$%.2f", row)%></td>
                <td align="center" bgcolor="LightSalmon"><%=String.format("$%.2f", a += row)%></td>
            </tr>
            <%
                    forMul -= row;
                }
            %>
        </table>
        <%
        } else if (m.equals("UP")) {
        %>
        <form action="UnitsOfProductTable.jsp" method="get">
            <h1 align="center">Units of Production Depreciation Calculator</h1>
            <h3 align="center" style="color: green">Enter the total units over the useful life of the asset</h3>
            <h3 align="center" style="color: green">Total Units: <input type="text" name="totalUnits" size="20"></h3>

            <input type="hidden" name="cost" value="<%=c%>" />
            <input type="hidden" name="scrap" value="<%=s%>" />
            <input type="hidden" name="year" value="<%=y%>" />
            <input type="hidden" name="method" value="<%=m%>" />

            <table width="30%" align="center">
                <tr>
                    <th align="center" bgcolor="MediumAquaMarine">YEAR</th>
                    <th align="center" bgcolor="Salmon">AMOUNT</th>
                </tr>
                <%
                    for (int i = 1; i <= y; i++) {
                %>
                <tr>
                    <th align="center" bgcolor="MediumAquaMarine"><%out.print(i); %></th>
                    <th align="center" bgcolor="Salmon"><input type="text" name="unit" size="20"></th>
                </tr>
                <%
                    }
                %>
            </table>
            <p align="center">
                <input type="submit" value="Submit">
                <input type="reset" value="Clear">
            </p>
        </form>
        <%
            }
        } catch (Exception ex) {
        %>
        <br/>   
        <h2 align="center" style="color: red">You did NOT complete all the information.</h2>
        <h2 align="center" style="color: red">Please return to the previous page to COMPLETE it.</h2>
        <%
            } // ================ end try-catch ==========================================
        %>
    </body>
</html>