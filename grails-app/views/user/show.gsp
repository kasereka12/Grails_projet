<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="show-user" class="col-12 content scaffold-show" role="main">
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:link class="btn btn-info float-end" action="index">Back To user List</g:link>
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Property</th>
                            <th>Value
                                <g:form resource="${this.user}" method="DELETE" class="d-flex justify-content-between float-end">
                                    <fieldset class="buttons d-flex">
                                        <g:link class="edit btn btn-primary" action="edit" resource="${this.user}">
                                            <g:message code="default.button.edit.label" default="Edit" />
                                        </g:link>
                                        <input class="delete btn btn-danger" type="submit" value="${message(code: 'default.button.delete.label', default: 'Delete')}"
                                               onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');" />
                                    </fieldset>
                                </g:form>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Username</td>
                            <td><g:fieldValue bean="${user}" field="username" /></td>
                        </tr>

                        <tr>
                            <td>Account Enabled</td>
                            <td><g:fieldValue bean="${user}" field="enabled" /></td>
                        </tr>
                        <tr>
                            <td>Account Expired</td>
                            <td><g:fieldValue bean="${user}" field="accountExpired" /></td>
                        </tr>
                        <tr>
                            <td>Account Locked</td>
                            <td><g:fieldValue bean="${user}" field="accountLocked" /></td>
                        </tr>
                        <tr>
                            <td>Password Expired</td>
                            <td><g:fieldValue bean="${user}" field="passwordExpired" /></td>
                        </tr>
                        <tr>
                            <td>Permissions</td>
                            <td>
                                <g:each in="${user.authorities}" var="role">
                                    ${role.authority}
                                </g:each>
                            </td>
                        </tr>
                        <tr>
                            <td>Todos</td>
                            <td>
                                <ul>
                                    <g:each in="${user.todos}" var="todo">
                                        <li>
                                            <g:link controller="todo" action="show" id="${todo.id}">${todo.title}</g:link>
                                        </li>
                                    </g:each>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
