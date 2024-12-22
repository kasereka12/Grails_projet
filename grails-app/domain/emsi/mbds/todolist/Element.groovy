package emsi.mbds.todolist



class Element {

    String title
    String description
    Boolean isChecked = Boolean.FALSE
    FileType fileType = FileType.text
    String filepath = "None"
    Todo todo
    static belongsTo = [todo: Todo]
    static constraints = {
        title nullable: false, blank: false
        description nullable: true, blank: true
        isChecked nullable: false
        fileType nullable: false
        filepath nullable: true
    }

    static mapping = {
        description type: "text"
    }
}
