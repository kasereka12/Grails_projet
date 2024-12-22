package emsi.mbds.todolist

import grails.plugin.springsecurity.SpringSecurityService
import grails.plugin.springsecurity.annotation.Secured
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*


@Secured(['ROLE_USER' , 'ROLE_ADMIN'])
class ElementController {
    ElementService elementService
    SpringSecurityService springSecurityService
    TodoService todoService
    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
//Affiche les elements
    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        def user = springSecurityService.getCurrentUser()
        def todos = todoService.findAllByAuthor(user)
        def elements = []
        todos.each { todo ->
            def todoElements = elementService.findAllByTodo(todo)
            elements.addAll(todoElements)
        }
        respond elements, model:[elementCount: elementService.count()]
    }
    //Affiche un element
    def show(Long id) {
        respond elementService.get(id)
    }
    //Cree un element

    def create(Long id) {
        def todo = todoService.get(id)
        def element = new Element(
                todo: todo,
                fileType: FileType.text
        )
        respond element, model: [todo: todo]
    }
    //Save un element
    def save(Element element) {
        if (!element) {
            notFound()
            return
        }
        def todo = todoService.get(params.long('todo.id'))
        if (!todo) {
            notFound()
            return
        }
        element.todo = todo
        if (element.fileType != FileType.wisywig) {
            handleFileUpload(element)
        }
        try {
            elementService.save(element)
            redirect controller: 'todo', action: 'show', id: todo.id
        } catch (ValidationException e) {
            respond element.errors, view: 'create', model: [todo: todo]
        }
    }
    //Permet la sauvegarde du wysiwygelement
    def wysiwygElement(Long id) {
        def todo = todoService.get(id)
        def element = new Element(
                todo: todo,
                fileType: FileType.wisywig
        )
        respond element, model: [todo: todo]
    }
    //POur le chargement du fichier
    private void handleFileUpload(Element element) {
        def uploadedFile = request.getPart('file')
        if (uploadedFile && uploadedFile.size > 0) {
            def uploadDir = setupUploadDirectory()
            def fileName = generateUniqueFileName(uploadedFile.submittedFileName)
            try {
                def file = new File(uploadDir, fileName)
                uploadedFile.inputStream.withStream { is ->
                    file.bytes = is.bytes
                }
                element.filepath = "uploads/${fileName}"
                log.info "File successfully saved to: ${file.absolutePath}"
            } catch (Exception e) {
                log.error "File upload failed", e
                throw new FileUploadException("Failed to upload file: ${e.message}")
            }
        }
    }
    //le choix du repertoire
    private static File setupUploadDirectory() {
        def projectRoot = new File("").absolutePath
        def uploadDir = new File(projectRoot, "grails-app/assets/uploads")
        if (!uploadDir.exists()) {
            uploadDir.mkdirs()
        }
        return uploadDir
    }
    //Generer un nom unique pour le fichier
    private static String generateUniqueFileName(String originalFilename) {
        return "${UUID.randomUUID()}-${originalFilename}"
    }

    //Pour l'edit de l'element
    def edit(Long id) {
        respond elementService.get(id)
    }

    //Pour l'update d'un element
    def update(Element element) {
        if (element == null) {
            notFound()
            return
        }
        try {
            elementService.save(element)
        } catch (ValidationException e) {
            respond element.errors, view:'edit'
            return
        }
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'element.label', default: 'Element'), element.id])
                redirect element
            }
            '*'{ respond element, [status: OK] }
        }
    }
    //Le delete d'un element
    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }
        elementService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'element.label', default: 'Element'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }
    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'element.label', default: 'Element'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }
}
