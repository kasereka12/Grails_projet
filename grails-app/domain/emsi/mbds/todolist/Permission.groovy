package emsi.mbds.todolist

class Permission {
    User user;
    Todo todo;
    RoleCollaborators role;
    static belongsTo = [user: User, todo: Todo]
    static constraints = {
        user nullable: true , blank: false
        todo nullable: true, blank: true

    }

}
