<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main"/>
    <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}"/>
    <title><g:message code="default.create.label" args="[entityName]"/></title>
</head>
<style>

</style>
<body>
<div id="content" role="main">
    <div class="container">
        <section class="row">
            <div id="create-user" class="col-12 content scaffold-create" role="main">
                <div class="d-flex justify-content-between align-items-center">
                    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
                    <g:link class="btn btn-info" action="index">Back To userList</g:link>
                </div>
                <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}</div>
                </g:if>
                <g:hasErrors bean="${this.user}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.user}" var="error">
                            <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                    error="${error}"/></li>
                        </g:eachError>
                    </ul>
                </g:hasErrors>
                <g:form resource="${this.user}" method="POST" class="container mt-4">
                    <fieldset class="form-group">
                        <div class="mb-3">
                            <label for="username" class="form-label">Username
                                <span class="text-danger">*</span>
                            </label>
                            <input type="text" name="username" value="" required="" id="username" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password
                                <span class="text-danger">*</span>
                            </label>
                            <input type="password" name="password" value="" required="" id="password" class="form-control">
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">Rôle
                                <span class="text-danger">*</span>
                            </label>
                            <g:select name="role" from="${roleList}" optionKey="id" optionValue="authority" class="form-select" />
                        </div>
                    </fieldset>
                    <fieldset class="form-group text-center">
                        <g:submitButton name="create" class="btn btn-primary"
                                        value="${message(code: 'default.button.create.label', default: 'Create')}"/>
                    </fieldset>
                </g:form>
            </div>
        </section>
    </div>
</div>
</body>
</html>
