<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main" />
    <g:set var="entityName" value="${message(code: 'todo.label', default: 'Todo')}" />
    <title><g:message code="default.list.label" args="[entityName]" /></title>
</head>
<body>
<div id="content" role="main">
    <div class="container">
        <section class="row">
            <a href="#list-todo" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
            <div class="nav" role="navigation">
                <ul>
                    <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
                    <li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
                </ul>
            </div>
        </section>

        <section class="row">
            <form method="post" action="${createLink(controller: 'todo', action: 'addCollaborators')}">
                <!-- Input for the collaborator's username -->
                <label>
                    <input type="text" name="collaborator" placeholder="Entrer le username du collaborateur" required/>
            </label>

                <!-- Dropdown for selecting permission -->
                <label>
                    <select name="permission">
                        <g:each in="${permissions}" var="permission">
                            <option value="${permission}">${permission}</option>
                        </g:each>
                    </select>
                </label>

                <!-- Hidden input for todoId -->
                <input type="hidden" name="todoId" value="${todoId}" />

                <!-- Submit button -->
                <button type="submit">Ajouter Collaborateur</button>
            </form>


        </section>
        <script type="text/javascript">
            // Initialize TinyMCE
            tinymce.init({
                selector: '#description', // Apply to the description textarea
                menubar: false,
                toolbar: 'undo redo | bold italic underline | bullist numlist | link image',
                plugins: 'link image lists', // Add necessary plugins
                height: 300, // Set the height of the editor
                content_style: "body { font-family:Helvetica,Arial,sans-serif; font-size:14px }"
            });
        </script>
    </div>
</div>
</body>
</html>

