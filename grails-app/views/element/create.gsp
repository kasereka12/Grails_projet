<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'element.label', default: 'Element')}" />
        <title><g:message code="default.create.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">
            <section class="row">
                <div id="create-element" class="col-12 content scaffold-create" role="main">
                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                    </g:if>
                    <g:hasErrors bean="${this.element}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.element}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                    </g:hasErrors>
                    <div class="container-fluid py-5 bg-light">
                        <div class="container bg-white rounded shadow-sm p-4 mx-auto" style="max-width: 800px;">
                            <div class="d-flex justify-content-between align-items-center mb-4 bg-light p-3 rounded">
                                <span class="text-muted">
                                    Create with rich text
                                    <g:link action="WysiwygElement"
                                            params="[id: todo?.id]"
                                            class="text-primary text-decoration-none fw-bold">
                                        WYSIWYG Element
                                    </g:link>
                                </span>
                            </div>
                            <form method="POST" action="/element/save" class="needs-validation" novalidate  enctype="multipart/form-data">
                                <div class="card border-0">
                                    <div class="card-body">
                                        <div class="mb-3">
                                            <label for="title" class="form-label fw-semibold">
                                                Titre <span class="text-danger">*</span>
                                            </label>
                                            <input type="text"
                                                   id="title"
                                                   name="title"
                                                   class="form-control form-control-lg"
                                                   value="${element?.title}"
                                                   placeholder="Entrez le titre"
                                                   required>
                                        </div>
                                        <div class="mb-3">
                                            <label for="description" class="form-label fw-semibold">Description</label>
                                            <textarea id="description"
                                                      name="description"
                                                      class="form-control"
                                                      rows="4"
                                                      placeholder="Entrez la description">${element?.description}</textarea>
                                        </div>
                                        <div class="mb-3">
                                            <div class="form-check">
                                                <input type="checkbox"
                                                       class="form-check-input"
                                                       id="isChecked"
                                                       name="isChecked"
                                                       value="true"
                                                    ${element?.isChecked ? 'checked' : ''}>
                                                <label class="form-check-label" for="isChecked">
                                                    Is checked
                                                </label>
                                            </div>
                                        </div>
                                        <div class="mb-3">
                                            <label for="file" class="form-label fw-semibold"> You can upload a file</label>
                                            <input type="file" class="form-control" id="file" name="file">
                                        </div>
                                        <div class="mb-4">
                                            <label for="todo" class="form-label fw-semibold">Todo</label>
                                            <input type="hidden" id="todo" name="todo.id" value="${todo?.id}">
                                            <input type="text"
                                                   class="form-control"
                                                   value="${todo?.title}"
                                                   readonly>
                                        </div>
                                        <div class="d-grid gap-2">
                                            <button type="submit"
                                                    class="btn btn-primary btn-lg">
                                                Create
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
