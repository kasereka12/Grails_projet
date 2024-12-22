<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Welcome to TODOLISTS </title>
</head>
<body>
<div id="content" role="main">
    <div class="container py-5">
        <header class="text-center mb-5 p-5 bg-gradient rounded-3 shadow-sm" style="background: linear-gradient(135deg, #6B73FF 0%, #000DFF 100%);">
            <h1 class="display-4 text-black mb-3">Admin Dashboard</h1>
            <p class="lead text-black-50">Welcome to the TodoList Administration Panel. Manage your tasks and users easily.</p>
        </header>
        <section class="row g-4 mb-5">
            <sec:ifAnyGranted roles="ROLE_ADMIN">
                <div class="col-lg-6 col-md-6">
                    <div class="card border-0 shadow-sm h-100 transition-transform">
                        <div class="card-body p-4">
                            <div class="d-flex align-items-center mb-3">
                                <div class="rounded-circle bg-primary bg-opacity-10 p-3 me-3">
                                    <i class="fas fa-users fa-2x text-primary"></i>
                                </div>
                                <h5 class="card-title mb-0">Total Users</h5>
                            </div>
                            <p class="display-5 fw-bold mb-4 text-primary">${totalUsers}</p>
                            <a href="${createLink(controller: 'user', action: 'index')}"
                               class="btn btn-outline-primary d-flex align-items-center justify-content-center gap-2">
                                <i class="fas fa-cog"></i>
                                Manage Users
                            </a>
                        </div>
                    </div>
                </div>
            </sec:ifAnyGranted>
            <div class="<sec:ifNotGranted roles='ROLE_ADMIN'>mx-auto</sec:ifNotGranted> col-lg-6 col-12">
                <div class="card border-0 shadow-sm h-100 transition-transform">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-3">
                            <div class="rounded-circle bg-success bg-opacity-10 p-3 me-3">
                                <i class="fas fa-tasks fa-2x text-success"></i>
                            </div>
                            <h5 class="card-title mb-0">Total Todos</h5>
                        </div>
                        <p class="display-5 fw-bold mb-4 text-success">${totalTodos}</p>
                        <a href="${createLink(controller: 'todo', action: 'index')}"
                           class="btn btn-outline-success d-flex align-items-center justify-content-center gap-2">
                            <i class="fas fa-list"></i>
                            Manage Todos
                        </a>
                    </div>
                </div>
            </div>
        </section>
        <!-- Quick Actions Section -->
        <section class="card border-0 shadow-sm">
            <div class="card-header bg-dark text-white p-4">
                <h4 class="mb-0">
                    <i class="fas fa-bolt me-2"></i>
                    Quick Actions
                </h4>
            </div>
            <div class="card-body p-4">
                <div class="row g-4">
                    <!-- Create Todo Card -->
                    <div class="<sec:ifNotGranted roles='ROLE_ADMIN'>mx-auto</sec:ifNotGranted> col-lg-6 col-12">
                        <a href="${createLink(controller: 'todo', action: 'create')}" class="text-decoration-none">
                            <div class="card h-100 border-0 shadow-sm hover-card">
                                <div class="card-body p-4 text-center">
                                    <div class="rounded-circle bg-primary bg-opacity-10 p-4 mx-auto mb-4" style="width: fit-content;">
                                        <i class="fas fa-plus-circle fa-3x text-primary"></i>
                                    </div>
                                    <h5 class="card-title text-dark">Create New Todo</h5>
                                    <p class="text-muted">Add a new task to your list</p>
                                </div>
                            </div>
                        </a>
                    </div>
                    <sec:ifAnyGranted roles="ROLE_ADMIN">
                        <div class="col-lg-6 col-12">
                            <a href="${createLink(controller: 'user', action: 'create')}" class="text-decoration-none">
                                <div class="card h-100 border-0 shadow-sm hover-card">
                                    <div class="card-body p-4 text-center">
                                        <div class="rounded-circle bg-success bg-opacity-10 p-4 mx-auto mb-4" style="width: fit-content;">
                                            <i class="fas fa-user-plus fa-3x text-success"></i>
                                        </div>
                                        <h5 class="card-title text-dark">Add New User</h5>
                                        <p class="text-muted">Create a new user account</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </sec:ifAnyGranted>
                </div>
            </div>
        </section>


        <style>
        .transition-transform {
            transition: transform 0.3s ease;
        }
        .transition-transform:hover {
            transform: translateY(-5px);
        }
        .hover-card {
            transition: all 0.3s ease;
        }
        .hover-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 1rem 3rem rgba(0,0,0,.175)!important;
        }
        .rounded-circle {
            transition: all 0.3s ease;
        }
        .card:hover .rounded-circle {
            transform: scale(1.1);
        }
        </style>
    </div>
</div>

</body>
</html>
