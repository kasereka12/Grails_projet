package emsi.mbds.todolist

import grails.gorm.transactions.Transactional
import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

@Secured(['ROLE_ADMIN' , 'ROLE_USER'])
@Transactional
class TodoController {

    TodoService todoService
    UploadService uploadService
    SpringSecurityService springSecurityService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    //Affiche l'index des TODOs
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def user = springSecurityService.getCurrentUser()
        def permissions = RoleCollaborators.values();
        def userId =  user.id;
        if (user.authorities.any { it.authority == 'ROLE_ADMIN' }) {
            respond todoService.list(params), model: [user: user,todoCount: todoService.count(), permissions: permissions]
        } else {
            def todos = Todo.findAllByAuthor(user as User, params)
            def todos1 = Todo.executeQuery(
                    'SELECT t FROM Todo t JOIN t.collaborators c WHERE c.id = :userId',
                    [userId: userId]
            )
            todos1.each { todo ->
                println "Todo: ${todo.title}, Description: ${todo.description}, Date Création: ${todo.dateCreated}, Dernière Mise à Jour: ${todo.lastUpdated}"
            }
            def allTodos = todos + todos1;
            def finaltodos = allTodos.toSet()
            respond finaltodos.toList(), model: [user: user, todoCount: allTodos.size(), permissions: permissions]
        }
    }
    //Supprime un Collaborateur
    def deleteCollaborator(Long todoId, Long userId) {
        def todo = todoService.get(todoId)
        def user = User.get(userId)
        if (todo && user) {
            todo.collaborators.remove(user)
            todo.save(flush: true)
        }
        redirect(action: 'index')
    }
    //Ajoute un Collaborateur
    def addCollaborators(Long todoId, String collaborator, String permission) {
        def user = User.findByUsername(collaborator)
        if (!user) {
            flash.message = "Collaborator not found."
            redirect(action: 'index')
            return
        }
        def todo = Todo.get(todoId)
        println("voila le todo ID "+todoId)
        if (!todo) {
            flash.message = "Todo not found."
            redirect(action: 'index')
            return
        }
        todo.addToCollaborators(user)
        if (!todo.save(flush: true)) {
            todo.errors.allErrors.each { println it }  // Log errors if save fails
        }
        def collaboratorPermission = new Permission(todo: todo, user: user, role: permission).save()
        flash.message = "Collaborator added successfully with permission: ${permission}"
        redirect(action: 'index')
    }
    //Affiche une TODO
    def show(Long id) {
        respond todoService.get(id)
    }
    //Cree une TODO
    def create() {
        def user = springSecurityService.getCurrentUser()
        def todo = new Todo()
        todo.title = params.title
        todo.description = params.description
        todo.permissions = new ArrayList<Permission>()
        todo.permissions.add(new Permission(todo: todo, user: user as User, role: RoleCollaborators.owner) )
        todo.author = user as User
        respond todo, model: [user: user]
    }
    //Appeler à chaque sauvegarde
    def save() {
        def user = springSecurityService.getCurrentUser()
        def todo = new Todo(params)
        todo.author = user as User
        todo.permissions = new ArrayList<Permission>()
        todo.permissions.add(new Permission(todo: todo, user: user as User, role: RoleCollaborators.owner))
        todo.author = user as User
        if (todo.save(flush: true)) {
            redirect(action: "show", id: todo.id)
        } else {
            respond todo.errors, view: 'create', model: [user: user]
        }
    }
    //Edit une Todo
    def edit(Long id) {
        def user = springSecurityService.getCurrentUser()
        def todo = todoService.get(id)
        if (!todo) {
            flash.message = "Todo not found."
            redirect(action: 'index')
            return
        }
        def authoritiesList = user.authorities*.authority
        def hasAdminRole = authoritiesList.contains("ROLE_ADMIN")
        def hasPermission = (todo.permissions.any {
            it.user == user ||
                    it.role == RoleCollaborators.editor || it.role == RoleCollaborators.owner
        } || hasAdminRole)
        if (!hasPermission) {
            flash.message = "You do not have permission to edit this Todo."
            redirect(action: 'index')
            return
        }
        respond todo
    }
    //Pour les modification
    def update(Todo todo) {
        if (todo == null) {
            notFound()
            return
        }
        try {
            todoService.save(todo)
        } catch (ValidationException e) {
            respond todo.errors, view:'edit'
            return
        }
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'todo.label', default: 'Todo'), todo.id])
                redirect todo
            }
            '*'{ respond todo, [status: OK] }
        }
    }
//Enfin la suppression
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        todoService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'todo.label', default: 'Todo'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'todo.label', default: 'Todo'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
