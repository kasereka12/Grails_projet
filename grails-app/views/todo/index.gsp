<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
    <style>
    .table-hover tbody tr:hover {
        background-color: rgba(0,0,0,.02);
    }
    .inner-table {
        background: #f8f9fa;
        border-radius: 8px;
        margin: 0;
    }
    .inner-table th {
        font-size: 0.9rem;
        color: #6c757d;
    }
    .action-buttons {
        display: flex;
        gap: 0.5rem;
        flex-wrap: wrap;
    }
    .todo-link {
        color: #0d6efd;
        text-decoration: none;
        font-weight: 500;
    }
    .todo-link:hover {
        color: #0a58ca;
        text-decoration: underline;
    }
    .elements-container {
        background: #f8f9fa;
        border-radius: 8px;
        padding: 1rem;
    }
    .element-table {
        margin-bottom: 0.5rem;
    }
    .add-element-btn {
        width: 32px;
        height: 32px;
        padding: 0;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    </style>
</head>
<body>
<div id="content" role="main">
    <div class="container">
        <section class="row">
            <div id="list-todo" class="col-12 content scaffold-list" role="main">
                <g:if test="${flash.message}">
                    <div class="alert alert-info alert-dismissible fade show" role="status">
                        ${flash.message}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </g:if>
                <div class="card mb-4 shadow-sm">
                    <div class="card-header bg-white d-flex justify-content-between align-items-center py-3">
                        <h5 class="mb-0">
                            <i class="fas fa-tasks me-2"></i>Todo List
                        </h5>
                        <g:link class="btn btn-primary" action="create">
                            <i class="fas fa-plus me-2"></i>
                            <g:message code="default.new.label" args="[entityName]"/>
                        </g:link>
                    </div>
                    <div class="card-body p-0">
                        <table id="datatablesSimple" class="table table-hover mb-0">
                            <thead class="bg-light">
                            <tr>
                                <th>Title</th>
                                <th>Description</th>
                                <th>Collaborators</th>
                                <th>Author</th>
                                <th>Elements</th>
                                <th>Actions</th>
                            </tr>
                            </thead>
                            <tbody>
                            <g:each in="${todoList}" var="todo">
                                <tr>
                                    <td>
                                        <g:link action="show" id="${todo.id}" class="todo-link">
                                            ${todo.title}
                                        </g:link>
                                    </td>
                                    <td>
                                        <span class="text-muted">${todo.description}</span>
                                    </td>
                                    <td>
                                        <table class="table table-sm inner-table">
                                            <thead>
                                            <tr>
                                                <th>Name</th>
                                                <th>Actions</th>
                                            </tr>
                                            </thead>
                                            <tbody>
                                            <g:each in="${todo.collaborators}" var="collaborator">
                                                <tr>
                                                    <td>
                                                        <i class="fas fa-user-circle me-2"></i>
                                                        ${collaborator.username}
                                                    </td>
                                                    <td>
                                                        <g:link params='[todoId: todo.id, userId: collaborator.id]'
                                                                action="deleteCollaborator"
                                                                class="btn btn-danger btn-sm">
                                                            <i class="fas fa-trash-alt"></i>
                                                        </g:link>
                                                    </td>
                                                </tr>
                                            </g:each>
                                            </tbody>
                                        </table>
                                    </td>
                                    <td>
                                        <span class="badge bg-primary">
                                            <i class="fas fa-user me-1"></i>
                                            ${todo.author.username}
                                        </span>
                                    </td>
                                    <td>
                                        <div class="elements-container">
                                            <table class="table table-sm element-table">
                                                <thead>
                                                <tr>
                                                    <th>Title</th>
                                                    <th>Description</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                <g:each in="${todo.elements}" var="element">
                                                    <tr>
                                                        <td>
                                                            <g:link action="show" controller="element"
                                                                    id="${element.id}"
                                                                    class="todo-link">
                                                                ${element.title}
                                                            </g:link>
                                                        </td>
                                                        <td>${element.description}</td>
                                                    </tr>
                                                </g:each>
                                                </tbody>
                                            </table>
                                            <a href="/element/create?id=${todo.id}"
                                               class="btn btn-outline-primary btn-sm add-element-btn">
                                                <i class="fas fa-plus"></i>
                                            </a>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="action-buttons">
                                            <g:if test="${todo.author == user}">
                                                <button class="btn btn-outline-success btn-sm"
                                                        data-bs-toggle="modal"
                                                        data-bs-target="#addCollaboratorModal"
                                                        data-todo-id="${todo.id}">
                                                    <i class="fas fa-user-plus me-1"></i>
                                                    Collaborateur
                                                </button>
                                            </g:if>

                                            <g:form resource="${todo}" method="DELETE" class="d-inline">
                                                <g:link class="btn btn-warning btn-sm"
                                                        action="edit"
                                                        resource="${todo}">
                                                    <i class="fas fa-edit me-1"></i>
                                                    Éditer
                                                </g:link>
                                                <button class="btn btn-danger btn-sm"
                                                        onclick="return confirm('${message(code: 'default.button.delete.confirm.message', default: 'Are you sure?')}');">
                                                    <i class="fas fa-trash-alt me-1"></i>
                                                    Supprimer
                                                </button>
                                            </g:form>
                                        </div>
                                    </td>
                                </tr>
                            </g:each>
                            </tbody>
                        </table>
                    </div>
                </div>
                <g:if test="${todoCount > params.int('max')}">
                    <div class="pagination justify-content-center">
                        <g:paginate total="${todoCount ?: 0}" />
                    </div>
                </g:if>
            </div>
            <div class="modal fade" id="addCollaboratorModal" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">
                                <i class="fas fa-user-plus me-2"></i>
                                Ajouter un collaborateur
                            </h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                        </div>

                        <div class="modal-body">
                            <form method="post" action="${createLink(controller: 'todo', action: 'addCollaborators')}">
                                <div class="mb-3">
                                    <label for="collaborator" class="form-label">Username du collaborateur</label>
                                    <input type="text"
                                           class="form-control"
                                           name="collaborator"
                                           id="collaborator"
                                           placeholder="Entrer le username"
                                           required />
                                </div>

                                <div class="mb-3">
                                    <label for="permission" class="form-label">Permission</label>
                                    <select name="permission" id="permission" class="form-select">
                                        <g:each in="${permissions}" var="permission">
                                            <option value="${permission}">${permission}</option>
                                        </g:each>
                                    </select>
                                </div>

                                <input type="hidden" name="todoId" id="todoId" value="" />

                                <div class="d-flex justify-content-end gap-2">
                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                        <i class="fas fa-times me-1"></i>Fermer
                                    </button>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-check me-1"></i>Ajouter
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const openModalLinks = document.querySelectorAll('button[data-bs-target="#addCollaboratorModal"]');
        openModalLinks.forEach(link => {
            link.addEventListener('click', function() {
                const todoId = this.getAttribute('data-todo-id');
                document.getElementById('todoId').value = todoId;
            });
        });
    });
</script>
</body>
</html>