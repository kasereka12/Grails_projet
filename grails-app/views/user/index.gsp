<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.list.label" args="[entityName]"/></title>
</head>

<body>
<div id="content" role="main">
    <div class="container">
        <section class="row">
            <div id="list-user" class="col-12 content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between">
                        <span><i class="fas fa-table me-1"></i>User List</span>
                        <g:link class="btn btn-secondary" action="create">
                            <g:message code="default.new.label" args="[entityName]"/>
                        </g:link>
                    </div>
                    <div class="card-body">
                        <table id="datatablesSimple">
                            <thead>
                            <tr>
                                <th >Username</th>
                                <th>Role</th>
                                <th>Todos</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th >Username</th>
                                <th>Role</th>
                                <th>Todos</th>
                            </tr>
                            </tfoot>
                            <tbody>
                            <g:each in="${userList}" var="user">
                                <tr>
                                    <td>
                                        <g:link action="show"
                                                id="${user.id}"
                                                class="text-primary text-decoration-none fw-semibold">
                                            ${fieldValue(bean: user, field: "username")}
                                        </g:link>
                                    </td>
                                    <td>
                                        <g:each in="${user.getAuthorities()*.authority}" var="authority" status="i">
                                            <span class="badge bg-secondary rounded-pill">${authority}</span>
                                        </g:each>
                                    </td>
                                    <td>
                                        <ul class="list-group list-group-flush">
                                            <g:each in="${user.todos}" var="todo">
                                                <li class="list-group-item border-0 px-0 py-1">
                                                    <g:link controller="todo"
                                                            action="show"
                                                            id="${todo.id}"
                                                            class="btn btn-outline-secondary btn-sm text-decoration-none">
                                                        ${todo.title}
                                                    </g:link>
                                                </li>
                                            </g:each>
                                        </ul>
                                    </td>
                                </tr>
                            </g:each>

                            </tbody>
                        </table>
                    </div>
                </div>
                <g:if test="${userCount > params.int('max')}">
                    <div class="pagination">
                        <g:paginate total="${userCount ?: 0}"/>
                    </div>
                </g:if>
            </div>

        </section>
    </div>
</div>
</body>
</html>