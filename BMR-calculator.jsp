<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>BMR Calculator</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 20px;
        }

        h1 {
            text-align: center;
            color: #333;
        }

        form {
            max-width: 400px;
            margin: 0 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: #666;
            font-weight: bold;
        }

        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
            margin-bottom: 20px;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

         button {
                    background-color: #D23954;
                    color: white;
                    padding: 10px 20px;
                    border: none;
                    border-radius: 4px;
                    cursor: pointer;
                    font-size: 16px;
                }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .result {
            background-color: #f9f9f9;
            padding: 10px;
            border-radius: 4px;
            margin-top: 20px;
        }

        .result p {
            margin: 0;
        }
    </style>
    <script>
        function clearForm() {
            document.getElementById("myForm").reset();
            document.getElementById("resultDiv").style.display = "none";
            var inputFields = document.querySelectorAll("#myForm input[type='number']");
            inputFields.forEach(function(field) {
                field.value = "";
            });
            var genderSelect = document.getElementById("gender");
            genderSelect.selectedIndex = 0; // Reset the gender select option to the default
        }
    </script>
</head>
<body>
    <h1>Calculate Your BMR</h1>
    <form id="myForm" method="post" action="BMR-calculator.jsp">

            <label for="height">Height (in cm):</label>
            <input type="number" name="height" id="height" required value="<%= request.getParameter("height") %>">

            <label for="weight">Weight (in kg):</label>
            <input type="number" name="weight" id="weight" required value="<%= request.getParameter("weight") %>">

            <label for="age">Age:</label>
            <input type="number" name="age" id="age" required value="<%= request.getParameter("age") %>">

            <label for="gender">Gender:</label>
            <select name="gender" id="gender" required>
                <option value="male" <%= request.getParameter("gender") != null && request.getParameter("gender").equals("male") ? "selected" : "" %>>Male</option>
                <option value="female" <%= request.getParameter("gender") != null && request.getParameter("gender").equals("female") ? "selected" : "" %>>Female</option>
            </select>

            <input type="submit" value="Calculate">
            <button type="button" onclick="clearForm()">Clear</button>
        </form>

    <%-- Calculate and display BMR result --%>
    <% double bmr = 0.0;
       double weight = 0.0;
       double height = 0.0;
       int age = 0;
       String gender = "";

       if (request.getMethod().equals("POST")) {
           weight = Double.parseDouble(request.getParameter("weight"));
           height = Double.parseDouble(request.getParameter("height"));
           age = Integer.parseInt(request.getParameter("age"));
           gender = request.getParameter("gender");

           if (gender.equals("male")) {
               bmr = 66 + (13.75 * weight) + (5 * height) - (6.75 * age);
           } else if (gender.equals("female")) {
               bmr = 655 + (9.56 * weight) + (1.85 * height) - (4.68 * age);
           }
         }

    %>

  <% if (bmr > 0.0) { %>
          <div id="resultDiv" class="result">
              <h2>Your BMR Result: <%= String.format("%.1f", bmr) %> Calories</h2>
          </div>
      <% } %>

</body>
</html>