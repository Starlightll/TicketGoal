<%-- Document : footer Created on : May 17, 2024, 11:25:34 AM Author : mosdd
--%> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>JSP Page</title>
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/remixicon/4.2.0/remixicon.css"
    />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@100..900&display=swap"
      rel="stylesheet"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
  </head>
  <body>
    <footer>
      <div class="main__content">
        <!-- Left box -->
        <div class="left box">
          <h2>About us</h2>
          <div class="content">
            <p>
              Lorem ipsum, dolor sit amet consectetur adipisicing elit. Quas
              perferendis atque voluptate enim, nihil deserunt ad magnam
              explicabo facere repellat molestiae optio debitis saepe pariatur
              similique inventore ipsam dicta consequatur.
            </p>
          </div>
        </div>

        <!-- Center box -->
        <div class="center box">
          <h2>Address</h2>
          <div class="content">
            <div class="place">
              <span class="ri ri-map-pin-2-fill"></span>
              <span class="text">Viet Nam, Hoa Lac</span>
            </div>
            <div class="phone">
              <span class="ri ri-phone-fill"></span>
              <span class="text">0862226803</span>
            </div>
            <div class="email">
              <span class="ri ri-mail-fill"></span>
              <span class="text">longnhhe170400@fpt.edu.vn</span>
            </div>
          </div>
        </div>

        <!-- Right box -->
        <div class="right box">
          <h2>Contact us</h2>
          <div class="content">
            <form action="#">
              <div class="email">
                <div class="text">Email *</div>
                <input type="email" required />
              </div>
              <div class="msg">
                <div class="text">Message *</div>
                <textarea rows="2" cols="25" required></textarea>
              </div>
              <div class="btn">
                <button type="submit">Send</button>
              </div>
            </form>
          </div>
        </div>
      </div>
      <div class="bottom">
        <center>
            <span class="credit">
                Created By <a href="#">TicketGoal</a> | 
            </span>
            <span class="ri-copyright-line"></span>
            <span> 2024 All rights reserved.</span>
        </center>
      </div>
    </footer>
  </body>
</html>
