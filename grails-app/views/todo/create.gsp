<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="create-todo" class="col-12 content scaffold-create" role="main">
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
                    <g:form resource="${todo}" method="POST" class="p-4 shadow-sm rounded bg-light">
                        <fieldset class="form">
                            <div class="d-flex justify-content-between align-items-center">
                                <h3 class="mb-4 text-center">Create Todo</h3>

                                <g:link class="btn btn-info" action="index">Back To todoList</g:link>
                            </div>
                            <div class="form-group mb-3">
                                <label for="title" class="form-label">Title <span class="text-danger">*</span></label>
                                <g:textField name="title" value="${todo?.title}" required="true" id="title" class="form-control" />
                            </div>
                            <div class="form-group mb-3">
                                <label for="description" class="form-label">Description <span class="text-danger">*</span></label>
                                <g:textArea name="description" value="${todo?.description}" required="true" id="description" class="form-control" rows="3" />
                            </div>
                            <div class="form-group mb-3 d-none">
                                <label for="author" class="form-label">Author</label>
                                <input type="text" value="${user?.username}" name="author.username" id="author" class="form-control" readonly />
                                <g:hiddenField name="author.id" value="${user?.id}" />
                            </div>
                        </fieldset>
                        <fieldset class="buttons text-center">
                            <g:submitButton name="create" class="btn btn-success btn-lg" value="${message(code: 'default.button.create.label', default: 'Create')}" />
                        </fieldset>
                    </g:form>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
