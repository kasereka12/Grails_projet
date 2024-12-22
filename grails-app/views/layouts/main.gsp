<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <asset:stylesheet src="styles.css"/>
    <link rel='stylesheet' href='https://cdn-uicons.flaticon.com/2.6.0/uicons-regular-rounded/css/uicons-regular-rounded.css'>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
    <title>
        <g:layoutTitle default="Grails"/>
    </title>
    <g:layoutHead/>
</head>

<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <a class="navbar-brand ps-3" href="/">Admin Dashboard</a>
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!">
        <i class="fas fa-bars"></i>
    </button>
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4 ">
        <li class="nav-item dropdown">
            <sec:ifLoggedIn>
                <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                    <i class="fas fa-user fa-fw me-1"></i>
                    <sec:username/>
                </a>
                <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                    <li><hr class="dropdown-divider" /></li>
                    <li>
                        <form action="${createLink(controller: 'logout')}" method="POST">
                            <input type="submit" class="dropdown-item" value="Logout"/>
                        </form>
                    </li>
                </ul>
            </sec:ifLoggedIn>
            <sec:ifNotLoggedIn>
                <a class="nav-link float-end" href="${createLink(controller: 'login', action: 'auth')}">
                    <i class="fas fa-sign-in-alt me-1"></i>Login
                </a>
            </sec:ifNotLoggedIn>
        </li>
    </ul>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading">Core</div>
                    <a class="nav-link" href="/">
                        <div class="sb-nav-link-icon"><i class="fas fa-home"></i></div>
                        Home
                    </a>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <g:link class="nav-link" action="index" controller="user">
                            <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>
                            Users
                        </g:link>
                    </sec:ifAnyGranted>
                    <g:link class="nav-link" controller="todo" action="index">
                        <div class="sb-nav-link-icon"><i class="fas fa-tasks"></i></div>
                        Todos
                    </g:link>
                </div>
            </div>
            <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                <sec:ifLoggedIn>
                    <div class="d-flex align-items-center">
                        <i class="fas fa-user-circle me-2"></i>
                        <span><sec:username/></span>
                    </div>
                </sec:ifLoggedIn>
                <sec:ifNotLoggedIn>
                    <div class="text-muted">
                        <i class="fas fa-user-slash me-2"></i>
                        Non connecté
                    </div>
                </sec:ifNotLoggedIn>
            </div>
        </nav>
    </div>

    <div id="layoutSidenav_content">
        <main>
        <div class="container-fluid px-4">
        <g:layoutBody/>
        </div>
        </main>
        <footer class="py-4 bg-light mt-auto">
        <div class="container-fluid px-4">
            <div class="d-flex align-items-center justify-content-between small">
                <div class="text-muted">Copyright &copy; daniel & RHYS 2024</div>
                <div>
                    <a href="/">Privacy Policy</a>
                    &middot;
                    <a href="/">Terms &amp; Conditions</a>
                </div>
            </div>
        </div>
      </footer>
    </div>
<div class="footer" role="contentinfo">
    <div class="container-fluid">
        <div class="row">

        </div>
    </div>
</div>

<div id="spinner" class="spinner" style="display:none;">
    <g:message code="spinner.alt" default="Loading&hellip;"/>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<asset:javascript src="scripts.js"></asset:javascript>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<asset:javascript src="chart-area-demo.js"></asset:javascript>
<asset:javascript src="chart-bar-demo.js"></asset:javascript>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<asset:javascript src="datatables-simple-demo.js"></asset:javascript>
</body>
</html>
