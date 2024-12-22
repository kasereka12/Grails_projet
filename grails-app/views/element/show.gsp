<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'element.label', default: 'Element')}" />
        <title><g:message code="default.show.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="show-element" class="col-12 content scaffold-show" role="main">
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                            <h1 class="text-center">Element Details</h1>
                            <table class="table table-bordered table-striped mt-4">
                                <thead class="table-dark">
                                <tr>
                                    <th>Field</th>
                                    <th>Value
                                        <g:link class="btn btn-secondary float-end" action="index">Element list</g:link>
                                    </th>
                                </tr>
                                </thead>
                                <tbody>
                                <g:each in="${element.properties.keySet()}" var="field">
                                    <tr>
                                        <td>${field.capitalize()}</td>
                                        <td>
                                            <g:if test="${field == 'todo'}">
                                                <a href="/todo/show/${element.todo?.id}">${element.todo}</a>
                                            </g:if>
                                            <g:else>
                                                <g:fieldValue bean="${element}" field="${field}" />
                                            </g:else>
                                        </td>
                                    </tr>
                                </g:each>
                                </tbody>
                            </table>
                            <form action="/element/delete/${element?.id}" method="post" class="mt-3">
                                <input type="hidden" name="_method" value="DELETE" id="_method" />
                                <div class="d-flex justify-content-between">
                                    <a href="/element/edit/${element?.id}" class="btn btn-primary">Edit</a>
                                    <input class="btn btn-danger" type="submit" value="Delete" onclick="return confirm('Are you sure?');" />
                                </div>
                            </form>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
