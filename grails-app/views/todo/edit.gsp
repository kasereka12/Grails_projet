<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="edit-todo" class="col-12 content scaffold-edit" role="main">
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${this.todo}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.todo}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                    </g:hasErrors>
                    <g:form resource="${this.todo}" method="PUT">
                        <g:hiddenField name="version" value="${this.todo?.version}" />
                        <form action="/todo/update/${todo.id}" method="post">
                            <input type="hidden" name="_method" value="PUT" id="_method" />
                            <input type="hidden" name="version" value="${todo.version}" id="version" />
                            <fieldset class="form p-4 shadow-sm rounded bg-light">
                                <h3 class="mb-4 text-center">Edit Todo</h3>
                                <div class="container">
                                    <div class="d-flex justify-content-end">
                                        <g:link class="btn btn-secondary me-2" action="index">
                                            <g:message code="default.list.label" args="[entityName]" />
                                        </g:link>
                                        <g:link class="btn btn-primary" action="create">
                                            <g:message code="default.new.label" args="[entityName]" />
                                        </g:link>
                                    </div>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="title" class="form-label">Title
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" name="title" value="${todo.title}" required id="title" class="form-control" />
                                </div>
                                <div class="form-group mb-3">
                                    <label for="description" class="form-label">Description
                                        <span class="text-danger">*</span>
                                    </label>
                                    <input type="text" name="description" value="${todo.description}" required id="description" class="form-control" />
                                </div>
                                <div class="form-group mb-3">
                                    <label for="collaborators" class="form-label">Collaborators</label>
                                    <ul class="list-unstyled mb-2">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Username</th>
                                                <th>Actions
                                                </th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${todo.collaborators}" var="collaborator">
                                                <tr>
                                                    <td>${collaborator.id}</td>
                                                    <td>${collaborator.username}</td>
                                                    <td>
                                                        <a href="/todo/removeCollaborator/${todo.id}/${collaborator.id}" class="btn btn-danger btn-sm">Supprimer</a>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>

                                    </ul>
                                <g:if test="${todo.author == user }">
                                    <a class="btn btn-outline-success"
                                       href="#addCollaboratorModal"
                                       data-bs-toggle="modal"
                                       data-bs-target="#addCollaboratorModal"
                                       data-todo-id="${todo.id}">Ajouter collaborateur</a>
                                </g:if>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="permissions" class="form-label">Permissions</label>
                                    <ul class="list-unstyled mb-2">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Role</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${todo.permissions}" var="permission">
                                                <tr>
                                                    <td>${permission.id}</td>
                                                    <td>${permission.role}</td>
                                                    <td>

                                                        <a href="/todo/removePermission/${todo.id}/${permission.id}" class="btn btn-warning btn-sm">Modifier</a>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>

                                    </ul>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="elements" class="form-label">Elements</label>
                                    <ul class="list-unstyled mb-2">
                                        <table class="table table-bordered">
                                            <thead>
                                            <tr>
                                                <th>#</th>
                                                <th>Title</th>
                                                <th>Description</th>
                                                <th>Checked</th>
                                                <th>Type</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${todo.elements}" var="element">
                                                <tr>
                                                    <td>${element.id}</td>
                                                    <td>
                                                        <a href="/element/show/${element.id}">${element.title}</a>
                                                    </td>
                                                    <td>${element.description}</td>
                                                    <td>
                                                        <g:checkBox name="isChecked" value="${element.isChecked}" disabled="true"/>
                                                    </td>
                                                    <td>
                                                        <p>  ${element.fileType} <p/>
                                                    </td>
                                                    <td>
                                                        <a href="/element/edit/${element.id}" class="btn btn-warning btn-sm">Edit</a>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>
                                    </ul>
                                    <a href="/element/create?id=${todo.id}" class="btn btn-outline-primary btn-sm">Add Element</a>
                                </div>
                            </fieldset>
                            <fieldset class="buttons text-center mt-4">
                                <button type="submit" class="btn btn-success btn-lg">Update</button>
                            </fieldset>
                        </form>
                    </g:form>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
