<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="show-todo" class="col-12 content scaffold-show" role="main">
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <table class="table table-bordered">
                        <thead>
                        <tr>
                            <th>Property</th>
                            <th>Value
                                <g:link class="btn btn-danger float-end" action="index">Back</g:link></th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>Title</td>
                            <td><g:fieldValue bean="${todo}" field="title" /></td>
                        </tr>
                        <tr>
                            <td>Description</td>
                            <td><g:fieldValue bean="${todo}" field="description" /></td>
                        </tr>
                        <tr>
                            <td>Date Created</td>
                            <td><g:formatDate date="${todo.dateCreated}" format="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <td>Last Updated</td>
                            <td><g:formatDate date="${todo.lastUpdated}" format="yyyy-MM-dd HH:mm:ss" /></td>
                        </tr>
                        <tr>
                            <td>Elements</td>
                            <td>
                                <ul>
                                    <g:each in="${todo.elements}" var="element">

                                        <li>
                                            <g:link action="show" controller="element" id="${element.id}">${element.title}</g:link>
                                        </li>
                                    </g:each>
                                </ul>
                                <a href="/element/create?id=${todo.id}" class="btn btn-outline-primary btn-sm"><i class="fi fi-rr-plus"></i></a>

                            </td>
                        </tr>
                        <tr>
                            <td>Collaborators</td>
                            <td>
                                <ul>
                                    <g:each in="${todo.collaborators}" var="collaborator">
                                        <li>${collaborator.username}</li>
                                    </g:each>
                                </ul>
                            </td>
                        </tr>
                        <tr>
                            <td>Permissions</td>
                            <td>
                                    <g:each in="${todo.permissions}" var="permission">
                                        ${permission.role}
                                    </g:each>
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
