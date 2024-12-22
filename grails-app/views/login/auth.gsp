<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Login</title>
</head>
<body>
<g:if test="${flash.message}">
    <div class="message">${flash.message}</div>
</g:if>
<div id="layoutAuthentication_content">
    <main>
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-5">
                    <div class="card shadow-lg border-0 rounded-lg mt-5">
                        <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                        <div class="card-body">
                            <form action="${postUrl ?: '/login/authenticate'}" method="POST" id="loginForm" class="form-signin" autocomplete="off">
                                <div class="form-floating mb-3">
                                    <input type="text" class="form-control" name="username" id="username" autocapitalize="none" required/>

                                    <label for="username">Nom d'utilisateur</label>
                                </div>
                                <div class="form-floating mb-3">
                                    <input type="password" class="form-control"  placeholder="Password" id="inputPassword" name="password" id="password" required/>
                                    <label for="inputPassword">Password</label>
                                </div>
                                <div class="form-check mb-3">
                                    <input class="form-check-input" id="inputRememberPassword" type="checkbox" value="" />
                                    <label class="form-check-label" for="inputRememberPassword">Remember Password</label>
                                </div>
                                <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                    <a class="small" href="password.html">Forgot Password?</a>
                                    <button class="btn  btn-secondary " type="submit">Se connecter</button>

                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </main>
</div>


</body>
</html>