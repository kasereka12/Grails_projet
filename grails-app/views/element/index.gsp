<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'element.label', default: 'Element')}" />
        <title><g:message code="default.list.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="list-element" class="col-12 content scaffold-list" role="main">
                    <g:if test="${flash.message}">
                        <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <div class="container mt-4">
                        <h2 class="text-center mb-4">List of Elements</h2>
                        <g:link class="btn btn-secondary float-end" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link>
                        <table class="table table-bordered table-hover table-striped">
                            <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Checked</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:if test="${elementList?.size() > 0}">
                                <g:each in="${elementList}" var="element" status="index">
                                    <tr>
                                        <td>${index + 1}</td>
                                        <td>
                                            <g:link action="show" controller="element" id="${element.id}">${element.title}</g:link>
                                        </td>
                                        <td>${element.description}</td>
                                        <td>
                                            <input type="checkbox" <g:if test="${element.isChecked}">checked</g:if> disabled>
                                        </td>
                                    </tr>
                                </g:each>
                            </g:if>
                            <g:else>
                                <tr>
                                    <td colspan="4" class="text-center">No elements found</td>
                                </tr>
                            </g:else>
                            </tbody>
                        </table>
                    </div>
                    <g:if test="${elementCount > params.int('max')}">
                    <nav aria-label="Page navigation" class="d-flex justify-content-center mt-3">
                        <ul class="pagination">
                            <g:paginate total="${elementCount ?: 0}"
                                        next="&raquo;"
                                        prev="&laquo;"
                                        class="page-link"
                                        paginationWrapper="pagination"
                                        previousClass="page-item"
                                        nextClass="page-item"
                                        pageClass="page-item" />
                        </ul>
                    </nav>
                </g:if>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>