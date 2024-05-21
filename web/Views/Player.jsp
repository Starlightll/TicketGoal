<%-- 
    Document   : Player
    Created on : May 18, 2024, 6:17:23 PM
    Author     : mosdd
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
        <link rel="stylesheet" href="./css/player.css"/>
    </head>
    <body>
        <%@include file="/Views/include/header.jsp" %>
        <main>
            <div class="sidebar__box">
                
                <form method="POST">
                    <select name="role">
                        <option>Goalkeeper</option>
                        <option>Defender</option>
                    </select>
                    
                </form>
            </div>

            <div class="player__box">
                <div class="search__box">
                    <input type="text" name="search"/>
                    <a href="#AddPlayer" class="" > <span>Add New Player</span></a>
                    
                </div>
                
                <div class="role">
                    <h1>Role name</h1>
                </div>
                <div class="card__box">

                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>   
                            <div class="player__name">
                                <span><a href="DetailPlayer">Player name</a></span>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/Cristiano_Ronaldo.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>

                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="player__number">
                            <p>99</p>
                            <img src="./img/player/numberBanner.png" alt="alt"/>
                        </div>
                        <div class="card__content">
                            <img src="./img/player/lionel-messi.jpg" alt="alt"/>   
                            <div class="player__name">
                                <p>Player name</p>
                            </div>
                        </div>
                    </div>
                    


                </div>
            </div>
        </main>
        <%@include file="/Views/include/footer.jsp" %>
    </body>
</html>
