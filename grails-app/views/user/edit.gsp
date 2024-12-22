<!DOCTYPE html>
<html>
    <head>
        <meta name="layout" content="main" />
        <g:set var="entityName" value="${message(code: 'user.label', default: 'User')}" />
        <title><g:message code="default.edit.label" args="[entityName]" /></title>
    </head>
    <body>
    <div id="content" role="main">
        <div class="container">

            <section class="row">
                <div id="edit-user" class="col-12 content scaffold-edit" role="main">


                    <g:if test="${flash.message}">
                    <div class="message" role="status">${flash.message}
                    </div>
                    </g:if>
                    <g:hasErrors bean="${this.user}">
                    <ul class="errors" role="alert">
                        <g:eachError bean="${this.user}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
                        </g:eachError>
                    </ul>
                    </g:hasErrors>

                    <form action="/user/update/2" method="post">
                        <input type="hidden" name="_method" value="PUT" id="_method" />
                        <input type="hidden" name="version" value="${user.version}" id="version" />
                        <fieldset class="form p-4 shadow-sm rounded bg-light">
                            <h3 class="mb-4 text-center">Edit User</h3>
                            <g:link class="btn btn-secondary me-2 float-end" action="index">
                                <i class="fi fi-br-arrow-small-left"></i>
                            </g:link>
                            <div class="form-group mb-3">
                                <label for="password" class="form-label">Password
                                    <span class="text-danger">*</span>
                                </label>
                                <g:passwordField name="password" value="${user.password}" id="password" class="form-control" />
                            <small class="form-text text-muted">Leave like this if you don't want to change the password.</small>
                            </div>
                            <div class="form-group mb-3">
                                <label for="username" class="form-label">Username
                                    <span class="text-danger">*</span>
                                </label>
                                <g:textField name="username" value="${user.username}" required="true" id="username" class="form-control" />
                            </div>
                            <div class="form-check mb-3">
                                <g:checkBox name="passwordExpired" checked="${user.passwordExpired}" class="form-check-input" />
                                <label for="passwordExpired" class="form-check-label">Password Expired</label>
                            </div>
                            <div class="form-check mb-3">
                                <g:checkBox name="accountLocked" checked="${user.accountLocked}" class="form-check-input" />
                                <label for="accountLocked" class="form-check-label">Account Locked</label>
                            </div>
                            <div class="form-check mb-3">
                                <g:checkBox name="accountExpired" checked="${user.accountExpired}" class="form-check-input" />
                                <label for="accountExpired" class="form-check-label">Account Expired</label>
                            </div>
                            <div class="form-check mb-3">
                                <g:checkBox name="enabled" checked="${user.enabled}" class="form-check-input" />
                                <label for="enabled" class="form-check-label">Enabled</label>
                            </div>
                        </fieldset>
                        <fieldset class="buttons text-center mt-4">
                            <button type="submit" class="btn btn-success btn-lg">Update</button>
                        </fieldset>
                    </form>
                </div>
            </section>
        </div>
    </div>
    </body>
</html>
